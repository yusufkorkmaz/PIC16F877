list		p=16f877A 
#include	<p16f877A.inc> 
   
__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF 
   
   SAYAC0 EQU 0x22
   SAYAC1 EQU 0x23
   SAYAC2 EQU 0x24   
 
   ORG     0x000             	 
   goto    BASLA        

butonKONTROL
    
    BTFSC PORTA,4
    goto ileriSAY
    BTFSC PORTA,5
    goto geriSAY
    goto butonKONTROL  
    
ileriSAY 
     
    call    GECIKME
    INCF    PORTB,F  
    BTFSC   PORTA,5
    goto    geriSAY
    BTFSC   STATUS,Z
    goto    a_ARTIR
    goto    ileriSAY 
    
geriSAY  

    BTFSC   PORTA,4
    goto    ileriSAY
    call    GECIKME
    BSF     STATUS,C
    MOVLW   0x01
    SUBWF   PORTB,F
    BTFSS   STATUS,C
    goto    a_AZALT 
    goto    geriSAY
    
a_ARTIR
     
    INCF    PORTA,F
    CLRF    PORTB
    BCF     STATUS,Z
    goto    ileriSAY
 
a_AZALT
    BSF	    STATUS,C
    DECF    PORTA,F  
    BTFSS   STATUS,C
    goto    a_HEPSINIYAK
    goto    geriSAY

a_HEPSINIYAK

    BSF	    STATUS,C
    MOVLW   0XFF
    MOVWF   PORTA
    MOVWF   PORTB
    goto    geriSAY
    
GECIKME		 
	MOVLW		D'10'
	MOVWF		SAYAC2
	goto		DONGU1 
DONGU1		 
	MOVLW		D'180' 
	MOVWF		SAYAC0
	goto		DONGU2 
DONGU2
	MOVLW		D'50'
	MOVWF		SAYAC1
	goto		DONGU3 
DONGU3
	DECFSZ		SAYAC1,f
	goto		DONGU3  
	BTFSC		PORTA,4
	goto		ileriSAY 
	BTFSC		PORTA,5
	goto		geriSAY
	DECFSZ		SAYAC0,f
	goto		DONGU2
	DECFSZ		SAYAC2,f
	goto		DONGU1
	return
    
BASLA
	BANKSEL	ADCON1
	MOVLW 0x06
	MOVWF ADCON1
	BANKSEL	TRISA
	MOVLW b'00110000'
	MOVWF TRISA
	BANKSEL	PORTA
 	CLRF PORTA
	
	BANKSEL TRISB
	CLRF TRISB
	BANKSEL PORTB
	CLRF PORTB   
	
	goto butonKONTROL
    	
	END