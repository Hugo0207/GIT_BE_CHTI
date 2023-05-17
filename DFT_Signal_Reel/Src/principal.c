
#include "DriverJeuLaser.h"


extern short int LeSignal;
int DFT_ModuleAuCarre(short int*Signal64ech,char k);
short int dma_buf[64];
int tab[6];
int result;

void callback_systick(){
	Init_ADC1_DMA1(0, dma_buf );
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	tab[0] = DFT_ModuleAuCarre(dma_buf,17);
	tab[1] = DFT_ModuleAuCarre(dma_buf,18);
	tab[2] = DFT_ModuleAuCarre(dma_buf,19);
	tab[3] = DFT_ModuleAuCarre(dma_buf,20);
	tab[4] = DFT_ModuleAuCarre(dma_buf,23);
	tab[5] = DFT_ModuleAuCarre(dma_buf,24);
}


int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();

	
//systick timer configuration
Systick_Period_ff(72*1000*5); //=5ms
Systick_Prio_IT(2, callback_systick );//à compléter
SysTick_On ;
SysTick_Enable_IT ;

//timer2 configuration
Init_TimingADC_ActiveADC_ff( ADC1, 72);
Single_Channel_ADC( ADC1, 2 );
Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );

	
//============================================================================	
	
	
	
while	(1)
	{
	}
}

