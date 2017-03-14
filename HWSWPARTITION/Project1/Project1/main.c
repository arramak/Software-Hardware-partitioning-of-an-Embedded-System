//Main code for final project
#include <m8c.h>        
#include "PSoCAPI.h"    
#include "fft.h"
#include "stdlib.h"
#include "math.h"
#include "stdio.h"


unsigned int displayFlag;
void clearDisplay(void); 
void outputFFT(void);
void maximumProbability(void);
void humaraAsliFunction(void);
void sdOut(void);




unsigned int mode_check_count = 0;
unsigned int temp_value = 0;
unsigned int temp_mode = 0,dumflag=0;
int  max;
double hannMul, hannValue,hannValue1;
unsigned int sampFreq=13330;
double ar1[32],ar2[32];
double  freq,avg_Freq=0,avg_Mat=0;    // time record
double maxf;
unsigned int avgCalNoise;



void main(void)
{
	char str[15];
	int a=0,i =0,mode_flag =0,isMatch;
	LCD_Start();
	UART_Start(UART_PARITY_NONE);
	PGA_1_Start(PGA_1_HIGHPOWER);
	PGA_2_Start(PGA_2_HIGHPOWER);
	LPF2_3_Start(LPF2_3_HIGHPOWER);
	PGA_3_Start(PGA_3_HIGHPOWER);		//redundant
	PGA_4_Start(PGA_4_HIGHPOWER);		//redundant
	LPF2_1_Start(LPF2_1_HIGHPOWER);
    M8C_EnableGInt;                     // Enable global interrupts	
	Timer_Start();
	clearDisplay();
	Timer_EnableInt();
	DUALADC_Start(DUALADC_HIGHPOWER);     // Turn on Analog section
    DUALADC_GetSamples(0);
	freq=104;
    
	clearDisplay();
	LCD_Position(1,0);

	humaraAsliFunction();
	
}

void getOutput(void)
{
	int i,Status,flag=0;
	char temp[4],*temp1;
	for(i=0;i<N_points;i++)
    {  	
       	mod[i]=0;       //init 0
		//mod1[i]=0;
       	data_re[i]=0;
		data_re1[i]=0;
       	
    }
	i=0;
		while(i!= N_points) // Wait for data to be ready. 
		{                                       
	    	while(DUALADC_fIsDataAvailable() == 0); 
			hannValue = DUALADC_iGetData1();
			
			if (hannValue > 0x0040 || flag == 1)
			{
				
				flag =1;
				hannMul = 0.5*(1-cos(0.0494*i));
				Mult_x=hannMul;
				Mult_y=hannValue;
				hannValue = Mult_out;
				data_re[i] = hannValue;
				
				DUALADC_ClearFlag();
				i++;
			}
		}
		FFT(exponent,data_re,data_imm,mod);
		sdOut();

	return ;
}


void sdOut(void )
{
	char temp[4],*temp1;
	int i,Status;
	UART_CPutString("\n\rFFT OUTPUT:\n\r");
	for (i=0;i<N_points;i++)
	{
		
		UART_CPutString("{");
		//itoa(temp,mod[i],10);
		temp1 = ftoa(mod[i], &Status);
		UART_PutString(temp1);
		//UART_PutString(temp);
		UART_CPutString("},");
		
	}
	UART_CPutString("\n\r");
	
}

void clearDisplay(void)
{
	int row=0,col=0;
	LCD_Position(row,col);
	LCD_PrCString("                ");
	row++;
	LCD_Position(row,col);
	LCD_PrCString("                ");	
}

void humaraAsliFunction(void )
{
	outputFFT();
	FFT(exponent,data_re1,data_imm1,mod);
	sdOut();
	cordic1();
	maximumProbability();
	
}
