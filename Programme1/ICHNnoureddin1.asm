;Le programme de PIC_1                                                         
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; Les DIRECTIVES
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	LIST      p=16F84A            ; Définition de processeur
	#include <p16F84A.inc>        ; Définitions de variables
	__CONFIG   _CP_OFF & _WDT_OFF & _PWRTE_ON & _HS_OSC

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                 PROGRAMME PRINCIPAL
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
CBLOCK 0x0C   				; début de la zone variables 
	cmpt1 : 1				; compteur de boucles 1
	cmpt2 : 1				; compteur de boucles 2
	cmpt3 : 1				; compteur de boucles 3
	ENDC
    ORG 0x000 ;l' adresse de depart dans la memoire de programme 
    goto start ;orientation vers l etiquite start   
;---------------------------------------------------------------------
; Cette sous-routine introduit un retard d'environ 0.5s
; Elle ne reçoit aucun paramètre et n'en retourne aucun
;---------------------------------------------------------------------
 tempo
 	movlw	1				; pour 2 boucles
	movwf	cmpt3				; initialiser compteur3
boucle3
	clrf	cmpt2				; effacer compteur2
boucle2
	clrf	cmpt1				; effacer compteur1
boucle1
	nop					; perdre 1 cycle
	decfsz	cmpt1,f				; décrémenter compteur1
 	goto	boucle1				; si pas 0, boucler	
	decfsz	cmpt2,f 			; si 0, décrémenter compteur 2
	goto	boucle2				; si cmpt2 pas 0, recommencer boucle1
	decfsz	cmpt3,f				; si 0, décrémenter compteur 3
	goto	boucle3				; si cmpt3 pas 0, recommencer boucle2
   return						; retour de la sous-routine
;===================================================================
;Ce morceau de prgramme nous permet d'allumer et ettiendre des 7segment et aussi 
;faire decrémenter l afficheur des unites
;================================================================
Decomptage bsf PORTB,7
           clrf PORTA
           call tempo
           call tempo 
           call tempo 
           movlw b'00001001'
           movwf PORTA
           call tempo
           call tempo 
        hh decf PORTA,f
           call tempo
           call tempo
           clrw 
           subwf PORTA,w
           btfss STATUS,Z
           goto hh
           movlw b'00001001' 
           movwf PORTA
           call tempo
           call tempo
        kk decf PORTA,f
           call tempo
           call tempo
           clrw 
           subwf PORTA,w
           btfss STATUS,Z
           goto kk
           clrf PORTA
           bcf PORTB,7
           return
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;Programme principal avec lequel on va faire et traduire
; tout ce qui demmandé dans le cahier de charge exactement le tableau
;
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
start
         bsf STATUS,RP0; acceder au banque1 pour configurer les portes
         clrf TRISB  ; considerer tout le portb en sortie
         clrf TRISA
         bcf STATUS,RP0
         clrf PORTA
         clrf PORTB
 Sequence1 
          clrf PORTA
          clrf PORTB                          
          bsf PORTB,2;Allumer LED R1
          bsf PORTB,3 ;allumer LED V2
          
          call tempo ;tomporisation de 0.5 second
          bcf PORTB,3 ;eteindre  LED V2
          call tempo
          bsf PORTB,3
          call tempo
          bcf PORTB,3
          call tempo
          bsf PORTB,3
          call tempo
          bcf PORTB,3
          call tempo
          bsf PORTB,3
          call tempo
          bcf PORTB,3
          clrf PORTB
          
          
Sequence2
          bsf PORTB,2 ;Allumer LED R1
          bsf PORTB,4;Allumer  LED J2
          call tempo 
          call tempo
          call tempo
          call tempo 
          bcf PORTB,4
          clrf PORTB
         
Sequence3
          bsf PORTB,0; AllumeLED V1
          bsf PORTB,5 ;Allumer LED R2
          call Decomptage ;Appel decomptage 
          
Sequence4 
          
          bsf PORTB,5;LED R2
          bsf PORTB,0 ;LED V1
          call tempo ;tomporisation de 0.5 second
          bcf PORTB,0
          call tempo
          bsf PORTB,0
          call tempo
          bcf PORTB,0
          call tempo
          bsf PORTB,0
          call tempo
          bcf PORTB,0
          call tempo
          bsf PORTB,0
          call tempo
          bcf PORTB,0
          clrf PORTB
          
Sequence5  
          bsf PORTB,5 ;LED R1
          bsf PORTB,1; LED J1
          call tempo 
          call tempo
          call tempo
          call tempo 
          bcf PORTB,4
          clrf PORTB
          
 Sequence6 
          bsf PORTB,3 ; LED V2
          bsf PORTB,2 ;LED R1
          goto Decomptage 
          ;clrf PORTB    
          goto Sequence1; revenir au sequence 1 pour refaire le fonctionnement
          


      end                 