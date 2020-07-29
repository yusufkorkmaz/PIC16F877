#include <main.h>

void main()
{ 
   int8 data, data1 = 1, data2 = 128;
   
   while(TRUE)
   {
      for(int8 i = 1; i<=7; i++)
      {  
         output_b(data);
         delay_ms(100);
         data1 = data1<<1;
         data2 = data2>>1;
         data = data1 | data2; 
      }
      for(int8 j = 1; j<=7; j++)
      {  
         output_b(data);
         delay_ms(100);
         data1 = data1>>1;
         data2 = data2<<1;
         data = data1 | data2; 
      }
   }
}
