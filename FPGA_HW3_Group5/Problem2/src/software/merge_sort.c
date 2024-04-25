/*
 * led.c
 *
 * Created on: 2018/8/23
 * Author: VLSILAB
 */


#include "xparameters.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "platform.h"

#define SW_DEVICE_ID   XPAR_AXI_GPIO_1_BASEADDR
#define LED_DEVICE_ID  XPAR_AXI_GPIO_0_BASEADDR

#define LED_DELAY     10000000

XGpio LED_Gpio, SW_Gpio;

void merge(int *arr, int start, int mid, int end, int max_to_min_){
	int temp_size = end - start + 1;
	int temp[temp_size];  //variable temp length stored in stack

	for(int i = 0; i< temp_size;i++)
		temp[i] = arr[i+start];

	int left_index = 0;
	int right_index = mid-start+1;
	int left_max = mid-start;
	int right_max = end-start;
	int arr_index = start;

	while(left_index <= left_max && right_index <= right_max){
		if(max_to_min_){
			if(temp[left_index] >= temp[right_index]){
				arr[arr_index] = temp[left_index];
				arr_index++;
				left_index++;
			}
			else{
				arr[arr_index] = temp[right_index];
				arr_index++;
				right_index++;
			}
		}
		else{
			if(temp[left_index] <= temp[right_index]){
				arr[arr_index] = temp[left_index];
				arr_index++;
				left_index++;
			}
			else{
				arr[arr_index] = temp[right_index];
				arr_index++;
				right_index++;
			}
		}
	}
    while(left_index <= left_max){
        arr[arr_index] = temp[left_index];
        arr_index++;
        left_index++;
    }
    while(right_index <= right_max){
        arr[arr_index] = temp[right_index];
        arr_index++;
        right_index++;
    }
}

void mergesort(int *arr, int start, int end, int max_to_min_){
	if(start < end){
		int mid = (end+start)/2;
		mergesort(arr, start, mid, max_to_min_);
		mergesort(arr, mid+1, end, max_to_min_);
		merge(arr, start, mid, end, max_to_min_);
	}
}


int main() {
    init_platform();
	int LED_Status, SW_Status;
	u32 led_data = 0x00, sw_data;

	/* Initialize the GPIO driver */
	LED_Status = XGpio_Initialize(&LED_Gpio, LED_DEVICE_ID);
	SW_Status = XGpio_Initialize(&SW_Gpio, SW_DEVICE_ID);
	if (LED_Status != XST_SUCCESS || SW_Status) {
		xil_printf("Gpio Initialization Failed\r\n");
		return XST_FAILURE;
	}
	/* Set the direction for all signals as inputs except the LED output */
	XGpio_SetDataDirection(&LED_Gpio, 1, 0x00);
	XGpio_SetDataDirection(&SW_Gpio, 1, 0x03);
	int sort_matrix[10]={0};

	while (1) {
    	print("input 10 number to sort\n\r");
		for(int i=0;i<10;i++){
			printf("input %d number\n\r",i+1);
			scanf("%d",&sort_matrix[i]);
            printf("input number is %d\n\r", sort_matrix[i]);
		}


		sw_data = XGpio_DiscreteRead(&SW_Gpio, 1);
		xil_printf("switches data = %d\r\n", sw_data);
		int max_to_min_=sw_data&0x01;

		mergesort(sort_matrix, 0, 9, max_to_min_);

		print("sorted number :\n\r");
		for(int i=0;i<10;i++){
			printf(" %d ",sort_matrix[i]);
		}

		/* Set the LED to High */
		// XGpio_DiscreteWrite(&LED_Gpio, 1, led_data);

		/* Wait a small amount of time so the LED is visible */
		for (int Delay = 0; Delay < LED_DELAY; Delay++);

		// led_data ++;
		/* Clear the LED bit */
		//XGpio_DiscreteClear(&Gpio, LED_CHANNEL, led_data);

		/* Wait a small amount of time so the LED is visible */
		for (int Delay = 0; Delay < LED_DELAY; Delay++);
	}

	xil_printf("Successfully ran Gpio Example\r\n");
    cleanup_platform();
	return XST_SUCCESS;
}

