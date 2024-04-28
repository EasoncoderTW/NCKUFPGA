/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

/*
 * led.c
 *
 * Created on: 2018/8/23
 * Author: VLSILAB
 */


#include "xparameters.h"
#include "xgpio.h"
#include "xil_printf.h"
#include <xil_types.h>

#define LED_DEVICE_ID  XPAR_AXI_GPIO_0_BASEADDR

#define LED_DELAY     10000000

#define RED    0xdc143c
#define ORANGE 0xff4500
#define YELLOW 0xffd700
#define GREEN  0x00ff7f
#define BLUE   0x1e90ff
#define INDIGO 0x0000cd
#define PURPLE 0x9400d3
#define WHITE  0xffffff

XGpio LED_Gpio;

int main() {
	int LED_Status;
	u8 led_data = 0x00;

	/* Initialize the GPIO driver */
	LED_Status = XGpio_Initialize(&LED_Gpio, LED_DEVICE_ID);
	if (LED_Status != XST_SUCCESS) {
		xil_printf("Gpio Initialization Failed\r\n");
		return XST_FAILURE;
	}
	/* Set the direction for all signals as inputs except the LED output */
	XGpio_SetDataDirection(&LED_Gpio, 1, 0x00);
    u32 colour = RED;
    u8 r, g, b;
    u8 cnt = 0x00; 
    _Bool change = 0;
    int Delay = 0;
    xil_printf("Start !\r\n");
	while (1) {
            if(cnt == 0xff) { cnt = 0; }
            if(Delay == LED_DELAY) {
                change = 1;
                Delay = 0;
            }
            else {
                change = 0;
            }
            switch (colour) {
                case(RED): colour = change == 1 ? ORANGE : RED; break;
                case(ORANGE): colour = change == 1 ? YELLOW : ORANGE; break;
                case(YELLOW): colour = change == 1 ? GREEN : YELLOW; break;
                case(GREEN): colour = change == 1 ? BLUE : GREEN; break;
                case(BLUE): colour = change == 1 ? INDIGO : BLUE; break;
                case(INDIGO): colour = change == 1 ? PURPLE : INDIGO; break;
                case(PURPLE): colour = change == 1 ? RED : PURPLE; break;
                default: colour = RED; break;
            }
            r = cnt < (((colour) >> 16) & (0x0000ff));
            g = cnt < (((colour) >> 8) & (0x0000ff));
            b = cnt < (colour & (0x0000ff));
            led_data = (r << 2) + (g << 1) + b;             
            /* Set the LED*/
			XGpio_DiscreteWrite(&LED_Gpio, 1, led_data);
            cnt++;
            Delay++;
		}

		xil_printf("Successfully ran Gpio Example\r\n");
		return XST_SUCCESS;
}

