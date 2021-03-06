;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME: DELSIG11_1.asm
;;   Version: 1.50, Updated on 2014/7/14 at 8:11:19
;;  Generated by PSoC Designer 5.4.2946
;;
;;  DESCRIPTION: Assembler source for the Delta-Sigma A/D Converter User
;;               Module with 1st-order modulator based on the Type 2 Decimator.
;;
;;  NOTE: User Module APIs conform to the fastcall16 convention for marshalling
;;        arguments and observe the associated "Registers are volatile" policy.
;;        This means it is the caller's responsibility to preserve any values
;;        in the X and A registers that are still needed after the API
;;        functions returns. For Large Memory Model devices it is also the
;;        caller's responsibility to perserve any value in the CUR_PP, IDX_PP,
;;        MVR_PP and MVW_PP registers. Even though some of these registers may
;;        not be modified now, there is no guarantee that will remain the case
;;        in future releases.
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2014. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "m8c.inc"
include "memory.inc"
include "DELSIG11_1.inc"


;-----------------------------------------------
;  Global Symbols
;-----------------------------------------------
export  DELSIG11_1_Start
export _DELSIG11_1_Start
export  DELSIG11_1_SetPower
export _DELSIG11_1_SetPower
export  DELSIG11_1_Stop
export _DELSIG11_1_Stop
export  DELSIG11_1_StartAD
export _DELSIG11_1_StartAD
export  DELSIG11_1_StopAD
export _DELSIG11_1_StopAD
export  DELSIG11_1_fIsDataAvailable
export _DELSIG11_1_fIsDataAvailable
export  DELSIG11_1_cGetDataClearFlag
export _DELSIG11_1_cGetDataClearFlag
export  DELSIG11_1_bGetDataClearFlag
export _DELSIG11_1_bGetDataClearFlag
export  DELSIG11_1_cGetData
export _DELSIG11_1_cGetData
export  DELSIG11_1_bGetData
export _DELSIG11_1_bGetData
export  DELSIG11_1_ClearFlag
export _DELSIG11_1_ClearFlag
export  DELSIG11_1_WritePulseWidth
export _DELSIG11_1_WritePulseWidth


;-----------------------------------------------
;  Constant Definitions
;-----------------------------------------------

CONTROL_REG_ENABLE_BIT:                    equ  01h     ; Control register start bit
POWERMASK:                                 equ  03h     ; Analog PSoC Block Power bits


AREA UserModules (ROM, REL)

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: DELSIG11_1_Start
;  FUNCTION NAME: DELSIG11_1_SetPower
;
;  DESCRIPTION: Applies power setting to the module's analog PSoc block.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    The A register contains the power setting.
;  RETURNS:      Nothing.
;  SIDE EFFECTS: REGISTERS ARE VOLATILE: THE A AND X REGISTERS MAY BE MODIFIED!
;                RAM use class 2: page pointer registers are not modified.
;
 DELSIG11_1_Start:
_DELSIG11_1_Start:
 DELSIG11_1_SetPower:
_DELSIG11_1_SetPower:
   RAM_PROLOGUE RAM_USE_CLASS_2
   mov  X, SP                                    ; Set up Stack frame
   and  A, POWERMASK                             ; Ensure value is legal
   push A
   mov  A, reg[DELSIG11_1_AtoDcr3]               ; First SC block:
   and  A, ~POWERMASK                            ;   clear power bits to zero
   or   A, [ X ]                                 ;   establish new value
   mov  reg[DELSIG11_1_AtoDcr3], A               ;   change the actual setting
   pop  A
   RAM_EPILOGUE RAM_USE_CLASS_2
   ret
.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: DELSIG11_1_Stop
;
;  DESCRIPTION:   Removes power from the module's analog PSoc block.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    None.
;  RETURNS:      Nothing.
;  SIDE EFFECTS: REGISTERS ARE VOLATILE: THE A AND X REGISTERS MAY BE MODIFIED!
;                RAM use class 1: page pointer registers are not modified.
;
 DELSIG11_1_Stop:
