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
* design 3d printed case
* Cleanup/Documentation

## Bill of Materials
Work In Progress




## License

The original project was licensed under the Creative Commons - Attribution - ShareAlike 3.0 License

## Attribution

This board was derrived from works by, uses design elements from, or contains sofware writen by the following:
* Rob Krenicki (https://github.com/rkrenicki/TI99-Motherboard)
* HackMac (https://bitbucket.org/hackmac/ti-schematics/wiki/Home)
