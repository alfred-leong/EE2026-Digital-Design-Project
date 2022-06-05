# EE2026-Digital-Design-Project
The EE2026 Digital Design Project is a drawing application built with Verilog, Digilent Basys 3 Board, Pmod OLEDrgb 96 x 64 RGB OLED Display and Pmod MIC3. The features are illustrated with pictures and descriptions in the [User_Guide.pdf](/User_Guide.pdf). Some notable features include drawing, saving and playing back frames, setting background images and changing colour which makes it a comprehensive and user-friendly application. Done by Ong Zhi Hong and Alfred Leong.

## Structure

```
Top_Student.v
├── variable_clock.v
├── Audio_Capture.v
├── Oled_Display.v
├── getmaxvalue.v
├── AVL.v
├── AVL_led_display.v
├── draw.v
    ├── colourpalette.v
├── curr_location.v
├── BRAM_test.v
├── save_and_compress.v
    ├── BRAM_pixel.v
    ├── BRAM_frames.v
    ├── BRAM_curr_DUAL.v
├── menu.v
├── getmaxvalue_64_levels.v
├── desert_to_sakura.v
├── BRAM_histo.v
├── BRAM_oasis.v
├── BRAM_sakura.v
```
