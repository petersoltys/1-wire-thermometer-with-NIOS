/*-----------------------------------------------------------------
 * i2c.c - I2C interface library
 *-----------------------------------------------------------------
 * $Id: i2c.c,v 2.0 2009/11/21, R. Beuchat from C.Gaudin Exp $
 *-----------------------------------------------------------------
 * Author   : $Author: cgaudin, rbeuchat $
 * Revision : $Revision: 2.0 $
 * Date     : $Date: 2009/11/21  $
 *
 * Upravil  : Peter Soltys
 * Projekt  : bakalarska praca "Procesor NIOS vo vlozenych aplikaciach"
 * Veduci   : doc. Ing. Milos Drutarovsky, PhD
 * Datum    : 22.februar 2015
 * Subor    : i2c.c
 * verzia   : 1.2
 *
 * Base_i2c je definovana v subore i2c.h riadok 24
 *
 * vytvorene funkcie : char get_time(struct time *cas)
 *                     void set_time(void)
 *                     char get_num(void)
 * opis :
 * funkcie ovaladajuce zbernicu i2c s implementovanymi funkciami
 * ovladajuce RTC obvod
 *
 *-----------------------------------------------------------------*/

#include <system.h>
#include <stdio.h>
#include "i2c.h"



/* wait for end of transfer */
#define WAIT_FOR_EOT(t) { while ((t=IORD_I2C_SR()) & I2C_TIP); int i; for (i=100; i<1;) i++;; }


/*
 * Set Serial Clock Speed in hz
 */
void i2c_set_speed(int speed_in_hz)
{
  int div = (ALT_CPU_FREQ/1000) / (4 * speed_in_hz);

  if ((ALT_CPU_FREQ/1000) % (4 * speed_in_hz))
    div++;

  IOWR_I2C_CD((uchar)div);

  /* wait a while */
  //nr_delay(1);
}

/*
 * Set FAST mode (400 kHz)
 */
void i2c_fastmode()
{
  i2c_set_speed(400);
}

/*
 * Set NORMAL mode (100 kHz)
 */
void i2c_normal_mode()
{
  i2c_set_speed(100);
}

/*
 * write one byte to a device on I2C bus
 */

/* Set register index (no data write)  */
char i2c_write_index(uchar index )
{
  uchar t;

  WAIT_FOR_EOT(t);                   // Wait to be Ready for new access

  IOWR_I2C_DR(I2C_RTC_ADDR & 0xFE );    // M41T00 address and Write
  IOWR_I2C_CR(I2C_START | I2C_WRITE );    // Start and Address send

  WAIT_FOR_EOT(t);                   // Wait to be Ready for new access

  if ( t & I2C_LRA ) return I2C_ENODEV; // End if no Ack received

  IOWR_I2C_DR(index );                // M41T00 regsiter to access
  IOWR_I2C_CR(I2C_WRITE );            // Write it

  WAIT_FOR_EOT(t);                  // Wait to be Ready for new access

  if ( t & I2C_LRA ) return I2C_EBADACK; // End if no Ack received

  IOWR_I2C_DR(0);                 // Acknowledge IRQ bit

  return 0;
}
/*
 * Write to a M41T00 register
 */
char i2c_single_register_write(
             uchar index ,
             uchar value )
{
  int rc;
  uchar t;

  if ((rc=i2c_write_index(index & 0x7F )) < 0)
    return rc;                    // Index send with error -> end

  IOWR_I2C_DR( value );            // Data to send in the register
  IOWR_I2C_CR( I2C_WRITE | I2C_STOP );    // Value and STOP

  WAIT_FOR_EOT(t);                 // Wait to be Ready for new access

  if (t & I2C_LRA) return I2C_EBADACK; // End if no Ack received

  IOWR_I2C_DR(0);                 // Acknowledge IRQ bit

  return 0;
}

/*
 * Read a M41T00 register
 */
char i2c_single_register_read(
                uchar index ,
                uchar *value )
{
  char rc;
  uchar t;

  /* set index */
  rc=i2c_write_index(index & 0x7F);
  if (rc < 0)
    return rc;                     // Index send with error -> end

  IOWR_I2C_DR( I2C_RTC_ADDR | 0x01 );    // M41T00 address + read
  IOWR_I2C_CR( I2C_WRITE | I2C_START );    // Start + address and Read

  WAIT_FOR_EOT(t);                 // Wait to be Ready for new access

  if ( t & I2C_LRA )  return I2C_ENODEV;    //Ack received ?

  t = IORD_I2C_SR();                // Send the SCL for read access
  IOWR_I2C_CR( I2C_READ | I2C_STOP | I2C_NO_ACK);

  WAIT_FOR_EOT(t);                 // Wait to be Ready for new access

  (*value) = IORD_I2C_DR();            // Data received
  return 0;
}

