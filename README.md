# Texas Instruments TI99/4A Clone(ish) Project

![System](images/two.jpg)

Note that this is not a fully tested project at this point. . . .


This is based Rob Krenicki's design that is based on the HackMac KiCAD schematics.  I have made several changes to the original design including:

* Placing 32K of 16bit wide fast ram on the board to fully populate the address space
* Placing an EPROM on the main board that can be used as an on-board cartridge ROM
* adding a header to allow a microcontroller to replace the GROM chips (hopefully this can be moved on-board soon)
* replacing the video DRAM with SRAM
* Adding ATX power support
* Updating the Keyboard header to support a soft caps lock switch on the keyboard PCB
* designing a Cherry MX keyboard
* adding headers for the GROM and expansion port to support riser cards for these ports

## ToDo
* Much more testing . . . (I don't even have the final PCBs here yet)
* write code for the microcontroller running the alpha lock switch toggle on the keyboard
* Create Custom Keycap set
* design 3d printed case
* Cleanup/Documentation

## Bill of Materials
### Console
Qty|Reference(s)|Part|Type
---|------------|----|----
30|C1, C9, C11, C57, C63, C70, C71, C72, C73, C74, C75, C76, C77, C78, C80, C81, C82, C84, C85, C86, C87, C88, C89, C90, C91, C92, C93, C94, C95, C96|0.001uF|Capacitor
1|C2|22pF|Capacitor
3|C3, C5, C58|22uF electroyltic|Electrolytic Capacitor
38|C4, C7, C13, C14, C19, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47, C48, C49, C50, C53, C54, C66, C69|0.1uF|Capacitor
1|C6|1uF|Capacitor
8|C8, C12, C51, C62, C64, C65, C79, C83|0.01uF|Capacitor
1|C10|100uF|Capacitor
6|C15, C16, C17, C18, C20, C21,C52,C59|100uF electrolytic|Electrolytic Capacitor
1|C55|12pF|Capacitor
1|C56|56pF|Capacitor
1|C60|220uF electrolytic|Electrolytic Capacitor
1|C61|0.1uF|Capacitor
1|C67|220pF|Capacitor
1|C68|0.022uF|Capacitor
2|CR1, CR4|1N4148|Diode
2|CR2, CR3|1N914B|Diode
1|D1|LED|LED
1|J1|Pin Header 01x02 Male|Pin Header 01x02 Male
1|J2|Pin Header 01x02 Male|Pin Header 01x02 Male
1|J3|Screw Terminal 1x4|Screw Terminal 1x4
1|J4|Pin Header 01x16 Male Right Angle|Pin Header 01x16 Male Right Angle
2|J5, J6|Pin Header 01x02 Male|Pin Header 01x02 Male
1|J7|Pin Header 01x02 Male|Pin Header 01x02 Male
1|J8|Pin Header 01x02 Male|Pin Header 01x02 Male
1|J9|DB9 Connector Right Angle Male|DB9 Connector Right Angle Male
1|J10|DB9 Connector Right Angle Male|DB9 Connector Right Angle Male
1|J11|Pin Header 01x18 Male|Pin Header 01x18 Male
1|J12|Pin Header 2x22 Male|Pin Header 2x22 Male
1|J14|36 Pin Edge Connector|CONN EDGE DUAL FMALE 36POS 0.100 spacing
1|J15|Pin Header 02x18 Male|Pin Header 02x18 Male
1|J16|Pin Header 01x03 Male|Pin Header 01x03 Male
1|J17|Pin Header 01x03 Male|Pin Header 01x03 Male
1|L1|0.33uH Inductor|Inductor
9|L2, L3, L4, L12, L13, L14, L15, L16, L17|6.8uH  Inductor|Inductor
4|L5, L6, L7, L11|6.8uH  Inductor|Inductor
1|L8|2- 4.5uH  Inductor|Variable Inductor
1|L9|5.8uH  Inductor|Inductor
1|L10, L18, L19, L20, L21|INDUCTOR (BEAD)|Ferrite Bead
8|Q1, Q3, Q4, Q5, Q6, Q7, Q8, Q9|TIS92 Transistor|Transistor
1|Q2|2N3904  Transistor|Transistor
1|R1|150kohm|Resistor
11|R2, R9, R11, R18, R51, R52, R53, R54, R55, R56, R89|1kohm|Resistor
1|R3|12kohm|Resistor
1|R4|47kohm|Resistor
4|R5, R6, R7, R8|22ohm|Resistor
5|R10, R26, R88, R95, R96|4.7kohm|Resistor
5|R12, R13, R14, R15, R16|1Kohm|Resistor
3|R17, R91, R93|2.2kohm|Resistor
11|R19, R30, R63, R65, R67, R69, R71, R75, R77, R79, R82|470ohm|Resistor
1|R20|270ohm|Resistor
1|R21|1.5kohm|Resistor Network 9 pin
1|R22|361ohm|Resistor
4|R23, R35, R60, R81|5.6kohm|Resistor
4|R24, R27, R80, R83|10ohm|Resistor
1|R25|150ohm|Resistor
1|R28|470kohm|Resistor
1|R29|0ohm|Resistor
2|R31, R33|75ohm|Resistor
1|R32|470ohm|Resistor
11|R34, R40, R41, R42, R43, R44, R45, R46, R47, R48, R100|10kohm|Resistor
2|R36, R58|6.8kohm|Resistor
1|R37|2.2kohm|Resistor
1|R38|200ohm|Resistor
1|R39|120kohm|Resistor
1|R49|39kohm|Resistor
1|R50|6.8kohm|Resistor
1|R57|12kohm|Resistor
1|R59|15ohm|Resistor
2|R61, R62|10kohm|Resistor
2|R64, R72|1kohm|Resistor
2|R66, R76|1.5kohm|Resistor
2|R68, R78|270ohm|Resistor
1|R70|9.1kohm|Resistor
2|R73, R74|220ohm|Resistor
4|R84, R85, R86, R87|62ohm|Resistor
1|R90|3.3kohm|Resistor
4|R92, R94, R97, R99|100ohm|Resistor
1|R98|330ohm|Resistor
1|SW1|Dip Switch 6 pos|Dip Switch 6 pos
1|SW2|Pin Header 01x02 Male|Pin Header 01x02 Male
1|U1|TIM9904|IC
1|U2|TMS9900|IC
4|U3, U15, U20, U21|74LS04|IC
2|U4, U9|74LS32|IC
2|U5, U8|74LS138|IC
1|U6|74LS03|IC
1|U7|74LS08|IC
3|U10, U14, U18|74LS00|IC
2|U11, U40|74LS244|IC
1|U12|74LS373|IC
1|U13|74LS245|IC
1|U16|74LS74|IC
1|U17|74LS194|IC
1|U19|LM7905_TO220|IC
3|U22, U23, U24|TMC0430|IC (optional, replaced by Unicorn Board only known source is from TI/994a console)
3|U25, U26, U33|HM62256BLP|IC
2|U27, U28|27C64|IC
1|U29|SN76489|IC
1|U30|TMS9918|IC
3|U31, U32, U34|74LS574|IC
1|U35|TMS9901|IC
1|U36|RC4558|IC
1|U37|74LS156|IC
2|U38, U39|TIL119|IC
2|U41, U42|74LS367|IC
1|U43|74LS379|IC
1|U44|27C010|IC
1|Y1|48.000 MHz Crystal|Crystal
1|Y2|10.7MHz Crystal|Crystal

# Keyboard
Qty|Reference(s)|Value|Part
---|------------|-----|----
1|C1|0.1uF|Capacitor
1|D1|LED|LED
1|D2|LED|LED
1|J1|Pin Header 1x18 male|Pin Header 1x18 male
2|R1, R2|470 ohm|Resistor
1|R3|1K ohm|Resistor
48|SW1-SW48|Mechanical Switch|Cherry MX Switch (or compatible)
1|U1|ATtiny13A-P|IC
1|U2|74LS125|IC
3||Switch Stabilizer 2.25|
1||Switch Stabilizer 6.25|
1||Optional Alignment frame (will need modified)|
|||
|Stabilizers (frame not used):|https://www.amazon.com/Genuine-Cherry-PCB-Snap-Stabilizers/dp/B085T8QZJC|
|Stabilizers (Frame used)|https://www.amazon.com/dp/B082X4V9VC|
|Frame:|https://www.amazon.com/gp/product/B07MMB33WG|

# Cartridge Riser
Qty|Reference(s)|Part|Type
---|------------|----|----
1|J1|Pin Header 01x18 Male|Pin Header 01x18 Male
1|J2|36 Pin Edge Connector|CONN EDGE DUAL FMALE 36POS 0.100 spacing

# IO Riser
Qty|Reference(s)|Part|Type
---|------------|----|----
1|J1|Pin Header 2x22 Male|Pin Header 2x22 Male

# UNICORN BOARD
Qty|Reference(s)|Part|Type
---|------------|----|----
1|J1|Pin Header Socket 01x16 Female Right Angle|Pin Header Socket 01x16 Female Right Angle
4|U1-U4|Level Shifter|https://www.amazon.com/KeeYees-Channels-Converter-Bi-Directional-Shifter/dp/B07LG646VS
1|U5|ESP32 Devkit|https://www.amazon.com/Development-Microcontroller-Integrated-Antenna-Amplifiers/dp/B09GK74F7N


## License

The original project was licensed under the Creative Commons - Attribution - ShareAlike 3.0 License

## Attribution

This board was derrived from works by, uses design elements from, or contains sofware writen by the following:
* Rob Krenicki (https://github.com/rkrenicki/TI99-Motherboard)
* HackMac (https://bitbucket.org/hackmac/ti-schematics/wiki/Home)
