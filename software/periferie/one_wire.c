/**-------------------------------------------------------------------------
 * @author    : Peter Soltys \n
 * Projekt  : bakalarska praca "Procesor NIOS vo vlozenych aplikaciach" \n
 * Veduci   : doc. Ing. Milos Drutarovsky, PhD \n
 * @date    : 12.februar 2015
 * @file    : one_wire.c
 * @version   : 1.2 \n
 * Hardver  : zbernica.vhd - synteticka zbernica 1-wire viac na stranke :
 *            http://www.maximintegrated.com/en/products/comms/one-wire.html\n
 *
 * Vytvorene funkcie :  void inicializacia(void)\n
 *                      void reset_onewire(void)\n
 *                      char read_tempreature_single(unsigned int a[9]);\n
 *                      char conversion_single(void);\n
 *                      char conversion(uchar b[8]);\n
 *                      char read_tempreature(uchar a[9],uchar b[8]);\n
 *                      char read_rom(uchar a[8]);\n
 *
 * Zdroj prehladavacieho algoritmu :\n
 * http://www.maximintegrated.com/en/app-notes/index.mvp/id/187\n
 * Upravene povodne funkcie :     int OWReset()\n
 *                                void OWWriteByte(uchar byte_value)\n
 *                                void OWWriteBit(uchar bit_value)\n
 *                                uchar OWReadBit()\n \n
 *
 * povodne funkcie :              int  OWFirst();\n
 *                                int  OWNext();\n
 *                                int  OWVerify();\n
 *                                void OWTargetSetup(uchar family_code);\n
 *                                void OWFamilySkipSetup();\n
 *                                int  OWReset();\n
 *                                void OWWriteByte(uchar byte_value);\n
 *                                void OWWriteBit(uchar bit_value);\n
 *                                uchar OWReadBit();\n
 *                                int  OWSearch();\n
 *                                uchar docrc8(uchar value);\n
 *
 * @brief : subor obsahuje nizkourovnove kody pre pracu s hardverom zbernica.vhd,
 *      {synteticky hardver - zbernica typu 1-wire viac na :
 *      http://www.maximintegrated.com/en/products/comms/one-wire.html)
 *      a komunikaciu so zariadenim DS18B20
 *      (http://datasheets.maximintegrated.com/en/ds/DS18B20.pdf)
 *-------------------------------------------------------------------------*/

#include "one_wire.h"

/**
 * funckia inicializuje 1-wire zbernicu, \n
 * nastavi frekvenciu + resetuje HW
 */
void inicializacia(void){
    CR_WR(RST_I);
    CD_WR(ALT_CPU_FREQ/500000);
}

/**
 *  funkcia resetuje HW intrene, \n
 * vynuluje vsetky vnutorne registre, taktiez sa znuluje BIT_MODE
 */
void reset_onewire(void){
    CR_WR(RST_I);//interny reset
}

#if SINGLE
/**
 * funkcia precita teplotu,registre zo zariadenia DS18B20, \n
 * citanie iba ak je na zbernici jedino zriadenie
 * @param REG[8] smernik vracajuci hodnotu vycitanych registrov
 * @return ak vrati 0 operacia prebehla uspesne, ak nie nastala chyba
 */
char read_temperature_single(uchar REG[9]){
    unsigned int i;

    inicializacia();
    reset_onewire();

    TX_WR(0xCC);//preskoc match ROM
    CR_WR(RST_SLOT|TX_SLOT);//prikaz reset+vysielanie
    while(CR_RD()&BUSY);//cakanie na ukoncenie vysielania

    if (!(CR_RD()&PRESENSE))return NO_PRESENSE;//kontrola presense pulzu

    TX_WR(0xBE);//prikaz posli teplotu
    CR_WR(CR_RD()|TX_SLOT);//prikaz vysielanie
    while(CR_RD()&BUSY);//cakanie na ukoncenie vysielania

    for (i=0;i<8;i++){
        CR_WR(CR_RD()|RX_SLOT);//primanie dat
        while(CR_RD()&BUSY);
        REG[i] = RX_RD();
        if (i==8 && CRC_RD()){
            return WRONG_CRC;
            //printf("chyba v CRC 0x%x",CRC_RD());
        }
    }

    return TRANSACTION_OK;//funkcia prebehla uspesne
}

