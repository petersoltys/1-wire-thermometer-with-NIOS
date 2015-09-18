/*-----------------------------------------------------------------
 * i2c.c - I2C interface library
 *-----------------------------------------------------------------
 * $Id: i2c.c,v 2.0 2009/11/21, R. Beuchat from C.Gaudin Exp $
 *-----------------------------------------------------------------
 * Author   : $Author: cgaudin, rbeuchat $
 * Revision : $Revision: 2.0 $
 * Date     : $Date: 2009/11/21  $
 *-----------------------------------------------------------------*/

#ifndef _i2c_h_
#define _i2c_h_
#define  Avalon_i2c_ModeDynamic 1
/* 
 * I2C status register bits
 */
#define I2C_TIP        (1<<3) // transfer in progress 
#define I2C_IRQ        (1<<2) // interrupt pending    
#define I2C_BUSY       (1<<1) // I2C busy             
#define I2C_LRA        (1<<0) // last received ack    

/* 
 * I2C control register bits
 */
#define I2C_IRQ_ENABLE (1<<5) // interrupt enable    
#define I2C_WRITE      (1<<4) // write               
#define I2C_READ       (1<<3) // read                
#define I2C_START      (1<<2) // start               
#define I2C_STOP       (1<<1) // stop                
#define I2C_ACK        (1<<0) // ack to send         

/*
 * I2C error codes
 */
#define I2C_ENODEV     1      // no device
#define I2C_EBADACK    2      // bad acknowledge received


/* I2C registers
------------- */
#include “io.h”
#include “system.h”

// Base_i2c is defined in system.h, you have to adapt from name used in SOPC
// If the i2c has been designed with Dynamic mode or Native (obsolete from version 8)
// Old definition
/*
//
 // I2C registers
 //
typedef volatile struct
{
  int np_i2c_data;   // Read/Write, 8-bit
  int np_i2c_ctrl;   // Write-only, 8-bit
  int np_i2c_status; // Read-only,  8-bit
  int np_i2c_clkdiv; // Read/Write, 8-bit
} np_i2c;
*/
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
// Base_i2c is defined in system.h, adapt from name used in SOPC

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
 * I2C Clock Divisor Standard Values
 */

/* 50 kHz */
#define I2C_SLOW   0xA3

/* 100 kHz */
#define I2C_NORMAL 0x54
//#define I2C_NORMAL     ((nasys_clock_freq_1000 / (4 * 100))+      \ 
//		       ((nasys_clock_freq_1000 % (4 * 100))?1:0))

/* 400 kHz */ 
#define I2C_FAST   0x15
//#define I2C_FAST       ((nasys_clock_freq_1000 / (4 * 400))+      \
//                       ((nasys_clock_freq_1000 % (4 * 400))?1:0))

/*
 * function declarations
 */
// io is the Hardware base address of the i2c interface
extern void i2c_set_speed(void *io, int speed_in_hz)

/* Fast mode (400 kHz) */
extern void i2c_fastmode(void *io);

/* Normal mode (100 kHz) */
extern void i2c_normal_mode(void *io);

/* write one byte to a device on I2C bus */
extern int i2c_write_byte(void *io, 
			  unsigned char addr, 
			  unsigned char data);

/* read a byte from a device on I2C bus */
extern int i2c_read_byte(void *io, 
			 unsigned char addr,
			 unsigned char *data);

extern int i2c_single_register_write( 
             unsigned char index ,
             unsigned char value )

extern int i2c_single_register_read( 
                unsigned char index ,
                unsigned char *value )

#endif /* _i2c_h_ */


