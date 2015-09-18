/*-------------------------------------------------------------------------
 * Autor     : Peter Soltys
 * Projekt   : bakalarska praca "Procesor NIOS vo vlozenych aplikaciach"
 * Veduci    : doc. Ing. Milos Drutarovsky, PhD
 * Datum     : 28.marec 2015
 * Subor     : main.c
 * verzia    : 1.2
 * Hardver   : NIOS II
 *
 *
 *
 * Opis : Hlavny zdrojovy kod vyuzivajuci periferie vycitavajudi a zapisujuci
 *      hodnoty teplot na SD kartu s vytvorenim casovej znacky
 *-------------------------------------------------------------------------*/

#include <stdio.h>
#include "io.h"

#include "periferie/periferie.h"

/*
 * nastavovania programu
 */
#define INTERVAL             1 //1= sekundove/2= minutove intervaly
#define POCET_INTERVALOV     10 //pocet intervalov (sekund/minut)v rozmedzi 0-60
#define POCET_HODNOT         60//pocet hodnot ktore sa zapisu na SD kartu

                   //1=aktivne/0=neaktivne
#define KONZOLOVY_VYSTUP     1 //ak konzolovy vystup je zapnuty,
                               //system nedokaze fungovat autonomne
#define DEBUG                0 //pouzivane makro pri hladani chyb
/*
 * *****************************************************************************
 */

/*
 * globalne premenne
 */
struct time cas;
FATFS FatFs;
FIL fil;       /* File object */
FRESULT fr;    /* FatFs return code */
FILE * lcd;
uchar t1[9],t2[9],t3[9],t4[9];

/*
 * fnkcia vytvaracia casovy odstup v us
 * n=pocet us
 */
void wait_us(int n){
    uchar i=(ALT_CPU_FREQ/1000000);
    while(n--)
        i=(ALT_CPU_FREQ/1000000);
        while(i--);
}
/*
 * prevod BCD do int
 */
uchar bcd2i(uchar bcd) {
    uchar i=(bcd>>4)*10;
    return  i+(bcd&0x0f);
}
/*
 * prevod char do BCD
 */
uchar i2bcd(uchar n)
{
  return ((n / 10) << 4) | (n % 10);
}

/*
 * funkcia prevadza teplotu dvoch teplomerov s ROM1 ROM2
 * vstupne parametre su smerniky na vycitane registre
 */
void temperature(){
    uchar rom1[8];//ROM kod jedneho DS18B20 tepomera na zbernici
    uchar rom2[8];//ROM kod jedneho DS18B20 tepomera na zbernici
    uchar rom3[8];//ROM kod jedneho DS18B20 tepomera na zbernici
    uchar rom4[8];//ROM kod jedneho DS18B20 tepomera na zbernici

    rom1[0]=0x28;//bajt oznacujuci rodinu zariadenia
    rom1[1]=0x19;//bajty odlisujuce konkretne zariadenie
    rom1[2]=0x18;
    rom1[3]=0xB1;
    rom1[4]=0x06;
    rom1[5]=0x00;
    rom1[6]=0x00;
    rom1[7]=0x5E;//CRC bajt na overenie prijatej rom

    rom2[0]=0x28;//bajt oznacujuci rodinu zariadenia
    rom2[1]=0x76;//bajty odlisujuce konkretne zariadenie
    rom2[2]=0x61;
    rom2[3]=0xfe;
    rom2[4]=0x05;
    rom2[5]=0x00;
    rom2[6]=0x00;
    rom2[7]=0xb9;//CRC bajt na overenie prijatej rom

    rom3[0]=0x10;//bajt oznacujuci rodinu zariadenia
    rom3[1]=0x70;//bajty odlisujuce konkretne zariadenie
    rom3[2]=0xf8;
    rom3[3]=0xd8;
    rom3[4]=0x2;
    rom3[5]=0x8;
    rom3[6]=0x0;
    rom3[7]=0xdf;//CRC bajt na overenie prijatej rom

    rom4[0]=0x10;//bajt oznacujuci rodinu zariadenia
    rom4[1]=0x62;//bajty odlisujuce konkretne zariadenie
    rom4[2]=0xb8;
    rom4[3]=0xd8;
    rom4[4]=0x2;
    rom4[5]=0x8;
    rom4[6]=0x0;
    rom4[7]=0x3;//CRC bajt na overenie prijatej rom

    reset_onewire();//pre istotu resetujem zbernicu
    conversion_single();//prikaz pre konverziu
    /*
     * cakacia doba potrebnana prevod je pri
     * 9  bitovom rozliseni 95,75 ms
     * 10 bitovom rozliseni 187.5 ms
     * 11 bitovom rozliseni 375 ms
     * 12 bitovom rozliseni 750 ms
     * podla: http://datasheets.maximintegrated.com/en/ds/DS18B20.pdf
     */
    //wait_us(1000000);//v tomto pripade 12 bitove rozlisenie
    reset_onewire();
    read_tempreature(t1,rom1);//vycitanie hodnôt registrov
    read_tempreature(t2,rom2);//vycitanie hodnôt registrov
    read_tempreature(t3,rom3);//vycitanie hodnôt registrov
    read_tempreature(t4,rom4);//vycitanie hodnôt registrov

/*      //vypis jednotlivych rom na zbernici
    uchar i,j;
    for(j=0;j<5;j++){
        OWNext();
        for(i=0;i<8;i++){
            printf("rom%d[%d]=0x%x;\n",j,i,ROM_NO[i]);
        }
    }
*/
}
/*
 * funkcia konvertuje teplotu do podoby float
 * spravi konverziu aj zapornych hodnot, pre variabilne rozlisenie
 * param thermometer je smernik na registre teplomera
 * param resolution cislo urcujuce rozlisenie teplomera
 */