/**
 * funkcia precita ROM jedneho zariadenia DS18B20 \n
 * je urcena pre pracu s jedinym zariadenim na zbernici
 * @param ROM[8] smernik vracauci ROM
 * @return ak vrati 0 operacia prebehla uspesne, ak nie nastala chyba
 */
char read_rom(uchar ROM[8])
{
    uchar i;

    inicializacia();
    reset_onewire();

    TX_WR(0x33);//prikaz posli ROM
    CR_WR(RST_SLOT|TX_SLOT);//prikaz vysielanie+reset
    while(CR_RD()&BUSY);//cakanie na ukoncenie vysielania

    if (!(CR_RD()&PRESENSE))return NO_PRESENSE;//kontrola presense pulzu

    for (i=0;i<=7;i++){
        CR_WR(CR_RD()|RX_SLOT);//primanie dat
        while(CR_RD()&BUSY);
        ROM[i]=RX_RD();
        if (i==7 && CRC_RD()){
            return WRONG_CRC;
        }
    }
    return TRANSACTION_OK;
}
#endif
/**
 * funkcia vysle prikaz do zariadenia/zariadeni DS18B20 na prevod teploty,\n
 * urcena pre pracu s jedinym zariadenim na zbernici. \n
 * Tuto funkciu mozno pouzit aj ak je na zbernici viacero zariadeni,\n
 * prevod sa vykona na vsetkych zariadeniach naraz
 * @return ak vrati 0 operacia prebehla uspesne, ak nie nastala chyba
 */
char conversion_single(void)
{
    inicializacia();
    reset_onewire();

    TX_WR(0xCC);//preskoc match ROM
    CR_WR(RST_SLOT|TX_SLOT);//prikaz reset+vysielanie
    while(CR_RD()&BUSY);// cakanie na ukoncenie vysielania

    if (!(CR_RD()&PRESENSE))return NO_PRESENSE;//kontrola presense pulzu

    TX_WR(0x44);//prikaz vykonaj konverziu teploty
    CR_WR(CR_RD()|TX_SLOT);
    while(CR_RD()&BUSY);

    return TRANSACTION_OK;//funkcia prebehla uspesne
}
/**
 * funkcia vysle prikaz do zariadenia DS18B20 na prevod teploty,\n
 * urcena pre pracu s viacerimi zariadeniami
 * @param ROM[8] vstupny smernik urcujuci konkretne zariadenie
 * @return ak vrati 0 operacia prebehla uspesne, ak nie nastala chyba
 */
char conversion(    uchar ROM[8])
{
    uchar i;

    inicializacia();
    reset_onewire();

    TX_WR(0x55);//match ROM
    CR_WR(RST_SLOT|TX_SLOT);//prikaz reset+vysielanie
    while(CR_RD()&BUSY);// cakanie na ukoncenie vysielania

    if (!(CR_RD()&PRESENSE))return NO_PRESENSE;//kontrola presense pulzu

    for (i=0;i<=7;i++){//rom
        TX_WR(ROM[i]);
        CR_WR(CR_RD()|TX_SLOT);
        while(CR_RD()&BUSY);
    }

    TX_WR(0x44);//prikaz vykonaj konverziu teploty
    CR_WR(CR_RD()|TX_SLOT);
    while(CR_RD()&BUSY);

    return TRANSACTION_OK;//funkcia prebehla uspesne
}
/**
 * funkcia precita registre,teplotu zo zariadenia DS18B20,\n
 * urcena pre pracu s viacerimi zariadeniami na zbernici
 * @param REG[9] vystupny smernik kde sa ulozia hodnoty registrov
 * @param ROM[8] vstupny smernik urcujuci konkretne zariadenie
 * @return ak vrati 0 operacia prebehla uspesne, ak nie nastala chyba
 */