char  get_time(struct time *cas){
    char t;
    uchar data[8],i;

    i2c_normal_mode();//inicializacia I2C a nastavenie rychlosti 100KHz
    t=i2c_write_index(0x00 & 0x7F );//zapis startovacej adresy na vycitavanie
    if(t<0) return t;//testovanie na chybu

    IOWR_I2C_DR( I2C_RTC_ADDR | 0x01 );// M41T00 adresa + prikaz citaj
    IOWR_I2C_CR( I2C_WRITE | I2C_START );// Start + adresa + prikaz citaj

    WAIT_FOR_EOT(t);// cakanie na ukoncenie vysielania/prijimania

    if ( t & I2C_LRA )  return I2C_ENODEV ;//testovanie na chybu

    for (i=0;i<7;i++)//vycitavanie 7 registrov
            {
            IOWR_I2C_CR( I2C_READ );//vysielanie hodinovych impulzov pre citanie

            WAIT_FOR_EOT(t);// cakanie na ukoncenie vysielania/prijimania

            data[i] = IORD_I2C_DR();//vycitavanie prijateho bytu
            }
    //citanie posledneho registra + zakoncenie komunikacie
    IOWR_I2C_CR( I2C_READ | I2C_STOP | I2C_NO_ACK );
    WAIT_FOR_EOT(t);// cakanie na ukoncenie vysielania/prijimania

    data[7] = IORD_I2C_DR();//vycitavanie prijateho bytu

    cas->sec = data[0]&0x7f;//formatovanie prijatych dat
    cas->min = data[1]&0x7f;
    cas->hour = data[2]&0x3f;
    cas->day = data[3]&0x07;
    cas->date = data[4]&0x3f;
    cas->month = data[5]&0x1f;
    cas->year = data[6];
    cas->control = data[7];

    return 0;
}


//funkcia ziskava cislo z konzoloveho vstupu pre potreby funkcie set_time
char get_num(void){
    uchar in,in2;
    in=(getchar()-'0');//nacitaj znak a konvertuj
    in2=getchar();
    if(in2!='\n'){
        in=(in<<4)|(in2-'0');
        getchar();
    }
    return in;
}

/*
 * funkcia nastavujuca casovac RTC cez konzolu
 */
void set_time(void){
    struct time *cas;
    uchar in;
    vypis://ukazovatel
    get_time(cas);//ziskanie casu pre vypis
    printf("\n aktualne nastaveny cas %x:%x:%x",cas->hour,cas->min,cas->sec);
    printf("\n aktualne nastaveny datum ");
    switch(cas->day){
    case 1 : printf("pondelok");
             break;
    case 2 : printf("utorok");
             break;
    case 3 : printf("streda");
             break;
    case 4 : printf("stvrtok");
             break;
    case 5 : printf("piatok");
             break;
    case 6 : printf("sobota");
             break;
    default : printf("nedela");
              break;
    }
    printf(" %x.%x.20%x",cas->date,cas->month,cas->year);
    printf("\n\nchcete nastavit novy cas ?  a/n");
    in=getchar();//
    getchar();//prijimanie \n vysielaneho spolu s pismenom
    if ('a'==in){//testovanie prijateho znaku
        printf("\nvyber parameter, ktory chces zmenit\n\tsec 1\n\tmin 2\n"
                "\thour 3\n\tday 4\n\tdate 5\n\tmonth 6\n\tyear 7\n ");
        in=get_num();//ziskaj hodnotu
        if (in==1){
        printf("\nzadaj \tsekundy %x",cas->sec);
        in=get_num();//ziskaj hodnotu
        //zapis do registra pokym tranyakcia neprebehne korektne
        while(i2c_single_register_write(0x00,in)<0);
        }if(in==2){
        printf("\nzadaj \tminuty  %x",cas->min);
        in=get_num();//ziskaj hodnotu
        //zapis do registra pokym tranyakcia neprebehne korektne
        while(i2c_single_register_write(0x01,in)<0);
        }if(in==3){
        printf("\nzadaj \thodiny  %x",cas->hour);
        in=get_num();//ziskaj hodnotu
        //zapis do registra pokym tranyakcia neprebehne korektne
        while(i2c_single_register_write(0x02,in)<0);
        }if(in==4){
        printf("\nzadaj \tden     %x",cas->day);
        in=get_num();//ziskaj hodnotu
        //zapis do registra pokym tranyakcia neprebehne korektne
        while(i2c_single_register_write(0x03,in)<0);
        }if(in==5){
        printf("\nzadaj \tdni     %x",cas->date);
        in=get_num();//ziskaj hodnotu
        //zapis do registra pokym tranyakcia neprebehne korektne
        while(i2c_single_register_write(0x04,in)<0);
        }if(in==6){
        printf("\nzadaj \tmesiac  %x",cas->month);
        in=get_num();//ziskaj hodnotu
        //zapis do registra pokym tranyakcia neprebehne korektne
        while(i2c_single_register_write(0x05,in)<0);
        }if(in==7){
        printf("\nzadaj \trok     %x",cas->year);
        in=get_num();//ziskaj hodnotu
        //zapis do registra pokym tranyakcia neprebehne korektne
        while(i2c_single_register_write(0x06,in)<0);
        }if(in==8){
        //skryty register control, pomocou ktoreho sa kalibruje casovac
        printf("\nzadaj \tcontrol %x",cas->control);
        in=get_num();//ziskaj hodnotu
        //zapis do registra pokym tranyakcia neprebehne korektne
        while(i2c_single_register_write(0x07,in)<0);
        }
    goto vypis;//opakuj celu akciu
    }

}
