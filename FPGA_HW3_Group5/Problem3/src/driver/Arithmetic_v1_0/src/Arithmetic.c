

/***************************** Include Files *******************************/
#include "Arithmetic.h"

/************************** Function Definitions ***************************/


u32 Arithmetic_Add(UINTPTR baseAddr, u32 A, u32 B, u32 *overflow) {
	u32 R; 
	A = A & 255;
	B = B & 255;
	u32 data = A + (B << 8) + (0 << 16);
	ARITHMETIC_mWriteReg(baseAddr, 0, data);
	R = ARITHMETIC_mReadReg (baseAddr, 4);
	*overflow = (R >> 8);
	R = (R & 255);
	return R;
}

u32 Arithmetic_Sub(UINTPTR baseAddr, u32 A, u32 B, u32 *overflow) {
	u32 R; 
	A = A & 255;
	B = B & 255;
	u32 data = A + (B << 8) + (1 << 16);
	ARITHMETIC_mWriteReg(baseAddr, 0, data);
	R = ARITHMETIC_mReadReg (baseAddr, 4);
	*overflow = (R >> 8);
	R = (R & 255);
	return R;
}

u32 Arithmetic_Mul(UINTPTR baseAddr, u32 A, u32 B, u32 *overflow) {
	u32 R;
	A = A & 255;
	B = B & 255;
	u32 data = A + (B << 8) + (2 << 16);
	ARITHMETIC_mWriteReg(baseAddr, 0, data);
	R = ARITHMETIC_mReadReg (baseAddr, 4);
	*overflow = (R >> 8);
	R = (R & 255);
	return R;
}
