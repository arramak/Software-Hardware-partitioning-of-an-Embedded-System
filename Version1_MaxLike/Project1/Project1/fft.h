#include "math.h"				
#define N_points 64             			
#define exponent log(64)/log(2) 


double mod[N_points];        				// i think ye arrays k naam bhi change honge
double data_re[N_points]={0};
double data_imm[N_points]={0};
double data_re1[N_points]={0};
double data_imm1[N_points]={0};
int maxAmp=0, maxFreq=0;

void FastFourierTransform(double exponent, double *imm, double *re, double *mode)	//reduce 1 argument from main
{
   long points = 1;
   int count =0;
   
   while(count<exponent)
   {
	   count++;
		points = points*2;
   }
   long reverse = points >> 1;
   
   count = 0;
   int i=0;
   
   while(i<points-1)
   {
	i++;
	if (count>= i) 						//only variables cahnged in this loop
	  { 
         double tnsx = re[i];
         double tnsy = imm[i];
         re[i] = re[count];
         imm[i] = imm[count];
         re[count] = tnsx;
         imm[count] = tnsy;
      }
	  int a = reverse;
      for(a=reverse; a<=count; a>>=1)		//can be a problem in a 
	  {
         count -= a;
      }
      count = a+reverse;
   }

   long l1,l2;
   l2=1;
   int b =0;
   while(b<m)									// m nahi pata kya hai
   {
	  b++;
      l1 = l2;
      l2 <<= 1;
      double temp1 = 1.0; 
      double temp2 = 0.0;
	  i=0;
	  while(i<l1)
	  {
		 i++;
		 int i2=i;
		 while(i2<points)
		 {
			 i2++;
            int count2 = i + l1;
            double transform1 = temp1 * re[count2] - temp2 * imm[count2];
            double transform2 = temp1 * imm[count2] + temp2 * re[count2];
            re[count2] = re[i] - transform1; 
            imm[count2] = imm[i] - transform2;
            re[i] += transform1;
            imm[i] += transform2;
         }
		 double constant1 =-1;
		 double constant2 =0;
         double temp =  temp1 * constant1 - temp2 * constant2;
         temp2 = temp1 * constant2 + temp2 * constant1;
         temp1 = temp;
      }
      constant2 = sqrt((1.0 - constant1) / 2.0);
      if (dir == 1) 
         constant2 = -constant2;
      constant1 = sqrt((1.0 + constant1) / 2.0);
   }
	i=0;
	while(i<N_points)										//only variables names changed in this one
   {
	   i++;
	   modl[i]=sqrt((re[i]*re[i])+(imm[i]*imm[i]));
		if(modl[i]>maxAmp && i<64) 
		{
			maxAmp = modl[i];
			maxFreq = i+1;
		}
		
	}
	maxFreq = maxFreq * 104;
	return;
}