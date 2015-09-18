/*-------------------------------------------------------------------------
 * Autor     : Peter Soltys
 * Datum     : 12.februar 2015
 * Subor     : one_wire.h
 * Verzia    : 1.2
 * Hardver   : zbernica.vhd
 *
 *
 * Vytvorene funkcie :     char read_tempreature_single(unsigned int a[9]);
 *                         char read_rom(uchar ROM[8]);
 *                         char conversion_single(void);
 *                         char conversion(uchar b[8]);
 *                         char read_tempreature(uchar a[8]);
 *
 *
 * Povodne funkcie zo stranky :
 * http://www.maximintegrated.com/en/app-notes/index.mvp/id/187
 *                                int  OWFirst();
 *                                int  OWNext();
 *                                int  OWVerify();
 *                                void OWTargetSetup(uchar family_code);
 *                                void OWFamilySkipSetup();
 *                                int  OWReset();
 *                                void OWWriteByte(uchar byte_value);
 *                                void OWWriteBit(uchar bit_value);
 *                                uchar OWReadBit();
 *                                int  OWSearch();
 *                                uchar docrc8(uchar value);
 *
 * Opis     : je to hlavickvy subor k suboru onewire.c ktory definuje funkcie
 * na pracu s hardverom zbernica.vhd a komunikaciu so zariadenim DS18B20
 *-------------------------------------------------------------------------*/

#ifndef ONE_WIRE_H_
#define ONE_WIRE_H_

/*
 * nastavenie 1-wire
 */

//definuje prikazy pre jedno zariadenie na zbernici
//1=aktivne/0=neaktivne
#define SINGLE 1

//definuje prikazy apremenne pre vyhladavanie slave zariadeni na zbernici
//1=aktivne/0=neaktivne
#define ROM_SEARCH 1




#include <system.h>
#include "io.h"

#define ZBERNICA ZBERNICA_0_BASE

//makra prikazov na zapis do jednotlivych registrov
#define RX_WR(DATA) IOWR_8DIRECT(ZBERNICA,0,DATA)//primaci register
#define CR_WR(DATA) IOWR_8DIRECT(ZBERNICA,1,DATA)//kontrolny register
#define TX_WR(DATA) IOWR_8DIRECT(ZBERNICA,2,DATA)//primaci register
#define CD_WR(DATA) IOWR_8DIRECT(ZBERNICA,3,DATA)//clock divisor--hodinovy delic
//makra prikazov pre citanie z registrov
#define RX_RD() IORD_8DIRECT(ZBERNICA,0)//primaci register
#define CR_RD() IORD_8DIRECT(ZBERNICA,1)//kontrolny register
#define CRC_RD() IORD_8DIRECT(ZBERNICA,2)//primaci register
#define CD_RD() IORD_8DIRECT(ZBERNICA,3)//clock divisor--hodinovy delic

#define PRESENSE    0x01
#define RX_SLOT     0x02
#define TX_SLOT     0x04
#define RST_SLOT    0x08
#define BIT_MODE    0x10
#define INTERRUPT   0x20
#define BUSY        0x40
#define RST_I       0x80
#define BIT_VALID   0x80
//------------------------------------------------------------------------------
//RX register --- primaci register
/*
 * su v nom ulozene prijte bity
 * v BIT_MODE posledny prijaty bit je bit 7 (maska 0x80) je to posuvny register,
 * >>1 pri prijati kazdeho dalsieho bitu
 * velkost 8 bitov
 * len na citanie
 *
 * pri zapise sa nic neudeje, data sa stratia
 * */

//CR register --- kontrolny register
/*
 * bit  W/R       nazov      popis
 * 0    (W)/R    PRESENSE    nastavi sa na '1' ak dojde odpoved po rest signale
 * 1    W/(R)    RX_SLOT     nastavuje uzivatel, nuluje HW automaticky
 *                           po prijati 8.bitov/1 bitu v BIT_MODE
 * 2    W/(R)    TX_SLOT     nastavuje uzivatel, nuluje HW automaticky
 *                           -vyvola zapis dat z TX_register
 * 3    W/(R)    RST_SLOT    nastavuje uzivatel, nuluje HW automaticky
 *                           -vyvola zapis reset signalu
 * 4    W/R      BIT_MODE    nastavuje uzivatel, nuluje uzivatel
 *                           -mod vysielania alebo primania iba po jednom bite,
 *                           reset slot pracuje normalne, pri RST_I sa nuluje
 * 5    W/R      INTERRUPT   nastavuje uzivatel, nuluje uzivatel
 *                           -vyvola prerusenie po ukonceni vysielania bitu/bytu
 *                           (zatial neimplementovane)
 * 6    R        BUSY        vyjadruje zaneprazdnenost HW
 * 7    W        RST_I       nastavuje uzivatel
 *                           -interne resetovanie hodnot (plati iba pre zapis
 *                           pri ciatani ziskame hodnotu bitu "BIT_VALID")
 * 7    R        BIT_VALID   iba na citanie, nastavuje aj nuluje HW
 *                           -vyjadruje platnost prjateho bitu v BIT_MODE,
 *                           no nevyjadruje koniec vysielania bitu,
 *                           to vyjadruje bit 6-BUSY
 */

//TX register --- vysielaci register
/*
 * nastavuje uzivatel
 * tieto bity su vysielane na zbernicu 1-wire
 * je to posuvny register
 * jeho hodnota sa neuchovava
 *
 * v BIT_MODE sa vysiela len bit 0
 *
 * pri citani vycitame hodnotu CRC
 * po odvysielani CRC zo strany zariadenia nadobudne hodnotu 0
 * */

//CRC register --- obsahuje vypocitane CRC
/*
 * je ho mozne iba citat, pretoze ma rovnaku adresu ako TX register
 * po odvisielani CRC zo strany zariadenia nadobudne hodnotu 0
 * */

//CD register --- clock divisor -- hodinove impulzy su delene touto konstantou
/*
 * po vydeleni vstupnych hodin touto konstantou musi byt dlzka periody medzi
 * 2um < vysledna perioda < 4us
 */


#define TRANSACTION_OK 0
#define NO_PRESENSE -1
#define WRONG_CRC -2
// definitions
#define FALSE 0
#define TRUE  1

#ifndef uchar
typedef unsigned char uchar;//predchadzajuca definicia v integer.h
#define uchar uchar//aby prekladac rozpoznal predchadzajucu definiciu
#endif

extern void inicializacia(void);
extern void reset_onewire(void);

#if SINGLE
char read_temperature_single(uchar REG[9]);
char read_rom(uchar ROM[8]);
#endif
char conversion_single(void);
char conversion(uchar ROM[8]);
char read_tempreature(uchar REG[9],uchar ROM[8]);


#if ROM_SEARCH
// zdroj : http://www.maximintegrated.com/en/app-notes/index.mvp/id/187
uchar ROM_NO[8];//globalna premenna
// method declarations
int  OWFirst();
int  OWNext();
int  OWVerify();
void OWTargetSetup(uchar family_code);
void OWFamilySkipSetup();
int  OWReset();
void OWWriteByte(uchar byte_value);
void OWWriteBit(uchar bit_value);
uchar OWReadBit();
int  OWSearch();
uchar docrc8(uchar value);
#endif

#endif /* ONE_WIRE_H_ */
