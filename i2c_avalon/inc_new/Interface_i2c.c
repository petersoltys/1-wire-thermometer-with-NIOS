// I2C
// TODO check
#define AdI2C								I2C_BASE

#define IORD_I2C_DATA(base)					IORD(base, 0)
#define IOWR_I2C_DATA(base, data)			IOWR(base, 0, data)

#define IOWR_I2C_CTRL(base, data)			IOWR(base, 1, data)
#define bI2C_CTRL_ACK						0
#define bI2C_CTRL_STOP						1
#define bI2C_CTRL_START						2
#define bI2C_CTRL_READ						3
#define bI2C_CTRL_WRITE						4
#define bI2C_CTRL_IEN						5

#define IORD_I2C_STATUS(base)				IORD(base, 2)
#define bI2C_STATUS_LRA						0
#define bI2C_STATUS_BUSY					1
#define bI2C_STATUS_IRQ						2
#define bI2C_STATUS_TIP						3

#define IORD_I2C_CLKDIV(base)				IORD(base, 3)
#define IOWR_I2C_CLKDIV(base, data)			IOWR(base, 3, data)


// Camera

// Sensor registers

/* LM9630 I2C Device Address */
#define LM9630_I2C_ADDR						0x88

/* LM9630 I2C Registers Address  */
#define LM9630_REV_ADDR						0x00

#define LM9630_MCFG_ADDR					0x01
#define bLM9630_MCFG_MODE					0
#define bLM9630_MCFG_TRI_DVP				1
#define bLM9630_MCFG_RES					2
#define bLM9630_MCFG_BY_PASS_AMP			3
#define bLM9630_MCFG_PWD_AMP				4
#define bLM9630_MCFG_PWR_DOWN				5
#define bLM9630_MCFG_DVB_MODE				6

#define LM9630_VGAIN_ADDR					0x02

#define LM9630_ITIMEL_ADDR					0x03

#define LM9630_IDLE_ADDR					0x04

#define LM9630_ITIMEH_ADDR					0x05

#define LM9630_POWSET_ADDR					0x06

#define LM9630_OFFSET_ADDR					0x08
#define LM9630_OFFSET_SIGN					7

// I2C

// Possible ERRORS for functions that return an error code
// Success
#define RCYC_I2C_SUCCESS 0
// No such device
#define RCYC_I2C_ENODEV 1
// Bad acknowledge
#define RCYC_I2C_EBADACK 2

// Init I2C
void RCyc_I2C_Init(void);

// Write byte Value at register Index into Device. Return 0 (RCYC_I2C_SUCCESS) on success, another value on error
int RCyc_I2C_WriteDeviceRegister(unsigned char Device, unsigned char Index, unsigned char Value);

// Read byte Value at register Index from Device. Return 0 (RCYC_I2C_SUCCESS) on success, another value on error
int RCyc_I2C_ReadDeviceRegister(unsigned char Device, unsigned char Index, unsigned char *Value);



// I2C

void RCyc_I2C_Init(void)
{
	// 100 kHz I2C
	IOWR_I2C_CLKDIV(AdI2C, ALT_CPU_FREQ / (4 * 100000));
	
	// wait 1ms (TODO: is it required ? PerInt MUST be initialized !)
	RCyc_Perint_Wait(1);
}

// Wait for end of current transfer
void RCyc_I2C_WaitForEOT(void)
{
	while (IS_BIT_SET(IORD_I2C_STATUS(AdI2C), bI2C_STATUS_TIP))
		{}
}

// Set a data and the associated control state, wait until transfer is completed
void RCyc_I2C_SetDataCtrl(unsigned char Data, unsigned char Control)
{
	RCyc_I2C_WaitForEOT();
	IOWR_I2C_DATA(AdI2C, Data);
	IOWR_I2C_CTRL(AdI2C, Control);
	RCyc_I2C_WaitForEOT();
}

