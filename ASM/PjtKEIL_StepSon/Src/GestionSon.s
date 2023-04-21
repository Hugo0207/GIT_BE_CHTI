	PRESERVE8
	THUMB   
	export callbackson
	export startson
	import Son
	import LongueurSon
	export index
	import PWM_Set_Value_TIM3_Ch3
	include DriverJeuLaser.inc

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
sortieson dcw 0
index dcw 0
	export sortieson
	
; ===============================================================================================
	
;;int sortieson=0;
;;static int index =0;
;;void callbackson(void)
;;{
;;	if(index<LongueurSon){
;;		sortieson=((Son[index]+32768)/(32768+32767))*720;
;;		index++;
;;	}
;;}

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		
callbackson PROC
	push {lr,r4,r5,r6,r7}
	ldr r0,=index
	ldr r1,=LongueurSon
	ldr r2,[r0]
	ldr r3,[r1]
	
	cmp r2,r3
	
	bge Exit ;si index>=LongueurSon, on sort
	
	ldr r4,=Son
	ldrsh r5,[r4,r2,lsl #1]
	
	add r5,#32768
	mov r6,#91
	udiv r5,r5,r6
	
	ldr r7,=sortieson
	strh r5,[r7]
	push {r0,r1,r2,r3}
	mov r0, r5
	bl PWM_Set_Value_TIM3_Ch3
	pop {r0,r1,r2,r3}
	add r2,#1

	strh r2,[r0]
	
Exit
	pop {lr,r4,r5,r6,r7}
	bx lr
	ENDP
		
startson PROC
	push{lr,r4,r5,r6,r7}
	ldr r0,=index
	ldr r1,[r0]
	mov r1,#0
	strh r1,[r0]
	pop{lr,r4,r5,r6,r7}	
	bx lr
	ENDP
	
	END	