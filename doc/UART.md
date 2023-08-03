# UART pin

## LTF-726x-BH+
This stick has a UART pad pulled out on the board.

Signal level is `3.3V TTL`<br>
Baud rate is `115200 bps`<br>

![LTF-726x-BH+ UART](/Picture/LTF726x/UART.png)

The pads are connected to the CA8271S `15K` and `16K` pin.

![LTF-726x-BH+ X-ray](/Picture/LTF726x/X-ray/01.jpg)


## XG-99S / XE-99S
This stick has UART pulled out to SFP connectors 2 and 7, but no components are mounted.

Signal level is `3.3V TTL`<br>
Baud rate is `115200 bps`<br>

![XG-99S Board](/Picture/XG-99S/05.png)

The UART can be accessed by any of the following methods.
- Touch the needle to a specific point
- Shorting a specific pad to access from SFP

### Touch the needle

x-ray images show that the 15K and 16K pin on the CA8271S are connected to the chip resistors on the backside of the board.

![XG-99S X-ray](/Picture/XG-99S/X-ray/03.jpg)

The UART can be accessed by connecting a wire or touching a needle to the following points.

![XG-99S UART](/Picture/XG-99S/UART.png)

![XG-99S UART needle](/Picture/XG-99S/UART_02.jpg)

### Access from SFP

By shorting these two points with solder, you can access the UART from SFP pins 2 and 7.

TX : `2 pin`<br>
RX : `7 pin`<br>

![XG-99S UART from SFP](/Picture/XG-99S/UART_03.png)

![XG-99S UART Short Point](/Picture/XG-99S/UART_04.png)

Some Sticks will show an extra log echo, which must be suppressed by rewriting mtd2 and mtd5 (dtb0, dtb1)

## XG-99M
This ONT has UART pins mounted on the board.

Signal level is `3.3V TTL`<br>
Baud rate is `115200bps`<br>
