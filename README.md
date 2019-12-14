# 2055
*"It would appear that you are incapable of a sufficient level of comprehension necessary to permit meaningful communication."* - [ZAX 1.2](https://fallout.gamepedia.com/ZAX_1.2)

## What's this?
A collection of info and tools for reversing Fallout 1 (and 2, it's largely the same engine).

Since FO1 has been almost 100% ported to the FO2 engine, this project is almost totally meaningless.

See https://github.com/rotators/Fo1in2

More research and documentation available at https://fodev.net/files/fo2/ 

### EXE information
The databases contained in this repo works with Falloutw.exe or falloutwHR.exe shipped with the Fallout 1 version on Steam.

#### Compiler
Fallout 1 was compiled with Watcom C [probably version 10 or 11](https://en.wikipedia.org/wiki/Watcom_C/C%2B%2B#Release_history), the [US patch version 1.2](http://www.nma-fallout.com/resources/fallout-v-1-2-patch-by-teamx-unofficial.54/) (latest official version) was compiled on `Mar 10 1998 18:01:49` / 1998-03-10 (data from `0x43C290` in the exe mentioned below).

#### Calling convention
Up to 4 registers are assigned to arguments in the order eax, edx, ebx, ecx. Arguments are assigned to registers from left to right. If any argument cannot be assigned to a register (say it is too large) it, and all subsequent arguments, are assigned to the stack. Arguments assigned to the stack are pushed from right to left. Names are mangled by adding a suffixed underscore.

eax->func(edx, ebx, ecx, push...)
func(eax, edx, ebx, ecx, push...)

#### Hashes
`MD5`: 212d7b66f75b3c19acbbcb818e6f13bf<br>
`SHA1`:   66ede7f2d6fe409a7d21dfca5f035f8b03d1d236<br>
`SHA256`: 4175afdf5a3fb6f41dd432420a7950c3021a31f05711540d192b9986e3ee02db

### Fallout files
| File               | Description   |
| -------------      | ------------- |
| [MASTER.DAT](master.dat.md)      | General archive with art, maps, scripts, sfx and text
| [CRITTER.DAT](critter.dat.md)     | Animations/graphics for critters.
| [falloutw.exe](falloutw.exe.md)  | Executable

### Repo files
| File               | Description   |
| -------------      | ------------- |
| Falloutw.idc       | [IDA 6.5](https://www.hex-rays.com/products/ida/6.5/index.shtml) database by Crafty.
| Falloutw.ddc32     | My x64dbg database based on own research and the above database

## Fallout file formats
| Format             | Used for      | Reference
| -------------      | ------------- | ----------
| ACM                | Compressed audio format by Interplay | http://falloutmods.wikia.com/wiki/ACM_File_Format
| AAF                | The AAF Font File Format is used to store fonts. | http://falloutmods.wikia.com/wiki/AAF_File_Format
| DAT                | DAT files are archive files in which most of the files used in Fallout and Fallout 2 are stored.     | http://falloutmods.wikia.com/wiki/DAT_file_format
| FRM                | FRM files are unpaletted 256-color image files containing either one or several images in one file   | https://fallout.gamepedia.com/FRM_files
| GAM                | GAM files are indexed text files. They contain global variables for each core Fallout game and its maps | http://falloutmods.wikia.com/wiki/GAM_File_Format
| LST                | LST files are simple text files, each line is terminated with CRLF ("\r\n").                         | http://falloutmods.wikia.com/wiki/LST_File_Format
| PAL                | Palette file, used for rendering FRM data with the correct colors.                                   | http://falloutmods.wikia.com/wiki/PAL_File_Format
| PRO                | Prototype, every item, critter, wall, tile, and piece of scenery has its own corresponding PRO file. | http://falloutmods.wikia.com/wiki/PRO_File_Format
| MAP                | The MAP File Format contains the information for a map used in the game                              | http://falloutmods.wikia.com/wiki/MAP_File_Format
| MVE                | Compressed video file                                                                                | http://falloutmods.wikia.com/wiki/MVE_File_Format
| RIX                | Format for splashscreen, located in master.dat/ART/SPLASH                                            | http://falloutmods.wikia.com/wiki/RIX_File_Format
| INT                | Compiled script file | http://falloutmods.wikia.com/wiki/INT_File_Format
| worldmap.dat       | | http://falloutmods.wikia.com/wiki/Worldmap.dat_File_Format

### Source code
This is a list of source code for working with the above file formats. Working source code is always better than a reference.

| Format             | Source         | Language
| -------------      | -------------- | -------
| ACM                | [ACM library](https://github.com/markokr/libacm) | C
| AAF                | [AAF code from Falltergeist](https://github.com/falltergeist/libfalltergeist/tree/master/src/Aaf) | C++
| DAT                | [My C# implementation](https://github.com/rotators/tools/tree/master/DATLib) - only works on Fallout 2 DAT files though. | C#
| DAT                | [Fallout 1 DAT specification for Katai](https://github.com/kaitai-io/kaitai_struct_formats/blob/master/game/fallout_dat.ksy) | [Katai struct](http://formats.kaitai.io/fallout_dat/index.html)
| DAT                | [Fallout 1 and 2 DAT code in Python](https://github.com/berenm/game-data-reverse-engineering/tree/master/python) | Python
| DAT                | [unDAT by ABel](tools/undat) | Pascal / ASM
| FRM                | [C# code by Rotators / cirn0](https://github.com/rotators/CritterBrowser/blob/master/CritterBrowser/Libs/FOCommon/FalloutFrm.cs) | C#
| GAM                | [GAM code from Falltergeist](https://github.com/falltergeist/libfalltergeist/blob/master/src/Gam/File.cpp) | C++
| PAL                | [Palette parser from darkfo](https://github.com/darkf/darkfo/blob/master/pal.py) | Python
| INT                | [int2ssl script decompiler](https://github.com/falltergeist/int2ssl) | C++

TODO: LST, MAP, MVE, RIX, INT

### Bug fixes
* https://github.com/opsxcq/patch-fallout-1-null-pointer

### Interesting projects
| Project            | Description 
| -------------      | ------------- |
| [Falltergeist](https://github.com/falltergeist/) | Reimplementation of Fallout 2 in c++
| [DarkFO](https://github.com/darkf/darkfo)        | Fallout 2 remake with Typescript and Python.
| [jsFO](https://github.com/ajxs/jsFO)             | Fallout 2 Javascript port

### Tools
* [Tools by Team-x (mirror on fodev.net)](https://fodev.net/files/mirrors/teamx-utils/!_INDEX_en.html).

### External links
* [Sfall - Engine modifications for Fallout 1](https://github.com/Sduibek/sfall_1)
* [Discussion about Sfall 1](http://fforum.kochegarov.com/index.php?showtopic=29288)
* [Fallout database - Very import archive](http://www.nma-fallout.com/threads/fallout-database.200205/)

### Thanks (no certain order)
* Crafty
* Team-X 
* Noid
* Timeslip
* [phobos2077](https://github.com/phobos2077)
* [Sduibek](https://github.com/Sduibek)
* [NovaRain](https://github.com/NovaRain)
* [darkf](https://github.com/darkf)
* [Wipe](https://github.com/wipe2238)
* [Atom](https://github.com/TheAtom)
* [cvet](https://github.com/cvet)
