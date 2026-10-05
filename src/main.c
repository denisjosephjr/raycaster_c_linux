#include <stdio.h>
#include <math.h>
#include <SDL3/SDL.h>


// argc: Argument Count, argv: Argument Vector which holds args
int main(int argc, char *argv[]) {

    // Function call to allocate display resources
    SDL_Init(SDL_INIT_VIDEO);

    // Creates a window titled "Test", 640 by 480 pixels, with no flags 0
    SDL_Window *window = SDL_CreateWindow("Test", 640, 480, 0);
    
    // Pauses argument unit is in milliseconds, delays so user can see the window.
    SDL_Delay(3000);
    
    // Destroys window and deallocates memory.
    SDL_Quit();

    return 0;
}
