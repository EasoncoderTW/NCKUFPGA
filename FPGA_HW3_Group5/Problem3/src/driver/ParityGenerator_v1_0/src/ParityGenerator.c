

/***************************** Include Files *******************************/
#include "ParityGenerator.h"

/************************** Function Definitions ***************************/


u32 ParityGenerator(UINTPTR baseAddr, u32 A) {
	u32 R;
	PARITYGENERATOR_mWriteReg(baseAddr, 0, A);
	R = PARITYGENERATOR_mReadReg (baseAddr, 4);
	return R;
}
