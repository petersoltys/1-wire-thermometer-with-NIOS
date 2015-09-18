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
 * Subor    : i2c.h
 * verzia   : 1.2
 *
 * vytvorene funkcie : char get_time(struct time *cas);
 *                     void set_time(void);
 *
 * vytvorena struktura : time --s ktorou pracuje funkcia get_time
 *-----------------------------------------------------------------*/

#ifndef _i2c_h_
#define _i2c_h_
#define  Avalon_i2c_ModeDynamic 1

#define Base_i2c I2C_INTERFACE_0_BASE

#define I2C_RTC_ADDR 0xD0//adresa RTC//sdresa zariadenia s ktorym komunikuje

#ifndef uchar//nereaguje na predchadzajucu definiciu
typedef unsigned char    uchar;//predchadzajuca definicia v integer.h
#define uchar uchar//aby prekladac rozpoznal predchadzajucu definiciu
#endif

struct time//struktura obsahujuca udaje registrov RTC
{
   uchar  sec;
   uchar  min;
   uchar  hour;
   uchar  day;
   uchar  date;
   uchar  month;
   uchar  year;
   uchar  control;
};

/*
 * I2C status register bits
 */
#define I2C_TIP        0x08//(1<<3) // transfer in progress
#define I2C_IRQ        0x04//(1<<2) // interrupt pending
#define I2C_BUSY       0x02//(1<<1) // I2C busy
#define I2C_LRA        0x01//(1<<0) // last received ack

/*
 * I2C control register bits
 */
#define I2C_IRQ_ENABLE 0x20//(1<<5) // interrupt enable
#define I2C_WRITE      0x10//(1<<4) // write
#define I2C_READ       0x08//(1<<3) // read
#define I2C_START      0x04//(1<<2) // start
#define I2C_STOP       0x02//(1<<1) // stop
#define I2C_NO_ACK     0x01//(1<<0) // ack to send

/*
 * I2C error codes
 */
#define I2C_ENODEV     -1      // no device
#define I2C_EBADACK    -2      // bad acknowledge received


/* I2C registers
------------- */
#include "io.h"
#include "system.h"




//
 // I2C registers
 //
#if Avalon_i2c_ModeDynamic
#define IORD_I2C_DR() IORD_8DIRECT(Base_i2c,0)
#define IORD_I2C_CR() IORD_8DIRECT(Base_i2c,1)
#define IORD_I2C_SR() IORD_8DIRECT(Base_i2c,2)
#define IORD_I2C_CD() IORD_8DIRECT(Base_i2c,3)

#define IOWR_I2C_DR(data) IOWR_8DIRECT(Base_i2c,0,data)
#define IOWR_I2C_CR(data) IOWR_8DIRECT(Base_i2c,1,data)
#define IOWR_I2C_SR(data) IOWR_8DIRECT(Base_i2c,2,data)
#define IOWR_I2C_CD(data) IOWR_8DIRECT(Base_i2c,3,data)

#else

#define IORD_I2C_DR() IORD(Base_i2c,0)
#define IORD_I2C_CR() IORD(Base_i2c,1)
#define IORD_I2C_SR() IORD(Base_i2c,2)
#define IORD_I2C_CD() IORD(Base_i2c,3)

#define IOWR_I2C_DR(data) IOWR(Base_i2c,0,data)
#define IOWR_I2C_CR(data) IOWR(Base_i2c,1,data)
#define IOWR_I2C_SR(data) IOWR(Base_i2c,2,data)
#define IOWR_I2C_CD(data) IOWR(Base_i2c,3,data)

#endif


/*
 * function declarations
 */
// io is the Hardware base address of the i2c interface
extern void i2c_set_speed(int speed_in_hz);

/* Fast mode (400 kHz) */
extern void i2c_fastmode(void);

/* Normal mode (100 kHz) */
extern void i2c_normal_mode(void);

/* read a single register from a device on I2C bus */
extern char i2c_single_register_write(
             uchar index ,
             uchar value );

/* write a single register to a device on I2C bus */
extern char i2c_single_register_read(
                uchar index ,
                uchar *value );

//**************************nove funkcie****************************************
//funkcia vycita 8 registrov z RTC a vlozi do strukturovanej premennej typu time
extern char get_time(struct time *cas);

//funkcia umozni zmenit hodnotu registrov v RTC
extern void set_time(void);

#endif /* _i2c_h_ */


