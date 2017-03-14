;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME: DELSIG11_1.inc
;;   Version: 1.50, Updated on 2014/7/14 at 8:11:19
;;
;;  DESCRIPTION: Assembler declarations for the Delta-Sigma A/D Converter
;;               with a 1st-order modulator and based on a type 2 decimator.
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2014. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "m8c.inc"

;--------------------------------------------------
; Constants for DELSIG11_1 API's.
;--------------------------------------------------

DELSIG11_1_INT_REG:                equ  0e1h
DELSIG11_1_INT_MASK:               equ  01h     ; Interrupt mask

DELSIG11_1_OFF:                    equ  0
DELSIG11_1_LOWPOWER:               equ  1
DELSIG11_1_MEDPOWER:               equ  2
DELSIG11_1_HIGHPOWER:              equ  3

DELSIG11_1_DATA_READY_BIT:         equ  10h
DELSIG11_1_2S_COMPLEMENT:          equ  0

;--------------------------------------------------
; Register Address Constants for DELSIG11_1
;--------------------------------------------------

DELSIG11_1_PWM_DR0:                equ 0x20    ; Period reg
DELSIG11_1_PWM_DR1:                equ 0x21    ; Down count reg
DELSIG11_1_PWM_DR2:                equ 0x22    ; Compare reg
DELSIG11_1_PWM_CR0:                equ 0x23    ; Control reg
DELSIG11_1_PWM_FN:                 equ 0x20        ; Function reg
DELSIG11_1_PWM_SL:                 equ 0x21        ; Input  select reg
DELSIG11_1_PWM_OS:                 equ 0x22        ; Output select reg

DELSIG11_1_AtoDcr0:                equ 0x90    ; SC Block Control Reg 0
DELSIG11_1_AtoDcr1:                equ 0x91    ; SC Block Control Reg 1
DELSIG11_1_AtoDcr2:                equ 0x92    ; SC Block Control Reg 2
DELSIG11_1_AtoDcr3:                equ 0x93    ; SC Block Control Reg 3


; end of file DELSIG11_1.inc
