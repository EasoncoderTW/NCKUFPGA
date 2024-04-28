/*
 * main.c
 *
 *  Created on: 2021/4/11
 *      Author: VLSILAB
 */

#include <stdio.h>
#include "xil_printf.h"
#include "xil_io.h"
#include "xparameters.h"

#include "Arithmetic.h"
#include "ParityGenerator.h"
#include "Sorting.h"


/* Arithmetic Unit Test */
void Arithmetic_Unit_Test(){
	printf("Start Arithmetic_Unit_Test \n\r");
	u32	A, B, Result, overflow;
	// -128 + (-1)
	A = -128; B = -1;
	Result = Arithmetic_Add(XPAR_ARITHMETIC_0_BASEADDR, A, B, &overflow);
	printf("(%d) + (%d) = (%d) -> overflow = %d\n\r", A, B, Result, overflow);
	// -128 – (-1)
	A = -128; B = -1;
	Result = Arithmetic_Sub(XPAR_ARITHMETIC_0_BASEADDR, A, B, &overflow);
	printf("(%d) - (%d) = (%d) -> overflow = %d\n\r", A, B, Result, overflow);
	// -128* (-1)
	A = -128; B = -1;
	Result = Arithmetic_Mul(XPAR_ARITHMETIC_0_BASEADDR, A, B, &overflow);
	printf("(%d) * (%d) = (%d) -> overflow = %d\n\r", A, B, Result, overflow);
	// 127 + (-1)
	A = 127; B = -1;
	Result = Arithmetic_Add(XPAR_ARITHMETIC_0_BASEADDR, A, B, &overflow);
	printf("(%d) + (%d) = (%d) -> overflow = %d\n\r", A, B, Result, overflow);
	// 127 – (-1)
	A = 127; B = -1;
	Result = Arithmetic_Sub(XPAR_ARITHMETIC_0_BASEADDR, A, B, &overflow);
	printf("(%d) - (%d) = (%d) -> overflow = %d\n\r", A, B, Result, overflow);
	// 127*(-1)
	A = 127; B = -1;
	Result = Arithmetic_Mul(XPAR_ARITHMETIC_0_BASEADDR, A, B, &overflow);
	printf("(%d) * (%d) = (%d) -> overflow = %d\n\r", A, B, Result, overflow);
	printf("End of Arithmetic_Unit_Test \n\r");
}

/* ParityGenerator Unit Test */
void ParityGenerator_Unit_Test()
{
	printf("Start ParityGenerator_Unit_Test \n\r");
	u32 A, Result;
	// 1 -> 1
	A = 1;
	Result = ParityGenerator(XPAR_PARITYGENERATOR_0_BASEADDR, A);
	printf("%x -> %d\n\r", A, Result);
	// 6 -> 0
	A = 6;
	Result = ParityGenerator(XPAR_PARITYGENERATOR_0_BASEADDR, A);
	printf("%x -> %d\n\r", A, Result);
	// ffffffff -> 0
	A = 0xffffffff;
	Result = ParityGenerator(XPAR_PARITYGENERATOR_0_BASEADDR, A);
	printf("%x -> %d\n\r", A, Result);
	// 13579ade -> 0
	A = 0x13579ade;
	Result = ParityGenerator(XPAR_PARITYGENERATOR_0_BASEADDR, A);
	printf("%x -> %d\n\r", A, Result);
	printf("End of ParityGenerator_Unit_Test \n\r");
	
}

/* Sorting Unit Test */
void Sorting_Unit_Test()
{
	printf("Start Sorting_Unit_Test \n\r");
	u32 A, Result;
	// 77743217  -> 1234777
	A = 0x77743217;
	Result = Sorting(XPAR_SORTING_0_BASEADDR, A);
	printf("%x -> %x\n\r", A, Result);
	// 1fb4a219  -> 11249abf
	A = 0x1fb4a219;
	Result = Sorting(XPAR_SORTING_0_BASEADDR, A);
	printf("%x -> %x\n\r", A, Result);
	// 123489af  -> 123489af
	A = 0x1fb4a219;
	Result = Sorting(XPAR_SORTING_0_BASEADDR, A);
	printf("%x -> %x\n\r", A, Result);

	printf("End of Sorting_Unit_Test \n\r");
}

int main()
{
	
	printf("Program Start.\n\r");

	Arithmetic_Unit_Test();
	ParityGenerator_Unit_Test();
    Sorting_Unit_Test();
	
	printf("Program End.\n\r");
    return 0;
}