char read_tempreature(uchar REG[9],uchar ROM[8])
{
    unsigned int i;

    inicializacia();
    reset_onewire();

    TX_WR(0x55);// match ROM
    CR_WR(RST_SLOT|TX_SLOT);//prikaz reset+vysielanie
    while(CR_RD()&BUSY);//cakanie na ukoncenie vysielania

    if (!(CR_RD()&PRESENSE))return NO_PRESENSE;//kontrola presense pulzu

    for (i=0;i<=7;i++){//rom
        TX_WR(ROM[i]);
        CR_WR(CR_RD()|TX_SLOT);
        while(CR_RD()&BUSY);
    }

    TX_WR(0xBE);//prikaz posli teplotu
    CR_WR(CR_RD()|TX_SLOT);//prikaz vysielanie
    while(CR_RD()&BUSY);//cakanie na ukoncenie vysielania
    reset_onewire();
    for (i=0;i<9;i++){
        CR_WR(CR_RD()|RX_SLOT);//primanie dat
        while(CR_RD()&BUSY);
        REG[i] = RX_RD();
        if (i==8 && CRC_RD()){
            return WRONG_CRC;
        }
    }
    return TRANSACTION_OK;
}


#if ROM_SEARCH
/*
 *
 * v nasledujucej casti sa nachadza implementacia kodu na vyhladavanie vsetkych
 * ROM na zbernici
 * zdroj : @see http://www.maximintegrated.com/en/app-notes/index.mvp/id/187
 * crc je mozne si overit aj vycitanim CRC registra @see CRC_RD() po prijati ROM
 *
 */


// global search state

int LastDiscrepancy;
int LastFamilyDiscrepancy;
int LastDeviceFlag;
uchar crc8;

//--------------------------------------------------------------------------
// 1-Wire Functions to be implemented for a particular platform
//--------------------------------------------------------------------------

//!--------------------------------------------------------------------------
//! Reset the 1-Wire bus and return the presence of any device
//! @return TRUE  : device present
//!         FALSE : no device present
//!
int OWReset()
{
    inicializacia();
    reset_onewire();
    return TRUE;
}

//!--------------------------------------------------------------------------
//!  Send 8 bits of data to the 1-Wire bus
//!
void OWWriteByte(uchar byte_value)
{
    TX_WR(byte_value);//vysielanie bytu
    CR_WR(RST_SLOT|TX_SLOT);//prikaz vysielanie+reset+hladanie
    while(CR_RD()&BUSY);//cakanie na ukoncenie vysielania
}

//!--------------------------------------------------------------------------
//!  Send 1 bit of data to teh 1-Wire bus
//!
void OWWriteBit(uchar bit_value)
{
    while(CR_RD()&BUSY);//pockaj na ukoncenie primania/vysielania
    TX_WR(bit_value);//zapis bitu na vysielanie
    CR_WR(CR_RD()|BIT_MODE|TX_SLOT);//nastav bitovy mod + vysielanie bitu

}
//--------------------------------------------------------------------------
//! Read 1 bit of data from the 1-Wire bus
//! @return 1 : bit read is 1
//!         0 : bit read is 0
//!
uchar OWReadBit()
{
   while(CR_RD()&BUSY);//cakanie na ukoncenie vysielanie/primania
   CR_WR(BIT_MODE|RX_SLOT);//nastavenie bit_modu + primanie 1 bitu
   while(!(CR_RD()&BIT_VALID));//cakanie kym bude vycitany bit platny
   if (RX_RD()&0x80)return 1;
   return 0;
}

// TEST BUILD
static uchar dscrc_table[] = {
        0, 94,188,226, 97, 63,221,131,194,156,126, 32,163,253, 31, 65,
      157,195, 33,127,252,162, 64, 30, 95,  1,227,189, 62, 96,130,220,
       35,125,159,193, 66, 28,254,160,225,191, 93,  3,128,222, 60, 98,
      190,224,  2, 92,223,129, 99, 61,124, 34,192,158, 29, 67,161,255,
       70, 24,250,164, 39,121,155,197,132,218, 56,102,229,187, 89,  7,
      219,133,103, 57,186,228,  6, 88, 25, 71,165,251,120, 38,196,154,
      101, 59,217,135,  4, 90,184,230,167,249, 27, 69,198,152,122, 36,
      248,166, 68, 26,153,199, 37,123, 58,100,134,216, 91,  5,231,185,
      140,210, 48,110,237,179, 81, 15, 78, 16,242,172, 47,113,147,205,
       17, 79,173,243,112, 46,204,146,211,141,111, 49,178,236, 14, 80,
      175,241, 19, 77,206,144,114, 44,109, 51,209,143, 12, 82,176,238,
       50,108,142,208, 83, 13,239,177,240,174, 76, 18,145,207, 45,115,
      202,148,118, 40,171,245, 23, 73,  8, 86,180,234,105, 55,213,139,
       87,  9,235,181, 54,104,138,212,149,203, 41,119,244,170, 72, 22,
      233,183, 85, 11,136,214, 52,106, 43,117,151,201, 74, 20,246,168,
      116, 42,200,150, 21, 75,169,247,182,232, 10, 84,215,137,107, 53};

