;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _display_off
	.globl _wait_vbl_done
	.globl _smileyFace
	.globl _requestData
	.globl _spriteAttributes
	.globl _InputData
	.globl _tilemap
	.globl _pallets
	.globl _vram
	.globl _mouseData1
	.globl _smileyFaceData
	.globl _mapData
	.globl _paletteData
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_vram::
	.ds 2
_pallets::
	.ds 2
_tilemap::
	.ds 2
_InputData::
	.ds 2
_spriteAttributes::
	.ds 2
_requestData::
	.ds 2
_smileyFace::
	.ds 4
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:40: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;c:\gbdk\include\gb\gb.h:754: __asm__("di");
	di
;main.c:45: DISPLAY_OFF;    // GBDK macro
	call	_display_off
;main.c:46: LCDC_REG = 0x47;   // Set some hardware registers for various things like enabling background
	ld	a, #0x47
	ldh	(_LCDC_REG + 0), a
;main.c:47: BGP_REG = OBP0_REG = OBP1_REG = 0xE4U;// Set the palette to binary: 11100100 or all 4 colors
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;main.c:55: for(idx=0; idx < 0x40; idx++)
	ld	bc, #0x0000
00108$:
;main.c:56: *(unsigned char*)(vram+idx) = smileyFaceData[idx];   //write sprite data to memory
	ld	a, c
	ld	hl, #_vram
	add	a, (hl)
	inc	hl
	ld	e, a
	ld	a, b
	adc	a, (hl)
	ld	d, a
	ld	hl, #_smileyFaceData
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;main.c:55: for(idx=0; idx < 0x40; idx++)
	inc	bc
	ld	a, c
	sub	a, #0x40
	ld	a, b
	sbc	a, #0x00
	jr	C, 00108$
;main.c:58: DISPLAY_ON;    // GBDK macro
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:738: __asm__("ei");
	ei
;main.c:92: for(idx=0; idx < 4; idx++)
00116$:
	ld	bc, #0x0000
00110$:
;main.c:93: *(unsigned char*)(spriteAttributes+idx) = smileyFace[idx]; //set sprite attributes
	ld	a, c
	ld	hl, #_spriteAttributes
	add	a, (hl)
	inc	hl
	ld	e, a
	ld	a, b
	adc	a, (hl)
	ld	d, a
	ld	hl, #_smileyFace
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;main.c:92: for(idx=0; idx < 4; idx++)
	inc	bc
	ld	a, c
	sub	a, #0x04
	ld	a, b
	sbc	a, #0x00
	jr	C, 00110$
;main.c:95: wait_vbl_done();    // wait for VBlank
	call	_wait_vbl_done
;main.c:97: }
	jr	00116$
_paletteData:
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0x91	; 145
	.db #0x68	; 104	'h'
	.db #0x91	; 145
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x64	; 100	'd'
	.db #0x89	; 137
	.db #0x36	; 54	'6'
	.db #0xc9	; 201
	.db #0x16	; 22
	.db #0xe9	; 233
	.db #0x00	; 0
	.db #0xff	; 255
_mapData:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_smileyFaceData:
	.db #0x7a	; 122	'z'
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0xe5	; 229
	.db #0xfe	; 254
	.db #0xc3	; 195
	.db #0xbf	; 191
	.db #0xe9	; 233
	.db #0x9f	; 159
	.db #0xe1	; 225
	.db #0xdb	; 219
	.db #0x7f	; 127
	.db #0x67	; 103	'g'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xc7	; 199
	.db #0xb9	; 185
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0xe7	; 231
	.db #0xbd	; 189
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x2c	; 44
	.db #0x34	; 52	'4'
	.db #0x2c	; 44
	.db #0x34	; 52	'4'
	.db #0x3c	; 60
	.db #0x3c	; 60
_mouseData1:
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x3e	; 62
	.db #0x2a	; 42
	.db #0x3e	; 62
	.db #0x36	; 54	'6'
	.db #0x26	; 38
	.db #0x3a	; 58
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x2e	; 46
	.db #0x32	; 50	'2'
	.db #0x2e	; 46
	.db #0x32	; 50	'2'
	.db #0x26	; 38
	.db #0x3a	; 58
	.db #0x22	; 34
	.db #0x3e	; 62
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.area _CODE
	.area _INITIALIZER
__xinit__vram:
	.dw #0x8000
__xinit__pallets:
	.dw #0x9000
__xinit__tilemap:
	.dw #0x9800
__xinit__InputData:
	.dw #0xff00
__xinit__spriteAttributes:
	.dw #0xfe00
__xinit__requestData:
	.dw #0x0020
__xinit__smileyFace:
	.db #0x32	; 50	'2'
	.db #0x32	; 50	'2'
	.db #0x00	; 0
	.db #0x12	; 18
	.area _CABS (ABS)
