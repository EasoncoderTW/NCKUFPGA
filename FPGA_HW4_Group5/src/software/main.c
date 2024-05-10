#include <stdio.h>
#include "xil_printf.h"
#include "xil_io.h"
#include "xparameters.h"

// reference "address editor" in vivado block design
#define XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR 0x40000000
#define XPAR_AXI_BRAM_CTRL_1_S_AXI_BASEADDR 0x40000000


int main()
{
	// test initial value & port A read
    printf("Test initial value & port A read:\r\n");
    read = Xil_In32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + 0);
    printf("[Port A: R] Offset =   0, Data = %x\r\n", read);
    read = Xil_In32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + 4);
    printf("[Port A: R] Offset =   4, Data = %x\r\n", read);
    read = Xil_In32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + 28);
    printf("[Port A: R] Offset =  28, Data = %x\r\n", read);
    read = Xil_In32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + 64);
    printf("[Port A: R] Offset =  64, Data = %x\r\n", read);
    printf("===================\n");

    // test port A write
    printf("Test port A write:\r\n");
    for (i = 0; i < 4; i++) {
        read = Xil_In32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + 4*i);
        printf("[Port A: W] Offset = %3d, Data = %x -> %x\r\n", 4*i, read, a[i]);
        Xil_Out32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + 4*i, a[i]);
        printf("Check: MEM[%x] = %x\r\n", XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + 4*i, Xil_In32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + 4*i));
        printf("-------------------\n");
    }
    printf("===================\n");

    // test port B R/W
    printf("Test port B read & write:\r\n");
    for (i = 0; i < 20; i++) {
        read = Xil_In32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + 4*(i+1));
        printf("[Port A: R] Offset = %3d, Data = %x\r\n", 4*(i+1), read);
        read2 = Xil_In32(XPAR_AXI_BRAM_CTRL_1_S_AXI_BASEADDR + 4*i);
        printf("[Port B: R] Offset = %3d, Data = %x\r\n", 4*i, read2);
        printf("[Port B: W] Offset = %3d, Data = %x -> %x\r\n", 4*i, read2, read);
        Xil_Out32(XPAR_AXI_BRAM_CTRL_1_S_AXI_BASEADDR + 4*i, read);
        printf("Check: MEM[%x] = %x\r\n", XPAR_AXI_BRAM_CTRL_1_S_AXI_BASEADDR + 4*i, Xil_In32(XPAR_AXI_BRAM_CTRL_1_S_AXI_BASEADDR + 4*i));
        printf("-------------------\n");
    }
    printf("===================\n");

    return 0;
}


