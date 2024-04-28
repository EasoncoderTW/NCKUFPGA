

/***************************** Include Files *******************************/
#include "Sorting.h"

/************************** Function Definitions ***************************/

/* Sorting 8 4-bit numbers */
u32 Sorting(UINTPTR baseAddr, u32 A) {
	u32 R;
	u32 valid = 0;
	SORTING_mWriteReg(baseAddr, 0, A); // data
	SORTING_mWriteReg(baseAddr, 4, 1); // enable HIGH
	do{
        SORTING_mWriteReg(baseAddr, 4, 0); // enable LOW
		valid = SORTING_mReadReg(baseAddr, 12); // wait VALID
	}while(!valid);

	R = SORTING_mReadReg (baseAddr, 8); // get result
	return R;
}
