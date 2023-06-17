# UART pin

## LTF-726x-BH+
This stick has a UART pad pulled out on the board.

Signal level is `3.3V TTL`
Baud rate is `115200 bps`

![LTF-726x-BH+ UART](Picture/LTF726x/UART.png)

The pads are connected to the CA8271S `15K` and `16K` pin.

![LTF-726x-BH+ X-ray](Picture/LTF726x/X-ray/01.jpg)


## XG-99S
This stic does not have the UART pad pulled out and the UART needs to be pulled out from a specific point on the board.

![XG-99S Board](Picture/XG-99S/05.png)

x-ray images show that the 15K and 16K pin on the CA8271S are connected to the chip resistors on the backside of the board.

![XG-99S X-ray](Picture/XG-99S/X-ray/03.jpg)

The UART can be accessed by connecting a wire or touching a needle to the following points.

![XG-99S UART](Picture/XG-99S/UART.png)

Signal level is `3.3V TTL`
Baud rate is `115200 bps`

## XG-99M
This ONT has UART pins mounted on the board.

Signal level is `3.3V TTL`
Baud rate is `115200bps`