_DELSIG11_1_Stop:
   RAM_PROLOGUE RAM_USE_CLASS_1
   and  reg[DELSIG11_1_AtoDcr3], ~POWERMASK
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret
.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: DELSIG11_1_StartAD
;
;  DESCRIPTION: Activates interrupts for this user module and begins sampling.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    None.
;  RETURNS:      Nothing.
;  SIDE EFFECTS: REGISTERS ARE VOLATILE: THE A AND X REGISTERS MAY BE MODIFIED!
;                RAM use class 1: page pointer registers may be modified.
;
 DELSIG11_1_StartAD:
_DELSIG11_1_StartAD:
   RAM_PROLOGUE RAM_USE_CLASS_1
   M8C_EnableIntMask DELSIG11_1_INT_REG, DELSIG11_1_INT_MASK
   mov  reg[DELSIG11_1_PWM_CR0], CONTROL_REG_ENABLE_BIT
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret
.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: DELSIG11_1_StopAD
;
;  DESCRIPTION: Shuts down the A/D is an orderly manner.  The PWM stops
;               operating and it's interrupt is disabled. Analog power is
;               still supplied to the analog block, however.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    None.
;  RETURNS:      Nothing.
;  SIDE EFFECTS: REGISTERS ARE VOLATILE: THE A AND X REGISTERS MAY BE MODIFIED!
;                RAM use class 1: page pointer registers are not modified.
;
 DELSIG11_1_StopAD:
_DELSIG11_1_StopAD:
   RAM_PROLOGUE RAM_USE_CLASS_1
   mov  reg[DELSIG11_1_PWM_CR0], 00h                 ; Disable the PWM
   M8C_DisableIntMask DELSIG11_1_INT_REG, DELSIG11_1_INT_MASK   ; Disable its interrupt
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret
.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: DELSIG11_1_fIsDataAvailable
;
;  DESCRIPTION: Returns the status of the A/D Data
;-----------------------------------------------------------------------------
;  ARGUMENTS:    None.
;  RETURNS:      fastcall16 BOOL DataAvailable returned in the A register
;  SIDE EFFECTS:
;    REGISTERS ARE VOLATILE: THE A AND X REGISTERS MAY BE MODIFIED!
;    IN THE LARGE MEMORY MODEL CURRENTLY ONLY THE PAGE POINTER
;    REGISTERS LISTED BELOW ARE MODIFIED.  THIS DOES NOT GUARANTEE
;    THAT IN FUTURE IMPLEMENTATIONS OF THIS FUNCTION OTHER PAGE POINTER
;    REGISTERS WILL NOT BE MODIFIED.
;
;    Page Pointer Registers Modified:
;          CUR_PP
;
 DELSIG11_1_fIsDataAvailable:
_DELSIG11_1_fIsDataAvailable:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >DELSIG11_1_bfStatus
   mov  A, [DELSIG11_1_bfStatus]
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME:  DELSIG11_1_cGetDataClearFlag
;
;  DESCRIPTION:    Returns the data from the A/D.  Does not check if data is
;                  available. Also clears the DATA_READY flag.
;-----------------------------------------------------------------------------
;  ARGUMENTS:    None.
;  RETURNS:      fastcall16 INT iData (LSB in A, MSB in X)
;  SIDE EFFECTS:
;    REGISTERS ARE VOLATILE: THE A AND X REGISTERS MAY BE MODIFIED!
;    IN THE LARGE MEMORY MODEL CURRENTLY ONLY THE PAGE POINTER
;    REGISTERS LISTED BELOW ARE MODIFIED.  THIS DOES NOT GUARANTEE
;    THAT IN FUTURE IMPLEMENTATIONS OF THIS FUNCTION OTHER PAGE POINTER
;    REGISTERS WILL NOT BE MODIFIED.
;
;    Page Pointer Registers Modified:
;          CUR_PP
;
;    PWM interrupts are momentarily halted and restarted to
;    ensure data is not lost.
;
 DELSIG11_1_cGetDataClearFlag:
