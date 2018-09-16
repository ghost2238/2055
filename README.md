# 2055
*"It would appear that you are incapable of a sufficient level of comprehension necessary to permit meaningful communication."* - [ZAX 1.2](https://fallout.gamepedia.com/ZAX_1.2)

## What's this?
A collection of info and tools for reversing Fallout 1 (and 2, it's largely the same engine).

### EXE information
The databases contained in this repo works with Falloutw.exe or falloutwHR.exe shipped with the Fallout 1 version on Steam.

### Compiler
Fallout 1 was compiled with Watcom C [probably version 10 or 11](https://en.wikipedia.org/wiki/Watcom_C/C%2B%2B#Release_history), the [US patch version 1.2](http://www.nma-fallout.com/resources/fallout-v-1-2-patch-by-teamx-unofficial.54/) (latest official version) was compiled on `Mar 10 1998 18:01:49` / 1998-03-10 (data from `0x43C290` in the exe mentioned below).

#### Calling convention
Up to 4 registers are assigned to arguments in the order eax, edx, ebx, ecx. Arguments are assigned to registers from left to right. If any argument cannot be assigned to a register (say it is too large) it, and all subsequent arguments, are assigned to the stack. Arguments assigned to the stack are pushed from right to left. Names are mangled by adding a suffixed underscore.

eax->func(edx, ebx, ecx, push...)<br>
func(eax, edx, ebx, ecx, push...)

#### Hashes
`MD5`: 212d7b66f75b3c19acbbcb818e6f13bf<br>
`SHA1`:   66ede7f2d6fe409a7d21dfca5f035f8b03d1d236<br>
`SHA256`: 4175afdf5a3fb6f41dd432420a7950c3021a31f05711540d192b9986e3ee02db

### Files
| File               | Description   |
| -------------      | ------------- |
| Falloutw.idc       | [IDA 6.5](https://www.hex-rays.com/products/ida/6.5/index.shtml) database by Crafty.
| Falloutw.ddc32     | My x64dbg database based on own research and the above database

## Fallout file formats
| Format             | Used for      | Reference
| -------------      | ------------- | ----------
| DAT                | DAT files are archive files in which most of the files used in Fallout and Fallout 2 are stored.   | https://fallout.gamepedia.com/DAT_files
| FRM                | FRM files are unpaletted 256-color image files containing either one or several images in one file | https://fallout.gamepedia.com/FRM_files
| PAL                | Palette file, used for rendering FRM data with the correct colors.                                 | http://falloutmods.wikia.com/wiki/PAL_File_Format

#### Source code ####
This is a list of source code for working with the above file formats. Working source code is always better than a reference.

| Format             | Source         | Language
| -------------      | -------------- | -------
| DAT                | [My C# implementation](https://github.com/rotators/tools/tree/master/DATLib) - only works on Fallout 2 DAT files though. | C#
| DAT                | [Fallout 1 DAT specification for Katai](https://github.com/kaitai-io/kaitai_struct_formats/blob/master/game/fallout_dat.ksy) | [Katai struct](http://formats.kaitai.io/fallout_dat/index.html)

### Bug fixes
* https://github.com/opsxcq/patch-fallout-1-null-pointer

### Interesting projects
| Project            | Description 
| -------------      | ------------- |
| [Falltergeist](https://github.com/falltergeist/) | Reimplementation of Fallout 2 in c++
| [DarkFO](https://github.com/darkf/darkfo)        | Fallout 2 remake with Typescript and Python.
| [jsFO](https://github.com/ajxs/jsFO)             | Fallout 2 Javascript port

### External links
* [Sfall - Engine modifications for Fallout 1](https://github.com/Sduibek/sfall_1)
* [Discussion about Sfall 1](http://fforum.kochegarov.com/index.php?showtopic=29288)
* [Fallout database - Very import archive](http://www.nma-fallout.com/threads/fallout-database.200205/)
