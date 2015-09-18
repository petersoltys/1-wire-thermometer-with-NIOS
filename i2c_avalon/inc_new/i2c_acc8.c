/*-----------------------------------------------------------------
 * i2c.c - I2C interface library
 *-----------------------------------------------------------------
 * $Id: i2c.c,v 2.0 2009/11/21, R. Beuchat from C.Gaudin Exp $
 *-----------------------------------------------------------------
 * Author   : $Author: cgaudin, rbeuchat $
 * Revision : $Revision: 2.0 $
 * Date     : $Date: 2009/11/21  $
 *-----------------------------------------------------------------*/
 
#include "nios.h"
#include "i2c.h"

/* wait some microseconds */
#define WAIT { volatile int i; for (i=0; i<100;) i++; }

/* wait for end of transfer */
#define WAIT_FOR_EOT(io,t) { while ((t=io->np_i2c_status) & I2C_TIP) WAIT; }


/*
 * Set Serial Clock Speed in hz 
 */
void i2c_set_speed(void *io, int speed_in_hz)
{
  int div = nasys_clock_freq_1000 / (4 * speed_in_hz);
  
  if (nasys_clock_freq_1000 % (4 * speed_in_hz))
    div++;

  io->np_i2c_clkdiv = (unsigned char)div;
  
  /* wait a while */
  nr_delay(1);
} 

/* 
 * Set FAST mode (400 kHz)
 */
void i2c_fastmode(void *io)
{
  i2c_set_speed(io, 400);
}

/*
 * Set NORMAL mode (100 kHz)
 */
void i2c_normal_mode(void *io)
{
  i2c_set_speed(io, 100);
}

/*
 * write one byte to a device on I2C bus
 *//* wait some microseconds */
#define WAIT { int i; for (i=0; i<100;) i++; }

/* wait for end of transfer */
#define WAIT_FOR_EOT(t) { while ((t= IORD_I2C_SR()) & I2C_TIP) WAIT; }

/* Set register index (no data write)  */

int i2c_write_index(unsigned char index )
{
  unsigned char t;
  
  WAIT_FOR_EOT(t);       			// Wait to be Ready for new access

  IOWR_I2C_DR(LM9630_I2C_ADDR & 0xFE );	// LM9630 address and Write
  IOWR_I2C_CR(I2C_START | I2C_WRITE );	// Start and Address send
  
  WAIT_FOR_EOT(t);       			// Wait to be Ready for new access

  if ( t & I2C_LRA ) return -CAMERA2D_ENODEV; // End if no Ack received
  
  IOWR_I2C_DR(index );				// LM9630 regsiter to access
  IOWR_I2C_CR(I2C_WRITE );			// Write it
  
  WAIT_FOR_EOT(t);      			// Wait to be Ready for new access

  if ( t & I2C_LRA ) return -CAMERA2D_EBADACK; // End if no Ack received 

  IOWR_I2C_DR(0); 				// Acknowledge IRQ bit

  return 0;
}
/*
 * Write to a LM9630 register 
 */

int i2c_single_register_write( 
             unsigned char index ,
             unsigned char value )
{
  int rc;
  unsigned char t;

  if ((rc=i2c_write_index(index & 0x7F )) < 0)
    return rc;					// Index send with error -> end
  
  IOWR_I2C_DR( value );			// Data to send in the register
  IOWR_I2C_CR( I2C_WRITE | I2C_STOP );	// Value and STOP
  
  WAIT_FOR_EOT(t); 				// Wait to be Ready for new access
  
  if (t & I2C_LRA) return -CAMERA2D_EBADACK; // End if no Ack received	

  IOWR_I2C_DR(0); 				// Acknowledge IRQ bit

  return 0;
}

/*
 * Read a LM9630 register  
 */

int i2c_single_register_read( 
                unsigned char index ,
                unsigned char *value )
{
  int rc;
  unsigned char t;

  /* set index */
  if ((rc=i2c_write_index(index & 0x7F )) < 0)
    return rc; 					// Index send with error -> end

  IOWR_I2C_DR( LM9630_I2C_ADDR | 0x01 );	// LM9630 address + read
  IOWR_I2C_CR( I2C_WRITE | I2C_START );	// Start + address and Read
  
  WAIT_FOR_EOT(t); 				// Wait to be Ready for new access

  if ( t & I2C_LRA )  return -CAMERA2D_ENODEV;	//Ack received ?

  t = IORD_I2C();				// Send the SCL for read access
  IOWR_I2C_CR( I2C_READ | I2C_STOP | I2C_NO_ACK);
    
  WAIT_FOR_EOT(t); 				// Wait to be Ready for new access

  (*value) = IORD_I2C();			// Data received

  return 0;
}
