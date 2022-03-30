;Le programme de PIC_2                                                            
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
;---------------------------------------------------------------------
; Cette sous-routine introduit un retard 
; Elle ne reçoit aucun paramètre et n'en retourne aucun
;--------------------------------------------------------------------
      ORG 0x000
      goto start

tempo
	movlw	2				; pour 2 boucles
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
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
start    ; la configuration des entrés et des sorties 
         bsf STATUS,RP0
         clrf TRISA        ;configure tout le PORTA en sortie
         movlw b'00000010' ;configuration de portB,1 en entrée pour pouvoir 
                           ;tester est ce qui l afficheur des unitées a arrivé au 0 au non
                           ; pinB.0 est raccordé au sortie de porte NOR
         movwf TRISB
         bcf STATUS,RP0

 loop   
     clrf PORTA  ;Initialisiation de portA donc 7seg unités  va afficher 0
   
   JJ bsf PORTA,1  ;Affiche le 0 
      bcf PORTA,0  ; affiche le 0   
      call tempo; 
      btfss PORTB,1 ; tester est ce qui l afficheur des unitées a arrivé au 0 au non
      goto JJ     ;si non va vers jj ( garder l affichage de 0)
   kk bcf PORTA,1  ;si oui afficher le 1 
      bsf PORTA,0  ;afficher le 1
      call tempo  ; appel le tempo
      btfss PORTB,1  ;retester est ce qui l afficheur des unitées a arrivé au 0 au non
      goto kk      ;  si non  garde le l affichage de 1       
bb    clrf PORTA  ;  si oui afffiche le 0
      call tempo  ; appel le tempo
      btfss PORTB,1; retester tjrs  est ce qui l afficheur des unitées a arrivé au 0 au non
      goto bb   ; si non garder l affichage   de 0 
      goto loop ; si oui donc va vers loop pour refaire le deroulement 
    
   end                                
        