_DELSIG11_1_cGetDataClearFlag:
 DELSIG11_1_bGetDataClearFlag:
_DELSIG11_1_bGetDataClearFlag:
   ; Note, data format is determined by the ISR.
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >DELSIG11_1_bfStatus
   M8C_DisableIntMask DELSIG11_1_INT_REG, DELSIG11_1_INT_MASK
   and  [DELSIG11_1_bfStatus], ~DELSIG11_1_DATA_READY_BIT
   mov  A, [DELSIG11_1_cResult]
   M8C_EnableIntMask DELSIG11_1_INT_REG, DELSIG11_1_INT_MASK
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME:  DELSIG11_1_cGetData:
;
;  DESCRIPTION:     Returns the data from the A/D.  Does not check if data is
;                   available.
;-----------------------------------------------------------------------------
;  ARGUMENTS:    None.
;  RETURNS:      fastcall16 INT iData (LSB in A, MSB in X)
;  SIDE EFFECTS:
;    REGISTERS ARE VOLATILE: THE A AND X REGISTERS MAY BE MODIFIED!
;    IN THE LARGE MEMORY MODEL CURRENTLY ONLY THE PAGE POINTER
;    REGISTERS LISTED BELOW ARE MODIFIED.  THIS DOES NOT GUARANTEE
;    THAT IN FUTURE IMPLEMENTATIONS OF THIS FUNCTION OTHER PAGE POINTER
;    REGISTERS WILL NOT BE MODIFIED.
;
;    Page Pointer Registers Modified:
;          CUR_PP
;
 DELSIG11_1_cGetData:
_DELSIG11_1_cGetData:
 DELSIG11_1_bGetData:
_DELSIG11_1_bGetData:
   ; Note, data format is determined by the ISR.
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >DELSIG11_1_cResult
   mov  A, [DELSIG11_1_cResult]
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: DELSIG11_1_ClearFlag
;
;  DESCRIPTION: Clears the data ready flag.
;-----------------------------------------------------------------------------
;  ARGUMENTS:    None.
;  RETURNS:      Nothing.
;  SIDE EFFECTS:
;    REGISTERS ARE VOLATILE: THE A AND X REGISTERS MAY BE MODIFIED!
;    IN THE LARGE MEMORY MODEL CURRENTLY ONLY THE PAGE POINTER
;    REGISTERS LISTED BELOW ARE MODIFIED.  THIS DOES NOT GUARANTEE
;    THAT IN FUTURE IMPLEMENTATIONS OF THIS FUNCTION OTHER PAGE POINTER
;    REGISTERS WILL NOT BE MODIFIED.
;
;    Page Pointer Registers Modified:
;          CUR_PP
;
 DELSIG11_1_ClearFlag:
_DELSIG11_1_ClearFlag:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >DELSIG11_1_bfStatus
   and  [DELSIG11_1_bfStatus], ~DELSIG11_1_DATA_READY_BIT
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: DELSIG11_1_WritePulseWidth
;
;  DESCRIPTION:
;     Write the 8-bit compare value into the compare register (DR2).
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    fastcall16 BYTE bPulseWidth (passed in A)
;  RETURNS:      Nothing
;  SIDE EFFECTS:
;      REGISTERS ARE VOLATILE: THE A AND X REGISTERS MAY BE MODIFIED!
;      RAM use class 1: page pointer registers are not modified.
;      This function can produce momentary glitches in the PWM output. This
;      effect can be avoided by calling DELSIG11_1_StopAD and
;      DELSIG11_1_StartAD before and after the call to this function.
;      As usual, the first two samples following such a start up action will
;      will contain invalid values.
;
 DELSIG11_1_WritePulseWidth:
_DELSIG11_1_WritePulseWidth:
    RAM_PROLOGUE RAM_USE_CLASS_1
    mov   reg[DELSIG11_1_PWM_DR2],A
    RAM_EPILOGUE RAM_USE_CLASS_1
    ret
.ENDSECTION


; End of File DELSIG11_1.asm
