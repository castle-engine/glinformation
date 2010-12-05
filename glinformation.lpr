{
  Copyright 2002-2010 Michalis Kamburelis.

  This file is part of "glinformation".

  "glinformation" is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  "glinformation" is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with "glinformation"; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

  ----------------------------------------------------------------------------
}

{ Print OpenGL information.
  See [http://vrmlengine.sourceforge.net/glinformation.php]. }
program glinformation;

{$apptype CONSOLE}

uses GL, GLU, GLExt, GLWindow, SysUtils, KambiUtils, KambiGLUtils,
  ParseParametersUnit, KambiFilesUtils;

var
  Window: TGLWindow;

const
  Version = '1.2.0';
  Options: array[0..12] of TOption =
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
    (Short: 'v'; Long: 'version'; Argument: oaNone),
    (Short: 'm'; Long: 'multi-sampling'; Argument: oaRequired)
  );

procedure OptionProc(OptionNum: Integer; HasArgument: boolean;
  const Argument: string; const SeparateArgs: TSeparateArgs; Data: Pointer);
begin
 case OptionNum of
  0: begin
      Writeln(
        'glinformation: OpenGL information,' +nl+
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
        '  -m / --multi-sampling SAMPLES (1 means "no multisampling")' +nl+
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
  1: Window.StencilBufferBits := StrToInt(Argument);
  2: Window.AlphaBits := StrToInt(Argument);
  3: Window.DepthBufferBits := StrToInt(Argument);
  4: Window.AccumBufferBits[0] := StrToInt(Argument);
  5: Window.AccumBufferBits[1] := StrToInt(Argument);
  6: Window.AccumBufferBits[2] := StrToInt(Argument);
  7: Window.AccumBufferBits[3] := StrToInt(Argument);
  8: begin
      Window.AccumBufferBits[0] := StrToInt(SeparateArgs[1]);
      Window.AccumBufferBits[1] := StrToInt(SeparateArgs[2]);
      Window.AccumBufferBits[2] := StrToInt(SeparateArgs[3]);
      Window.AccumBufferBits[3] := StrToInt(SeparateArgs[4]);
     end;
  9: Window.DoubleBuffer := false;
  10: Window.DoubleBuffer := true;
  11: begin
       Writeln(Version);
       ProgramBreak;
      end;
  12: Window.MultiSampling := StrToInt(Argument);
  else EInternalError.Create('OptionProc');
 end;
end;

begin
 Window := TGLWindow.Create(Application);

 { parse params }
 { TODO ale nie moje - musze uzyc ponizszych linijek zeby uniknac bledu
   zero_array_bug podczas kompilacji tego programu w FPC 1.0.6/10 pod Windowsem.
   Gdyby wszystko dzialalo to ponizsze dwie linijki nie powinny byc potrzebne.  }
 if IsPresentInPars(['-h', '--help'], false) then
  OptionProc(0, false, '', EmptySeparateArgs, nil);

 Window.ParseParameters(StandardParseOptions);
 ParseParameters(Options, @OptionProc, nil);
 if Parameters.High <> 0 then
  raise EInvalidParams.CreateFmt('Excessive parameter "%s"', [Parameters[1]]);

 Window.Open;
 try
  Writeln(GLInformationString);
 finally Window.Close end;
end.

{
  Local Variables:
  kam-compile-release-command-unix:    "./compile.sh && mv -fv glinformation     glinformation_glut      ~/bin/"
  kam-compile-release-command-windows: "./compile.sh && mv -fv glinformation.exe glinformation_glut.exe c:\\\\bin"
  End:
}