#include <gb/gb.h>
#include <stdio.h>
#include <stdint.h>
#include "SmilerSprites.c"

void main(){
    UINT8 SpriteIndex = 0;
    

    set_sprite_data(0, 2, Smiler);//load 2 sprites into memory
    set_sprite_tile(0, 0);
    move_sprite(0, 88, 78);
    SHOW_SPRITES;

    while(1){//GameLoop
        if(SpriteIndex == 0)
            SpriteIndex = 1;
        else
            SpriteIndex = 0;

            
        set_sprite_tile(0, SpriteIndex);
        scroll_sprite(0, 1, 0);
        delay(100);
    }
}
