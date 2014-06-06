;ENCABEZADO
        #INCLUDE<P16F873A.INC>
        __CONFIG _XT_OSC & _WDT_OFF & _CP_OFF & _PWRTE_ON &_BODEN_OFF & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
;DEFINICIONES
;REGISTROS
        CBLOCK  02H
        V0
        V1
        V2
        V3
        RESULTADO
        ENDC
;INICIO
        ORG 00H
;CONFIGURACIÓN
CONF:       
            BSF     STATUS,RP0
            MOVLW   0FFH
            MOVWF   TRISA
            CLRF    TRISB
            CLRF    TRISC
            BSF     TRISC,7
            ;MOVLW   b'10000001'
            CLRF    ADCON1
            BCF     STATUS,RP0
            MOVLW   b'00000101'
            MOVWF   ADCON0
            CLRF    PORTA
            CLRF    PORTB
            CLRF    PORTC
CHECAR:     BTFSC   ADCON0,2    ;FALTA ESPERAR EL TIEMPO DE
            GOTO    $-1      ;ADQUISICION
            MOVF    ADRESH,W
            MOVWF   RESULTADO
            MOVF    ADRESH,W
            MOVWF   PORTB
            MOVF    ADRESL,W
            MOVWF   PORTC
            CALL    T5MS
            BSF     ADCON0,2
            GOTO    $-0A
            #INCLUDE<TIEMPOS.INC>
            END