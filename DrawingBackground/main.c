#include <gb/gb.h>
#include <gb/cgb.h>
#include <stdio.h>
#include "constants.c"

const unsigned char paletteData[] = {
  0x00,0xFF,0x40,0x91,0x68,0x91,0x00,0xFF,
  0x64,0x89,0x36,0xC9,0x16,0xE9,0x00,0xFF
};

const unsigned char mapData[] = {
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0xFF,0xFF,0x00,0x00,0x00,0x00,
};

//first frame
const unsigned char smileyFaceData[] =
{
  0x7A,0x7E,0xFF,0xE5,0xFE,0xC3,0xBF,0xE9,
  0x9F,0xE1,0xDB,0x7F,0x67,0xFF,0xFF,0x7F,
  0xC7,0xB9,0xA5,0xFF,0xE7,0xBD,0xA5,0xFF,
  0x7E,0x7E,0x2C,0x34,0x2C,0x34,0x3C,0x3C
};

//second frame
const unsigned char mouseData1[] =
{
  0x08,0x08,0x1C,0x1C,0x3E,0x2A,0x3E,0x36,
  0x26,0x3A,0x1C,0x14,0x1C,0x14,0x2E,0x32,
  0x2E,0x32,0x26,0x3A,0x22,0x3E,0x1C,0x1C,
  0x08,0x08,0x0C,0x0C,0x04,0x04,0x04,0x04
};

//sprite attributes
unsigned char smileyFace[] =  
{
  50, 50, 0, 0x12
};

void main() {
    int gencounter = 0;
    UWORD idx;
    // our index counter
    disable_interrupts();   // Do not allow interrupts during INIT
    DISPLAY_OFF;    // GBDK macro
    LCDC_REG = 0x47;   // Set some hardware registers for various things like enabling background
    BGP_REG = OBP0_REG = OBP1_REG = 0xE4U;// Set the palette to binary: 11100100 or all 4 colors

    for(idx=0; idx < 0x10; idx++)
        *(unsigned char*)(pallets+idx) = paletteData[idx];    // copy palette data

    for(idx=0; idx < 0x400; idx++)
        *(unsigned char*)(tilemap+idx) = mapData[idx%18];   // create map data

    for(idx=0; idx < 0x40; idx++)
        *(unsigned char*)(vram+idx) = smileyFaceData[idx];   //write sprite data to memory

    DISPLAY_ON;    // GBDK macro
    enable_interrupts();    // allow interrupts as we're out of our INIT stage
  

    while(1) {
        static int y = 60; //coordinates
        static int x = 60;

        static uint8_t joy = 0;
        static int frame = 0;

        disable_interrupts();
        if(frame == 0) {
            for(idx=0; idx < 64; idx++)
                *(unsigned char*)(vram+idx) = mouseData1[idx];   //attempt to update frame.
            frame = 1;
        }
        enable_interrupts();

        *(unsigned char*)(InputData) = requestData; //request input data
        joy = *(unsigned char*)(InputData);  //retrieve input data

        joy = joy&0x0F; //get the relevant 4 bits

        if(joy&J_LEFT)  x++;
        if(joy&J_RIGHT) x--;
        if(joy&J_UP)    y++;
        if(joy&J_DOWN)  y--;

        *(unsigned char*)(0xFF10) = 0xFF;

        smileyFace[0] = y; //set Y position of character
        smileyFace[1] = x; //set X position of character

        for(idx=0; idx < 4; idx++)
            *(unsigned char*)(spriteAttributes+idx) = smileyFace[idx]; //set sprite attributes

        wait_vbl_done();    // wait for VBlank
    }
}
