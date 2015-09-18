/*-------------------------------------------------------------------------
 * Autor     : Peter Soltys
 * Datum     : marec 2015
 * Subor     : periferie.h
 * Hardver   : NIOS II
 *
 *
 * Opis : tento hlavickovy subor implementuje vsetky potrebne kniznice potrebne
 *      k obsluhe periferii
 *-------------------------------------------------------------------------*/

#ifndef PERIFERIE_H_
#define PERIFERIE_H_

                //1=aktivne/0=neaktivne//
#define I2C_RTC     1
#define LCD         1
#define ONEWIRE     1
#define SD_KARTA    1


#if SD_KARTA
//#define SPI_BASE_ADDRESS SPI_0_BASE //pocatocna adresa pre SFR ovladajuce SPI
//definovane v subore SD_SPI/diskio.c riadok 67
#include "SD_SPI/ff.h"
#endif

#if ONEWIRE
#include "one_wire.h"
#endif

#if I2C_RTC
//#define I2C_RTC_ADDR 0xD0//adresa RTC//sdresa zariadenia s ktorym komunikuje
//definovane v i2c.h riadok 24
#include "i2c.h"
#endif


#ifdef LCD

/* predefinovanie funkcii pre LCD disaplay */
#   define LCD_CLOSE(x) fclose((x))
#   define LCD_OPEN() fopen("/dev/lcd_display", "w")
#   define LCD_PRINTF fprintf

/* pohyby kurzora na LCD */
#define ESC 27// vycisti LCD
#define ESC_CLEAR "K" //pozicia kurzora riadok 1, stlpec 1 na LCD.
#define ESC_COL1_INDENT5 "[1;5H" //pozicia kurzora riadok 1, stlpec 5 na LCD.
#define ESC_COL2_INDENT5 "[2;5H"//pozicia kurzora riadok 1, stlpec 5 na LCD.
#define ESC_TOP_LEFT "[1;0H"//pozicia kurzora riadok 1, stlpec 0 na LCD.
#endif

#endif /* PERIFERIE_H_ */
