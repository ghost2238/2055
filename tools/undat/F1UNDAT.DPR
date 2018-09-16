{$apptype console}
program F1UnDat;
// Fallout 1 DATfile extract
//  uses normal unlz

// Last conseptual modification date: 23.01.2000
// 05.01.2001: Fixed the bug with read-only files.
// 10.01.2001: Copyright changed to ABel [TeamX]

{$r ver.res}

uses sysutils, {unpacklz,} unlzss32;
var op: integer;
    f, f1: file;
    DirCnt, i,j: integer;
    dirs: array [1..100] of string;
    FileCnt: integer;
    buffer: pointer;
const bufSize=$10000;

function ReadReverseDD(var f:file):longint;
var b:byte;
    res:longint;
    a:array [1..4] of byte absolute res;
begin
   res:=0;
   blockread(f,res,4);
   b:=a[1];a[1]:=a[4];a[4]:=b;
   b:=a[2];a[2]:=a[3];a[3]:=b;
   result:=res;
end;
function ReadString(var f:file):string;
var b:byte;
    res:string[255];
begin
   result:='';
   blockread(f,b,1);
   blockread(f,res[1],b);
   SetLength (res, b);
   readstring:=res;
end;
function TrailZeros(d:longint):string;
var i:byte;
begin
   result := IntToStr(d);
   for i:=length(Result)+1 to 10 do Result:=' '+Result;
end;

procedure Unpack (len: integer);
var bytesToRead: word;
    c2: integer;
    bytesLeft: integer;
begin
   while len>0 do
   begin
      blockread (f, bytesToRead, 2);
      bytesToRead := (Lo(bytesToRead) shl 8) + Hi(bytesToRead);
      bytesLeft := bytesToRead and $7FFF;
      if bytesToRead and $8000<>0 then
      begin
         // copy bytesLeft into output stream
         blockread (f, buffer^, bytesLeft, c2);
         write('.');
      end else
      begin
         // unpack bytesLeft
//         c2 := UnLZ (f, buffer^, bytesLeft);
         c2 := LzUnSquash (f, buffer^, bytesLeft);
         write ('#');
      end;
      blockwrite (f1, buffer^, c2);
      dec (len, c2);
   end;
end;

procedure MyCreateDir (s: string);
var i:integer;
    p, r: string;
begin
   if s='' then exit;
   if s[Length(s)]<>'\' then s:=s+'\';
   r:='';
   i:=1;
   while i<>0 do
   begin
      i:=pos('\',s);
      if i<>0 then
      begin
         p:=copy(s,1,i-1);
         delete(s,1,i);
         r:=r+p+'\';
         CreateDir(r);
      end;
   end;
end;

procedure Copy(var ffrom:file; sto:string; l, att:longint);
var r: integer;
begin
   write(sto,' ');
   MyCreateDir (ExtractFileDir(sto));
   assign (f1, sto); rewrite(f1,1);

   if att = $20 then
   begin
      write (#9'plain file  ');
      while l<>0 do
      begin
         if l>bufSize then r:=bufSize else r:=l;
         blockread(ffrom, buffer^ ,r ,r);
         blockwrite(f1,buffer^,r);
         write('.');
         l:=l-r;
      end;
   end
   else if att=$40 then
   begin
      write (#9'packed file  ');
      unpack (l);
   end;

   writeln;
   close(f1);
end;

var s, s1, s2: string[255];
    att, sp, fl: integer;
    oldPos: integer;
    par1: string;
begin
   writeln ('Fallout 1 DAT-file extractor v1.2, (c) 1999-2001 ABel [TeamX]');
// 05.01.2001   The read-only files cannot be opened with the default FileMode
   FileMode := 0;
try
   if ParamCount < 2 then
   begin
      writeln (#13#10'Usage:  F1UNDAT <cmd> <dat_file_name> [name_part]');
      writeln ('Commands:');
      writeln ('    -l   list files in DAT');
      writeln ('    -ep  extract files which names begin with name_part (Prefix)');
      writeln ('    -es  extract files which names end with name_part   (Suffix)');
      writeln ('If no name_part specified in -E commands all the files will be extracted.');
      writeln (#13#10'Examples:');
      writeln ('F1UnDat -ep master.dat art\cuts');
      writeln ('    extract all the files beginning with ART\CUTS');
      writeln ('F1UnDat -es master.dat frm');
      writeln ('    extract all the files ending with FRM');
      writeln (#13#10'Note:');
      writeln ('    "." in output means that the file or block of file is stored as is,');
      writeln ('    "#" - block of the file is compressed with LZSS.');
      halt;
   end;
   par1 := UpperCase(ParamStr(1));
   if par1='-L' then op:=1
   else if par1='-EP' then op:=2
   else if par1='-ES' then op:=3
   else halt;

   s2 := ParamStr(3)+#0;

   assign(f,ParamStr(2));reset(f,1);
   getmem (buffer, bufSize);

   DirCnt:=readreversedd(f);

// 23.01.2000   No DAT file has zero directories
// это я просто заглючил, видимо
//   if DirCnt>0 then
//   begin
//     readreversedd(f);
//     readreversedd(f);
//   end else
//     DirCnt := 1;

   readreversedd(f);
   readreversedd(f);
   readreversedd(f);
   for i:=1 to DirCnt do
      dirs[i] := ReadString(f);

   for i:=1 to DirCnt do
   begin
      FileCnt:=readreversedd(f);
        readreversedd(f);
        readreversedd(f);
        readreversedd(f);
      for j:=1 to FileCnt do
      begin
         s:=readstring(f);
           att:=readreversedd(f);
           sp:=readreversedd(f); {startpos}
           fl:=readreversedd(f);
           readreversedd(f);

         if dirs[i]='.' then s1:=s
         else s1:=dirs[i]+'\'+s;
         if op=1 then
         begin
            write(trailzeros(fl),' ');
            if att=$20 then write('. ') else
            if att=$40 then write('# ') else
               write('? ');
            writeln(s1);
         end
         else begin
            s1 := s1+#0;
            if ((op=2) and (StrLIComp (@s1[1],@s2[1], Length(s2)-1)=0)) or
               ((op=3) and (StrLIComp (pointer(integer(@s1[1])+length(s1)-length(s2)),@s2[1], Length(s2)-1)=0)) then
            begin
               delete (s1, length(s1), 1);
               oldPos := filePos(f);
               seek (f, sp);
               copy (f, s1, fl, att);
               seek (f, oldPos);
            end;
         end;
      end;
   end;

   freemem (buffer, bufSize);
   close (f);
except
   on e:Exception do
   begin
      writeln;
      writeln ('Error: ', E.Message);
   end;
end;
end.
