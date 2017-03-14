//----------------------------------------------------------------------------
// VC1 provides a sample clock of 3 MHz to the DELTA_SIGMA-11bit, 
// resulting in a sample rate of 7.8 Ksamples per second. 
// VC3 generates the baud clock for the UART by dividing 24 MHz by 156. The UART internally 
// divides VC3 by 8 resulting in a baud rate of 19,200 bps. The serial data is 
// sent as ASCII text with 1 start bit, 8 data bits, 1 stop bit and no parity. 
// This data may be monitored using most terminal software. 
//
//
// PSoCEval1 Connections:
//      port0_pin1 -> External Signal = ADC Input (0-Vdd)
//      port1_pin6 -> RX = RS232 RX
//      port2_pin7 -> TX = RS232 TX
//
//-----------------------------------------------------------------------------


#include <m8c.h>                         // part specific constants and macros
#include "PSoCAPI.h"                     // PSoC API definitions for all User Modules
#include "stdlib.h"
#include "fft.h"                     // PSoC API definitions for all User Modules
	
#define RESOLUTION 12                    // ADC resolution
#define SCALE_BG  (( 1 << RESOLUTION)/55) // BarGraph scale factor

int  iResult;                            // ADC result variable
char df[4];
double max,zero=0;
unsigned int i=0;         //index
unsigned int ind;         
unsigned int endl=65535;  //uart tag


// Delta-Sigma-11bit: 7.8 ksps
unsigned int N_samples=7800;
double  time;    // time record
double delta_f;  // frequency sampling interval

void UART_print_re_imm ()  //send REAL and IMAGINARY parts data
{  
     UART_1_CPutString("Real Part\t\tImaginary Part\n");
     for(i=0;i<N_points;i++)
     {
       UART_1_PutSHexInt(data_re[i]);
        UART_1_CPutString("\t\t");
        UART_1_PutSHexInt(data_imm[i]);
      UART_1_PutCRLF();  
      }
    }

void UART_print_mod ()    //send ABSOLUTE VALUE data
{
   UART_1_PutSHexInt(0);
   for(i=0;i<N_points;i++)
   {
   UART_1_PutSHexInt(mod[i]);
   }
   UART_1_PutSHexInt(endl);
   UART_1_PutCRLF();   
}

void UART_print_data ()   // send REAL data
{
   UART_1_CPutString("Data init\n"); // Example string
    
   for (i=0;i<N_points;i++)
   {
   UART_1_PutSHexInt(data_re[i]);
   UART_1_PutCRLF();
   }

}

void LCD_print()
{         
	/* find the fundamental harmonic (except the zero component)*/
        max=mod[0];        
        ind=0;
        for(i=1;i<N_points/2;i++)
        	if(mod[i]>max)
        		{
        		  max=mod[i];
        		  ind=i;
         		 }
        		
        itoa(df,(int)(max),10);
        LCD_1_Position(1,0);
        LCD_1_PrString(df);
        
        itoa(df,(int)(ind*delta_f),10);
        LCD_1_Position(1,6);
        LCD_1_PrString(df);
        
        LCD_1_Position(1,11);
        LCD_1_PrCString("Hz");
}

void main()
{
    BYTE bgPos;                          // BarGraph position
   
    UART_1_Start(UART_PARITY_NONE);      // Enable UART
      
    PGA_1_Start(PGA_1_MEDPOWER);         // Turn on PGA power
    
    DELSIG11_1_Start( DELSIG11_1_HIGHPOWER );  
    DELSIG11_1_StartAD(); 
    
    time=(double)N_points/N_samples;
    delta_f=(double)1/time;
    
    itoa(df,(int)delta_f,10);
    
    LCD_1_Start();                       // Init the LCD
    LCD_1_InitBG(LCD_1_SOLID_BG);
    LCD_1_Position(0,0);
    LCD_1_PrCString("FFT  df=");
    LCD_1_Position(0,8);
    LCD_1_PrString(df);
    LCD_1_PrCString(" Hz");
    M8C_EnableGInt;                      // Enable Global interrupts
    
       
    i=0;
    
 	while (1)// Main loop 
    {   
         if ( DELSIG11_1_fIsDataAvailable() ) 
         {  
         data_re[i]=DELSIG11_1_iGetDataClearFlag();       
         i++;
         } 
      
       if(i==N_points)
        {
            
        	FFT(1,exponent,data_re,data_imm );
       
            UART_print_mod ();
            UART_print_re_imm ();
            //UART_print_data();
    	    LCD_print();
        	
         	for(i=0;i<N_points;i++)
         	{  	
            mod[i]=0;       //init 0
            data_re[i]=0;
            data_imm[i]=0;
            }
            i=0;
        }       
}      
}