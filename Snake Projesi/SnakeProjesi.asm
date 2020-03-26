#include	<p16f877A.inc>
list		p=16f877A
GECIKME1	EQU	0x20    ;GEC?KME 1. DONGU
GECIKME2	EQU	0x21    ;GECIKME 2. DONGU
N1_PORTB		EQU	0X23
N1_PORTC 	EQU	0X24
N2_PORTB		EQU	0X25
N2_PORTC	EQU	0X26
N3_PORTB		EQU	0X27
N3_PORTC	EQU	0X28
;upta �al���yor
ORG 0X00
 nop
GOTO BASLA

UP:
CALL GECIKME
CALL GECIKME
CALL GECIKME
MOVFW 	N2_PORTB
MOVWF 	N1_PORTB
MOVFW 	N2_PORTC
MOVWF 	N1_PORTC
CALL GECIKME
MOVFW	 N3_PORTB
MOVWF	 N2_PORTB
MOVFW	 N3_PORTC
MOVWF	 N2_PORTC
CALL GECIKME
RRF 		N3_PORTB

RETURN

DOWN:
CALL GECIKME
CALL GECIKME
CALL GECIKME
MOVFW N2_PORTB
MOVWF N1_PORTB
CALL GECIKME
MOVFW N2_PORTC
MOVWF N1_PORTC
CALL GECIKME
MOVFW	 N3_PORTB
MOVWF	 N2_PORTB
CALL GECIKME
MOVFW	 N3_PORTC
MOVWF	 N2_PORTC
CALL GECIKME
RLF		N3_PORTB
RETURN

SAG:
CALL GECIKME
CALL GECIKME
CALL GECIKME
MOVFW N2_PORTB
MOVWF N1_PORTB
CALL GECIKME
MOVFW N2_PORTC
MOVWF N1_PORTC
CALL GECIKME
MOVFW	 N3_PORTB
MOVWF	 N2_PORTB
CALL GECIKME
MOVFW	 N3_PORTC
MOVWF	 N2_PORTC
CALL GECIKME
RLF 		N3_PORTC
RETURN

SOL:
CALL GECIKME
CALL GECIKME
CALL GECIKME
MOVFW N2_PORTB
MOVWF N1_PORTB
CALL GECIKME
MOVFW N2_PORTC
MOVWF N1_PORTC
CALL GECIKME
MOVFW	 N3_PORTB
MOVWF	 N2_PORTB
CALL GECIKME
MOVFW	 N3_PORTC
MOVWF	 N2_PORTC
CALL GECIKME
RRF		N3_PORTC
RETURN



PORT_AYARLA:
BANKSEL TRISA
MOVLW 0X06
MOVWF ADCON1
MOVLW b'00001111'
MOVWF TRISA
MOVLW b'11100000'
MOVWF TRISC
;CLRF TRISC
MOVLW b'10000000'
MOVWF TRISB
;CLRF TRISB
BANKSEL	PORTA
CLRF	PORTA
CLRF PORTB
CLRF PORTC

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

BASLA:
MOVLW B'00001000'
MOVWF N1_PORTB
MOVLW B'00000001'
MOVWF N1_PORTC
MOVLW B'00001000'
MOVWF N2_PORTB
MOVLW B'00000010'
MOVWF N2_PORTC
MOVLW B'00001000'
MOVWF N3_PORTB
MOVLW B'00000100'
MOVWF N3_PORTC
CALL  PORT_AYARLA


DD:
MOVFW N1_PORTB
MOVWF PORTB
MOVFW N1_PORTC
MOVWF PORTC
CALL GECIKME
MOVFW N2_PORTB
MOVWF PORTB
MOVFW N2_PORTC
MOVWF PORTC
CALL GECIKME
MOVFW N3_PORTB
MOVWF PORTB
MOVFW N3_PORTC
MOVWF PORTC
CALL GECIKME
BTFSS PORTA,0
CALL UP
BTFSS PORTA,1
CALL DOWN
BTFSS PORTA,2
CALL SAG
BTFSS PORTA,3
CALL SOL

GOTO DD

END