//!--------------------------------------------------------------------------
//! Calculate the CRC8 of the byte value provided with the current
//! global 'crc8' value.
//! @return current global crc8 value
//
uchar docrc8(uchar value)
{
   // See Application Note 27

   // TEST BUILD
   crc8 = dscrc_table[crc8 ^ value];
   return crc8;
}

//--------------------------------------------------------------------------
//! Find the 'first' devices on the 1-Wire bus
//! @return TRUE  : device found, ROM number in ROM_NO buffer
//!         FALSE : no device present
//
int OWFirst()
{
   // reset the search state
   LastDiscrepancy = 0;
   LastDeviceFlag = FALSE;
   LastFamilyDiscrepancy = 0;

   return OWSearch();
}

//--------------------------------------------------------------------------
//! Find the 'next' devices on the 1-Wire bus
//! @return TRUE  : device found, ROM number in ROM_NO buffer
//!         FALSE : device not found, end of search
//
int OWNext()
{
   // leave the search state alone
   return OWSearch();
}

//--------------------------------------------------------------------------
//! Perform the 1-Wire Search Algorithm on the 1-Wire bus using the existing
//! search state.
//! @return TRUE  : device found, ROM number in ROM_NO buffer
//!         FALSE : device not found, end of search
//
int OWSearch()
{
   int id_bit_number;
   int last_zero, rom_byte_number, search_result;
   int id_bit, cmp_id_bit;
   uchar rom_byte_mask, search_direction;

   // initialize for search
   id_bit_number = 1;
   last_zero = 0;
   rom_byte_number = 0;
   rom_byte_mask = 1;
   search_result = 0;
   crc8 = 0;

   // if the last call was not the last one
   if (!LastDeviceFlag)
   {
      // 1-Wire reset
      if (!OWReset())
      {
         // reset the search
         LastDiscrepancy = 0;
         LastDeviceFlag = FALSE;
         LastFamilyDiscrepancy = 0;
         return FALSE;
      }
      // issue the search command
      OWWriteByte(0xF0);


      // loop to do the search
      do
      {
         // read a bit and its complement
          id_bit = OWReadBit();
          cmp_id_bit = OWReadBit();



         // check for no devices on 1-wire
         if ((id_bit == 1) && (cmp_id_bit == 1))
            break;
         else
         {
            // all devices coupled have 0 or 1
            if (id_bit != cmp_id_bit)
               search_direction = id_bit;  // bit write value for search
            else
            {
               // if this discrepancy if before the Last Discrepancy
               // on a previous next then pick the same as last time
               if (id_bit_number < LastDiscrepancy)
                  search_direction = ((ROM_NO[rom_byte_number] & rom_byte_mask) > 0);
               else
                  // if equal to last pick 1, if not then pick 0
                  if (id_bit_number == LastDiscrepancy)
                      search_direction = 1;
                  else
                      search_direction = 0;

               // if 0 was picked then record its position in LastZero
               if (search_direction == 0)
               {
                  last_zero = id_bit_number;

                  // check for Last discrepancy in family
                  if (last_zero < 9)
                     LastFamilyDiscrepancy = last_zero;
               }
            }

            // set or clear the bit in the ROM byte rom_byte_number
            // with mask rom_byte_mask
            if (search_direction == 1)
              ROM_NO[rom_byte_number] |= rom_byte_mask;
            else
              ROM_NO[rom_byte_number] &= ~rom_byte_mask;

            // serial number search direction write bit
            OWWriteBit(search_direction);

            // increment the byte counter id_bit_number
            // and shift the mask rom_byte_mask
            id_bit_number++;
            rom_byte_mask <<= 1;

            // if the mask is 0 then go to new SerialNum byte rom_byte_number and reset mask
            if (rom_byte_mask == 0)
            {
                docrc8(ROM_NO[rom_byte_number]);  // accumulate the CRC
                rom_byte_number++;
                rom_byte_mask = 1;
            }
         }
      }
      while(rom_byte_number < 8);  // loop until through all ROM bytes 0-7

      // if the search was successful then
      if (!((id_bit_number < 65) || (crc8 != 0)))
      {
         // search successful so set LastDiscrepancy,LastDeviceFlag,search_result
         LastDiscrepancy = last_zero;

         // check for last device
         if (LastDiscrepancy == 0)
            LastDeviceFlag = TRUE;

         search_result = TRUE;
      }
   }

   // if no device found then reset counters so next 'search' will be like a first
   if (!search_result || !ROM_NO[0])
   {
      LastDiscrepancy = 0;
      LastDeviceFlag = FALSE;
      LastFamilyDiscrepancy = 0;
      search_result = FALSE;
   }

   return search_result;
}