float convert_to_float(uchar* thermometer, uchar resolution){
    uchar tcopy[2];
    tcopy[0]=thermometer[0];
    tcopy[1]=thermometer[1];
    uchar i;
    float ret;
    short int tint=tcopy[1];
    tint = tint<<8;
    tint= tint | tcopy[0];
    ret = tint;
    for (i=0;resolution -8 > i;i++)
        ret /=2;
    return ret;
}
/*
 * funkcia vypise hodnoty teplot na LCD displej
 */
void LCD_print(void){
    LCD_PRINTF(lcd,"%c%s cas %X:%X:%X  \n",ESC,
            "[1;1H",cas.hour,cas.min,cas.sec);

    LCD_PRINTF(lcd," %+.0f",convert_to_float(t1,12));
    LCD_PRINTF(lcd," %+.0f",convert_to_float(t2,12));
//*******teplomery 3 a 4 maju nastavene 9 bitove rozlisenie********************
    LCD_PRINTF(lcd," %+.0f",convert_to_float(t3,9));
    LCD_PRINTF(lcd," %+.0f",convert_to_float(t4,9));
}


#if KONZOLOVY_VYSTUP

void konzola_print(void){
//*********************teplomery 1 a 2 maju rozlisenie 12 bitov****************
    printf("\nteplota rom1 rozlisenie 12b %+.4f",convert_to_float(t1,12));
    printf("\nteplota rom2 rozlisenie 12b %+.4f",convert_to_float(t2,12));
//*******teplomery 3 a 4 maju nastavene 9 bitove rozlisenie********************
    printf("\nteplota rom3 rozlisenie 9b %+.1f",convert_to_float(t3,9));
    printf("\nteplota rom4 rozlisenie 9b %+.1f",convert_to_float(t4,9));
}
#endif

/*
 * funkcia zapisuje hodnoty teplot do výstupneho suoru na SD karte
 * funkciaf_printf nepodporuje vypis premennej typu float, preto jej vypis
 * je uskutocneny alternativne
 * vystup je prestny pre teplomery s 9 bitovym rozlisenim
 */
