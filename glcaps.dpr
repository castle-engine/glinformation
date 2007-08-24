{
  Copyright 2002-2005,2007 Michalis Kamburelis.

  This file is part of "glcaps".

  "glcaps" is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  "glcaps" is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with "glcaps"; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

program glcaps;

{$apptype CONSOLE}

uses OpenGLh, GLWindow, GLW_Win, SysUtils, KambiUtils, KambiGLUtils,
  ParseParametersUnit, KambiFilesUtils;

const
  Version = '1.1.1';
  Options: array[0..11] of TOption =
  (
    (Short: 'h'; Long: 'help'; Argument: oaNone),
    (Short: 's'; Long: 'stencil-bits'; Argument: oaRequired),
    (Short: 'a'; Long: 'alpha-bits'; Argument: oaRequired),
    (Short: 'd'; Long: 'depth-bits'; Argument: oaRequired),
    (Short:  #0; Long: 'accum-red-bits'; Argument: oaRequired),
    (Short:  #0; Long: 'accum-green-bits'; Argument: oaRequired),
    (Short:  #0; Long: 'accum-blue-bits'; Argument: oaRequired),
    (Short:  #0; Long: 'accum-alpha-bits'; Argument: oaRequired),
    (Short:  #0; Long: 'accum-bits'; Argument: oaRequired4Separate),
    (Short:  #0; Long: 'single'; Argument: oaNone),
    (Short:  #0; Long: 'double'; Argument: oaNone),
    (Short: 'v'; Long: 'version'; Argument: oaNone)
  );

procedure OptionProc(OptionNum: Integer; HasArgument: boolean;
  const Argument: string; const SeparateArgs: TSeparateArgs; Data: Pointer);
begin
 case OptionNum of
  0: begin
      Writeln(
        'glcaps: OpenGL capabilities,' +nl+
        '  a small program that creates OpenGL context and uses it to query' +nl+
        '  OpenGL implementation about many things. Results are output to stdout.' +nl+
        nl+
        'Available options:' +nl+
        HelpOptionHelp +nl+
        VersionOptionHelp +nl+
        nl+
        'Options requesting that OpenGL context be created with certain' +nl+
        '  minimum values:' +nl+
        '  -s / --stencil-bits STENCIL-BUFFER-BIT-SIZE' +nl+
        '  -a / --alpha-bits ALPHA-CHANNEL-BIT-SIZE' +nl+
        '  -d / --depth-bits DEPTH-BUFFER-BIT-SIZE' +nl+
        '  --accum-red-bits ACCUM-RED' +nl+
        '  --accum-green-bits ACCUM-GREEN' +nl+
        '  --accum-blue-bits ACCUM-BLUE' +nl+
        '  --accum-alpha-bits ACCUM-ALPHA' +nl+
        '  --accum-bits ACCUM-RED ACCUM-GREEN ACCUM-BLUE ACCUM-ALPHA' +nl+
        'Other options controlling OpenGL context parameters:' +nl+
        '  --single              Single buffered visual (note: we might get' +nl+
        '                        double buffered anyway)' +nl+
        '  --double              Double buffered visual (default)' +nl+
        nl+
        TGLWindow.ParseParametersHelp(StandardParseOptions, true) +nl+
        nl+
        SVrmlEngineProgramHelpSuffix(ProgramName, Version, true));
      ProgramBreak;
     end;
  1: glw.StencilBufferBits := StrToInt(Argument);
  2: glw.AlphaBits := StrToInt(Argument);
  3: glw.DepthBufferBits := StrToInt(Argument);
  4: glw.AccumBufferBits[0] := StrToInt(Argument);
  5: glw.AccumBufferBits[1] := StrToInt(Argument);
  6: glw.AccumBufferBits[2] := StrToInt(Argument);
  7: glw.AccumBufferBits[3] := StrToInt(Argument);
  8: begin
      glw.AccumBufferBits[0] := StrToInt(SeparateArgs[1]);
      glw.AccumBufferBits[1] := StrToInt(SeparateArgs[2]);
      glw.AccumBufferBits[2] := StrToInt(SeparateArgs[3]);
      glw.AccumBufferBits[3] := StrToInt(SeparateArgs[4]);
     end;
  9: glw.DoubleBuffer := false;
  10: glw.DoubleBuffer := true;
  11: begin
       Writeln(Version);
       ProgramBreak;
      end;
  else EInternalError.Create('OptionProc');
 end;
end;

begin
 { parse params }
 { TODO ale nie moje - musze uzyc ponizszych linijek zeby uniknac bledu
   zero_array_bug podczas kompilacji tego programu w FPC 1.0.6/10 pod Windowsem.
   Gdyby wszystko dzialalo to ponizsze dwie linijki nie powinny byc potrzebne.  }
 if IsPresentInPars(['-h', '--help'], false) then
  OptionProc(0, false, '', EmptySeparateArgs, nil);

 glw.ParseParameters(StandardParseOptions);
 ParseParameters(Options, @OptionProc, nil);
 if Parameters.High <> 0 then
  raise EInvalidParams.CreateFmt('Excessive parameter "%s"', [Parameters[1]]);

 glw.Init;
 try
  Writeln(GLCapsString);
 finally glw.Close end;
end.

{
  Local Variables:
  kam-compile-release-command-unix:  "./compile.sh && mv -fv glcaps     glcaps_glut      ~/bin/"
  kam-compile-release-command-win32: "./compile.sh && mv -fv glcaps.exe glcaps_glut.exe c:/bin/"
  End:
}