// Get a data and the associated control state, wait until transfer is completed
unsigned char RCyc_I2C_GetDataCtrl(unsigned char Control)
{
	RCyc_I2C_WaitForEOT();
	IOWR_I2C_CTRL(AdI2C, Control);
	RCyc_I2C_WaitForEOT();
	return IORD_I2C_DATA(AdI2C);
}

int RCyc_I2C_WriteDeviceRegister(unsigned char Device, unsigned char Index, unsigned char Value)
{
	// write device address with R/W bit = 0 (writing)
	RCyc_I2C_SetDataCtrl(Device & 0xFE, (1 << bI2C_CTRL_START) | (1 << bI2C_CTRL_WRITE));
	
	// error, device does not answer
	if (IS_BIT_SET(IORD_I2C_STATUS(AdI2C), bI2C_STATUS_LRA))
	{
		IOWR_I2C_CTRL(AdI2C, (1 << bI2C_CTRL_STOP));
		return RCYC_I2C_ENODEV;
	}
	
	// write register address
	RCyc_I2C_SetDataCtrl(Index, (1 << bI2C_CTRL_WRITE));
	
	// error, wrong acknowledge
	if (IS_BIT_SET(IORD_I2C_STATUS(AdI2C), bI2C_STATUS_LRA))
	{
		IOWR_I2C_CTRL(AdI2C, (1 << bI2C_CTRL_STOP));
		return RCYC_I2C_EBADACK;
	}
	
	// write value
	RCyc_I2C_SetDataCtrl(Value, (1 << bI2C_CTRL_STOP) | (1 << bI2C_CTRL_WRITE));
	
	// error, wrong acknowledge
	if (IS_BIT_SET(IORD_I2C_STATUS(AdI2C), bI2C_STATUS_LRA))
	{
		// TODO : check in VHDL to see if this is requireds
		IOWR_I2C_CTRL(AdI2C, (1 << bI2C_CTRL_STOP));
		return RCYC_I2C_EBADACK;
	}
		
	return RCYC_I2C_SUCCESS;
}

int RCyc_I2C_ReadDeviceRegister(unsigned char Device, unsigned char Index, unsigned char *Value)
{
	// write device address with R/W bit = 0 (writing)
	RCyc_I2C_SetDataCtrl(Device & 0xFE, (1 << bI2C_CTRL_START) | (1 << bI2C_CTRL_WRITE));
	
	// error, device does not answer
	if (IS_BIT_SET(IORD_I2C_STATUS(AdI2C), bI2C_STATUS_LRA))
	{
		IOWR_I2C_CTRL(AdI2C, (1 << bI2C_CTRL_STOP));
		return RCYC_I2C_ENODEV;
	}
	
	// write register address
	RCyc_I2C_SetDataCtrl(Index, (1 << bI2C_CTRL_WRITE));
	
	// error, wrong acknowledge
	if (IS_BIT_SET(IORD_I2C_STATUS(AdI2C), bI2C_STATUS_LRA))
	{
		IOWR_I2C_CTRL(AdI2C, (1 << bI2C_CTRL_STOP));
		return RCYC_I2C_EBADACK;
	}
	
	// write device address with R/W bit = 1 (reading)
	RCyc_I2C_SetDataCtrl(Device | 0x01, (1 << bI2C_CTRL_START) | (1 << bI2C_CTRL_WRITE));
	
	// error, device does not answer
	if (IS_BIT_SET(IORD_I2C_STATUS(AdI2C), bI2C_STATUS_LRA))
	{
		IOWR_I2C_CTRL(AdI2C, (1 << bI2C_CTRL_STOP));
		return RCYC_I2C_ENODEV;
	}
	
	// Read the data. Warning, write bit bI2C_CTRL_ACK to send a NO_ACK ('H)
	*Value = RCyc_I2C_GetDataCtrl((1 << bI2C_CTRL_STOP) | (1 << bI2C_CTRL_READ) | (1 << bI2C_CTRL_ACK));
	
	return RCYC_I2C_SUCCESS;
}
