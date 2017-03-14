//*****************************************************************************
//*****************************************************************************
//  FILENAME: DELSIG11_1.h
//   Version: 1.50, Updated on 2014/7/14 at 8:11:19
//
//  DESCRIPTION:  C declarations for the DelSig User Module with a 1st-order
//                modulator based on a type-2 dcecimator
//-----------------------------------------------------------------------------
//      Copyright (c) Cypress Semiconductor 2014. All Rights Reserved.
//*****************************************************************************
//*****************************************************************************
#ifndef DELSIG11_1_INCLUDE
#define DELSIG11_1_INCLUDE

#include <m8c.h>

#pragma fastcall16 DELSIG11_1_Start
#pragma fastcall16 DELSIG11_1_SetPower
#pragma fastcall16 DELSIG11_1_StartAD
#pragma fastcall16 DELSIG11_1_StopAD
#pragma fastcall16 DELSIG11_1_Stop
#pragma fastcall16 DELSIG11_1_fIsDataAvailable
#pragma fastcall16 DELSIG11_1_cGetData
#pragma fastcall16 DELSIG11_1_bGetData
#pragma fastcall16 DELSIG11_1_cGetDataClearFlag
#pragma fastcall16 DELSIG11_1_bGetDataClearFlag
#pragma fastcall16 DELSIG11_1_ClearFlag
#pragma fastcall16 DELSIG11_1_WritePulseWidth

//-------------------------------------------------
// Prototypes of the DELSIG11_1 API.
//-------------------------------------------------
extern void DELSIG11_1_Start(BYTE bPower);
extern void DELSIG11_1_SetPower(BYTE bPower);
extern void DELSIG11_1_StartAD(void);
extern void DELSIG11_1_StopAD(void);
extern void DELSIG11_1_Stop(void);
extern BOOL DELSIG11_1_fIsDataAvailable(void);
extern CHAR DELSIG11_1_cGetData(void);
extern BYTE DELSIG11_1_bGetData(void);
extern CHAR DELSIG11_1_cGetDataClearFlag(void);
extern BYTE DELSIG11_1_bGetDataClearFlag(void);
extern void DELSIG11_1_ClearFlag(void);
extern void DELSIG11_1_WritePulseWidth(BYTE wPulseWidthValue);

//-------------------------------------------------
// Defines for DELSIG11_1 API's.
//-------------------------------------------------
#define DELSIG11_1_OFF                     (0)
#define DELSIG11_1_LOWPOWER                (1)
#define DELSIG11_1_MEDPOWER                (2)
#define DELSIG11_1_HIGHPOWER               (3)

#define DELSIG11_1_DATA_READY_BIT          (0x10)
#define DELSIG11_1_2S_COMPLEMENT           (0)

//-------------------------------------------------
// Hardware Register Definitions
//-------------------------------------------------
#pragma ioport  DELSIG11_1_PWM_DR0: 0x020               //Time base Counter register
BYTE            DELSIG11_1_PWM_DR0;
#pragma ioport  DELSIG11_1_PWM_DR1: 0x021               //Time base Period value register
BYTE            DELSIG11_1_PWM_DR1;
#pragma ioport  DELSIG11_1_PWM_DR2: 0x022               //Time base CompareValue register
BYTE            DELSIG11_1_PWM_DR2;
#pragma ioport  DELSIG11_1_PWM_CR0: 0x023               //Time base Control register
BYTE            DELSIG11_1_PWM_CR0;
#pragma ioport  DELSIG11_1_PWM_FN:  0x120                //Time base Function register
BYTE            DELSIG11_1_PWM_FN;
#pragma ioport  DELSIG11_1_PWM_SL:  0x121                //Time base Input register
BYTE            DELSIG11_1_PWM_SL;
#pragma ioport  DELSIG11_1_PWM_OS:  0x122                //Time base Output register
BYTE            DELSIG11_1_PWM_OS;

#pragma ioport  DELSIG11_1_AtoDcr0: 0x090               //Analog control register 0
BYTE            DELSIG11_1_AtoDcr0;
#pragma ioport  DELSIG11_1_AtoDcr1: 0x091               //Analog control register 1
BYTE            DELSIG11_1_AtoDcr1;
#pragma ioport  DELSIG11_1_AtoDcr2: 0x092               //Analog control register 2
BYTE            DELSIG11_1_AtoDcr2;
#pragma ioport  DELSIG11_1_AtoDcr3: 0x093               //Analog control register 3
BYTE            DELSIG11_1_AtoDcr3;

#endif
// end of file DELSIG11_1.h
