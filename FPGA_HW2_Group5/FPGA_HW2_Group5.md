# 第五組 FPGA Design HW2 說明文件

## Basic Infomation

| 組員姓名 | 學號      |
| -------- | --------- |
| 蔣嘉寶   | E24096687 |
| 葉榮蒼   | E24094716 |
| 葉宣佑   | E24096695 |



## Problem 1 - Breathing Light

- [youtube link](https://youtu.be/awRDKmbT3NU)

### Block Design Diagram

![image (7)](https://hackmd.io/_uploads/S1JOFNYeR.png)

### 電路行為說明

- Brightness Level
    - LED4 always **steady brightness**
    - LED5 always **breathing**

- LED Colour
  | input | bit width | LED Colour                                                                                                                                                                                                                                                                           |
  | ----- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
  | sw    | 2 bits    | `b00` : <span style="color: darkorchid;">darkorchid</span>(0x9932cc) <br> `b01` : <span style="color: dodgerblue;">dodgerblue</span>(0x1e90ff) <br> `b10` : <span style="color: gold;">gold</span>(0xffd700) <br> `b11` : <span style="color: orangered;">orangered</span>(0xff4500) |
  | btn   | 1 bit     | if `btn` is set to 1, colour will be <span style="color: white;">white</span>                                                                                                                                                                                                        |

### 電路設計說明

設計上分為兩個 module，一個是 PWM decoder，一個是 RGB LED

- PWM decoder
    這個 module 主要的功能是根據 sw(switch) 的輸入決定 RGB 的值
- RGB LED
    這個 module 需要完成兩件事，一個是根據 PWM decoder 的輸入值產生對應的 LED 顏色，另外一件事是要使其中一個 LED 有呼吸燈的效果。這兩個都是透過 Pulse-width modulation(PWM) 的技術在時間維度上切出不同顏色顯示的比例或者亮暗的比例以達到不同顏色以及明暗變化的表現。

## Problem 2 - Rainbow Breathing Light

- [youtube link](https://youtube.com/shorts/vUJnZLJ0TWk)

### Block Design Diagram

![image (8)](https://hackmd.io/_uploads/BJC6a4YxR.png)

### 電路行為說明

- LED4 的顏色從紅開始紫結束為一循環，會持續循環
- 按下 btn 則顏色變為白色
- 按下 reset 則顏色從紅色開始

### 電路設計說明

這次的設計都包在一個 module 中，這個 module 的行為與第一題的 RGB LED 大致相同，但額外實作了一個 state machine 以完成顏色的連續轉換。

- 定義不同顏色的 hex code
```verilog=
`define RED 24'hdc143c
`define ORANGE 24'hff4500
`define YELLOW 24'hffd700
`define BLUE 24'h1e90ff
`define INDIGO 24'h0000cd
`define PURPLE 24'h9400d3
`define WHITE 24'hffffff
```
- 設定顏色轉換的條件，這裡的轉換條件為暗->亮->暗時，變換 state，而每個 state 則對應與名稱相同的顏色輸出
```verilog=
always @(*) begin
    st_next = st_cur;
    case (st_cur)
        sRED:
            if(cnt3==2 && cnt2==0 && end_cnt0) begin
                st_next = sORANGE;
            end
        sORANGE:
            if(cnt3==2 && cnt2==0 && end_cnt0) begin
                st_next = sYELLOW;
            end
        sYELLOW:
            if(cnt3==2 && cnt2==0 && end_cnt0) begin
                st_next = sBLUE;
            end       
        sBLUE:
            if(cnt3==2 && cnt2==0 && end_cnt0) begin
                st_next = sINDIGO;
            end
        sINDIGO:
            if(cnt3==2 && cnt2==0 && end_cnt0) begin
                st_next = sPURPLE;
            end
        sPURPLE:
            if(cnt3==2 && cnt2==0 && end_cnt0) begin
                st_next = sRED;
            end
        default: st_next = sRED;
    endcase
end
```

## 文件問題

我的做法是每 0.8 秒完成暗->亮或亮->暗的變化，其中將 0.8 秒的變化切成 1000 個 phase。我認為 phase 切分的大小影響的是變化的連續性，如果切得越細觀察起來亮暗變化更明顯接近 continuous 的變化，如果切得比較少就會更接近 discrete 的變化。