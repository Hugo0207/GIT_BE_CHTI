

#include "DriverJeuLaser.h"

void callbackson(void);
void startson(void);

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();


Timer_1234_Init_ff(TIM4, 91*72);//en microseconde
Active_IT_Debordement_Timer(TIM4, 2, callbackson);
Timer_1234_Init_ff(TIM2, 72000000);//en microseconde
Active_IT_Debordement_Timer(TIM2, 1, startson);
	
	

//============================================================================	
	
PWM_Init_ff(TIM3, 3, 720);
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
	
while	(1)
	{
	}
}

//int sortieson=0;
//static int index =0;
//void callbackson(void)
//{
//	if(index<LongueurSon){
//		sortieson=(Son[index]+32768)/((32768+32767)*719);
//		index++;
//	}
//}
