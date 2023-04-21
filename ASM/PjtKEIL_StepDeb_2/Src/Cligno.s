	PRESERVE8
	THUMB   
	include DriverJeuLaser.inc
	export timer_callback
		
	;export FlagCligno
; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
FlagCligno dcb 0
	
; ===============================================================================================
	

;void timer_callback(void)
;{
;	if (FlagCligno==1)
;	{
;		FlagCligno=0;
;		GPIOB_Set(1);
;	}
;	else
;	{
;		FlagCligno=1;
;		GPIOB_Clear(1);
;	}
;		
;}





		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici	



timer_callback PROC
	push{lr}
;void timer_callback(void)
;{
;	if (FlagCligno==1)
	ldr r0,=FlagCligno
	ldrb r1, [r0]
	cmp r1,#1
	bne Sinon
	
;	{
Si
;		FlagCligno=0;
	mov r1,#0
	str r1,[r0]
;		GPIOB_Set(1);
	mov r0,#1
	bl GPIOB_Set
;	}
	B FinSi
;	else
Sinon
;	{
;		FlagCligno=1;
	mov r1,#1
	str r1,[r0]
;		GPIOB_Clear(1);
	mov r0,#1
	bl GPIOB_Clear
;	}	
;}
	
	
FinSi 
	pop {lr}
	bx lr

	

	ENDP


		
		
	END	
		
		vererver