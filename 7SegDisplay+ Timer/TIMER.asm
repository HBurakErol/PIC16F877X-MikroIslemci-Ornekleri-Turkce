#INCLUDE  <P16F877A.INC>
LIST P=16F877A
__CONFIG H'3F31'
;__CONFIG H'2F01'
GECIKME1	EQU	0X20
GECIKME2	EQU	0X21
SAYAC			EQU	0X22
BIRLER		EQU	0X23
ONLAR		EQU	0X24

ORG			0X000
NOP
GOTO BASLA


ORG			0X004

BANKSEL	PIR1
BCF		PIR1,0
MOVLW	0XDB
MOVWF	TMR1L
MOVLW	0X0B
MOVWF	TMR1H

INCF		SAYAC
MOVLW	0X02
SUBWF	SAYAC,0
BTFSS		STATUS,Z
GOTO		DONUS
BCF		STATUS,Z
CLRF		SAYAC

INCF		BIRLER
INCF		BIRLER
MOVLW	D'10'
SUBWF	BIRLER,W
BTFSS		STATUS,Z
GOTO		KONTROL
BCF		STATUS,Z
INCF		ONLAR
CLRF		BIRLER

KONTROL:
MOVLW	D'6'
SUBWF	ONLAR,W
BTFSS		STATUS,Z
GOTO		DONUS
BCF		STATUS,Z
MOVLW	D'0'
SUBWF	BIRLER,W
BTFSS		STATUS,Z
GOTO		DONUS
BCF		STATUS,Z
CLRF		BIRLER
CLRF		ONLAR

DONUS:
RETFIE



GECIKME:				; (herbir komut 4mhz de 1mikrosn) = 1 sn GEC?KME (yakla??k)
	MOVLW	0xE7
	MOVWF	GECIKME1	
	
	MOVLW	0x04
	MOVWF	GECIKME2
DONGU1
	DECFSZ	GECIKME1,1
	GOTO	$+2
	DECFSZ	GECIKME2,1
	GOTO	DONGU1
	
	NOP
	NOP	
	RETURN



LOOKUP_TABLE:
ADDWF	PCL,1
RETLW	0X3F
RETLW	0X06
RETLW	0X5B
RETLW	0X4F
RETLW	0X66
RETLW	0X6D
RETLW	0X7D
RETLW	0X07
RETLW	0X7F
RETLW	0X6F


PORT_AYAR:
BANKSEL		INTCON
MOVLW		B'11000000'
MOVWF		INTCON

BANKSEL		T1CON
MOVLW		B'00110001'
MOVWF		T1CON

BANKSEL 		PIR1
BCF			PIR1,TMR1IF
BANKSEL		PIE1
BSF			PIE1,TMR1IE

BANKSEL 		TRISB
CLRF			TRISB
MOVLW		0X06
MOVWF		ADCON1
MOVLW		B'00111100'
MOVWF		TRISA

BANKSEL		PORTB
CLRF			PORTB
CLRF			PORTA

MOVLW		0XDB
MOVWF		TMR1L
MOVLW		0X0B
MOVWF		TMR1H
CLRF			SAYAC

RETURN



BASLA:
CALL PORT_AYAR
MOVLW 	0X00
MOVWF	BIRLER
MOVLW	0X00
MOVWF	ONLAR
DONGU
MOVLW	0X02
MOVWF	PORTA
MOVFW	BIRLER
CALL		LOOKUP_TABLE
MOVWF	PORTB
CALL 		GECIKME
MOVLW	0X01
MOVWF	PORTA
MOVFW	ONLAR
CALL		LOOKUP_TABLE
MOVWF	PORTB
CALL 		GECIKME

GOTO DONGU


END