//--------------------------------------------------------------------------
//! Verify the device with the ROM number in ROM_NO buffer is present.
//! @return TRUE  : device verified present
//!        FALSE : device not present
//
int OWVerify()
{
   uchar rom_backup[8];
   int i,rslt,ld_backup,ldf_backup,lfd_backup;

   // keep a backup copy of the current state
   for (i = 0; i < 8; i++)
      rom_backup[i] = ROM_NO[i];
   ld_backup = LastDiscrepancy;
   ldf_backup = LastDeviceFlag;
   lfd_backup = LastFamilyDiscrepancy;

   // set search to find the same device
   LastDiscrepancy = 64;
   LastDeviceFlag = FALSE;

   if (OWSearch())
   {
      // check if same device found
      rslt = TRUE;
      for (i = 0; i < 8; i++)
      {
         if (rom_backup[i] != ROM_NO[i])
         {
            rslt = FALSE;
            break;
         }
      }
   }
   else
     rslt = FALSE;

   // restore the search state
   for (i = 0; i < 8; i++)
      ROM_NO[i] = rom_backup[i];
   LastDiscrepancy = ld_backup;
   LastDeviceFlag = ldf_backup;
   LastFamilyDiscrepancy = lfd_backup;

   // return the result of the verify
   return rslt;
}

//--------------------------------------------------------------------------
//! Setup the search to find the device type 'family_code' on the next call
//! to OWNext() if it is present.
//
void OWTargetSetup(uchar family_code)
{
   int i;

   // set the search state to find SearchFamily type devices
   ROM_NO[0] = family_code;
   for (i = 1; i < 8; i++)
       ROM_NO[i] = 0;
   LastDiscrepancy = 64;
   LastFamilyDiscrepancy = 0;
   LastDeviceFlag = FALSE;
}

//--------------------------------------------------------------------------
//! Setup the search to skip the current device type on the next call
//! to OWNext().
//
void OWFamilySkipSetup()
{
   // set the Last discrepancy to last family discrepancy
   LastDiscrepancy = LastFamilyDiscrepancy;
   LastFamilyDiscrepancy = 0;

   // check for end of list
   if (LastDiscrepancy == 0)
      LastDeviceFlag = TRUE;
}
#endif
/*
 * priklad pouzitia ROM_SEARCH
 */
/*
int main(void)
{
    int i;
    for(i=0;i<8;i++){
            ROM_NO[i]=0;
        }
    OWReset();
    OWFirst();//vyhladanie prvej ROM

    while(1){
        for(i=0;i<8;i++){//vypis ROM
            printf("byte  %d  0x%x \n",i,ROM_NO[i]);
        }
        printf("crc  0x%x \n",CRC_RD());//kontrola ak CRC=0 prijmanie bolo bez chyb
        getchar();//cakanie na znak
        OWNext();//vyhladanie dalsej ROM
    }
};
*/