void SD_print(void){
    fr=f_printf(&fil,"%X.%X.20%02X  %X:%X:%X",cas.date,cas.month,cas.year,
                    cas.hour,cas.min,cas.sec);//formatovany cas v txt subore
//*********************teplomery 1 a 2 maju rozlisenie 12 bitov************
    float tf1 = convert_to_float(t1,12);
    float tf2 = convert_to_float(t2,12);
    if (t1[1]&0xf0){//zaporne hodnoty teplot
        fr=f_printf(&fil,"\t %d,%04d",(int)tf1,((int)(tf1*10000)-((int)tf1)*10000)*(-1));
        }
    else{//kladne hodnoty teplot
        fr=f_printf(&fil,"\t +%d,%04d",(int)tf1,(int)(tf1*10000)-((int)tf1)*10000);
    }
#if KONZOLOVY_VYSTUP
        if (fr<0)printf("chyba %d",fr);
#endif
    if (t2[1]&0xf0){//zaporne hodnoty teplot
        fr=f_printf(&fil,"\t %d,%04d",(int)tf2,((int)(tf2*10000)-((int)tf2)*10000)*(-1));
        }
    else{//kladne hodnoty teplot
        fr=f_printf(&fil,"\t +%d,%04d",(int)tf2,(int)(tf2*10000)-((int)tf2)*10000);
    }
#if KONZOLOVY_VYSTUP
        if (fr<0)printf("chyba %d",fr);
#endif
//*******teplomery 3 a 4 maju nastavene 9 bitove rozlisenie********************
    uchar res;
    if(t3[0]&0x01) res=5;
    else res=0;
    if (t3[1]&0xf0){//zaporne hodnoty teplot
        fr=f_printf(&fil,"\t -%d,%d",!((t3[0]>>1)),res);
        }
    else{//kladne hodnoty teplot
        fr=f_printf(&fil,"\t +%d,%d",(t3[0]>>1),res);
    }
#if KONZOLOVY_VYSTUP
        if (fr<0)printf("chyba %d",fr);
#endif
    if(t4[0]&0x01) res=5;
        else res=0;
    if (t4[1]&0xf0){//zaporne hodnoty teplot
        fr=f_printf(&fil,"\t -%d,%d\n",!((t4[0]>>1)),res);
        }
    else{//kladne hodnoty teplot
        fr=f_printf(&fil,"\t +%d,%d\n",(t4[0]>>1),res);
    }
#if KONZOLOVY_VYSTUP
        if (fr<0)printf("chyba %d",fr);
#endif
}
/*
 * main je hlavna funkcia vyuzivajuca vsetky casti programu
 */
int main(void)
{
    lcd = LCD_OPEN();
    int i ;

#if KONZOLOVY_VYSTUP
    set_time();
#endif

    fr=f_mount(&FatFs, "", 0);//inicializacia SD karty
    //vytvorenie textoveho suboru
    fr = f_open(&fil, "teplota.txt" , FA_WRITE|FA_CREATE_ALWAYS);
#if KONZOLOVY_VYSTUP
    printf("vytvaram subor teplota");
    if(fr)printf("chyba pri vytvarani suboru %d \n",fr);
#endif
    f_printf(&fil,"datum     cas            T1in            T2in            T3out   T4out\n");//hlavicka v txt subore

    uchar last,lasti;

    for (i=0;i<POCET_HODNOT;i++){
        get_time(&cas);

        if( INTERVAL == 1)//nastavenie intervalu vzorkovania
            last=cas.sec;
        else if(INTERVAL == 2)
            last=cas.min;

        lasti=bcd2i(last);//hodnoty casu su ulozene v BCD formate
        if((lasti+POCET_INTERVALOV) >= 59)
            lasti+=(POCET_INTERVALOV-59);
        else
            lasti+=POCET_INTERVALOV;

        last=i2bcd(lasti);//spetna konverzia do BCD, potrebna pri porovnavani

#if INTERVAL == 1
    while(last!=cas.sec){
#endif
#if INTERVAL == 2
    while(last!=cas.min){
#endif
            get_time(&cas);
            temperature();
            LCD_print();
        }

#if KONZOLOVY_VYSTUP
        if (fr<0)printf("chyba f_printf pri vypise casu %d\n",fr);
        konzola_print();//vypisovanie teploty do konzoly
#endif

        SD_print();//vypisovanie teploty na SD kartu
    }
    fr=f_close(&fil);//koiec y8pisu na kartu
#if KONZOLOVY_VYSTUP
    printf("\nzatvaram\n");
    if(fr)printf("chyba pri zatvarani suboru %d\n",fr);
#endif

    while(1){//vypisovanie casu a teploty po ukonceni zapisu
        temperature();
        get_time(&cas);
        LCD_print();
    }
};
