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
	.globl _set_sprite_data
	.globl _delay
	.globl _Smiler
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
_Smiler::
	.ds 32
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
;main.c:6: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:7: UINT8 SpriteIndex = 0;
	ld	c, #0x00
;main.c:10: set_sprite_data(0, 2, Smiler);//load 2 sprites into memory
	ld	de, #_Smiler
	push	de
	ld	hl, #0x200
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;c:\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ld	a, #0x4e
	ld	(hl+), a
	ld	(hl), #0x58
;main.c:13: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:15: while(1){//GameLoop
00105$:
;main.c:16: if(SpriteIndex == 0)
	ld	a, c
	or	a, a
;main.c:17: SpriteIndex = 1;
;main.c:19: SpriteIndex = 0;
	ld	c, #0x01
	jr	Z, 00103$
	ld	c, #0x00
00103$:
;c:\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), c
;c:\gbdk\include\gb\gb.h:1893: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
;c:\gbdk\include\gb\gb.h:1894: itm->y+=y, itm->x+=x;
	ld	a, (de)
	ld	(de), a
	inc	de
	ld	a, (de)
	inc	a
	ld	(de), a
;main.c:24: delay(100);
	push	bc
	ld	de, #0x0064
	call	_delay
	pop	bc
;main.c:26: }
	jr	00105$
	.area _CODE
	.area _INITIALIZER
__xinit__Smiler:
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xbd	; 189
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.area _CABS (ABS)
