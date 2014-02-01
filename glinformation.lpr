{
  Copyright 2002-2013 Michalis Kamburelis.

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
  See [http://castle-engine.sourceforge.net/glinformation.php]. }
program glinformation;

{$apptype CONSOLE}

uses CastleWindow, SysUtils, CastleUtils, CastleGLUtils, CastleParameters,
  CastleFilesUtils, CastleLog;

var
  Window: TCastleWindowCustom;

const
  Version = '1.2.2';
  Options: array[0..16] of TOption =
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
    (Short: 'm'; Long: 'multi-sampling'; Argument: oaRequired),
    (Short:  #0; Long: 'red-bits'; Argument: oaRequired),
    (Short:  #0; Long: 'green-bits'; Argument: oaRequired),
    (Short:  #0; Long: 'blue-bits'; Argument: oaRequired),
    (Short:  #0; Long: 'debug-log'; Argument: oaNone)
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
        '  -m / --multi-sampling SAMPLES (1 means "no multisampling")' +nl+
        '  --red-bits BIT' +nl+
        '  --green-bits BIT' +nl+
        '  --blue-bits BIT' +nl+
        'Other options controlling OpenGL context parameters:' +nl+
        '  --single              Single buffered visual (note: we might get' +nl+
        '                        double buffered anyway)' +nl+
        '  --double              Double buffered visual (default)' +nl+
        nl+
        TCastleWindowCustom.ParseParametersHelp(StandardParseOptions, true) +nl+
        nl+
        SCastleEngineProgramHelpSuffix(ApplicationName, Version, true));
      ProgramBreak;
     end;
  1: Window.StencilBits := StrToInt(Argument);
  2: Window.AlphaBits := StrToInt(Argument);
  3: Window.DepthBits := StrToInt(Argument);
  4: Window.DoubleBuffer := false;
  5: Window.DoubleBuffer := true;
  6: begin
       Writeln(Version);
       ProgramBreak;
      end;
  7: Window.MultiSampling := StrToInt(Argument);
  8: Window.RedBits := StrToInt(Argument);
  9: Window.GreenBits := StrToInt(Argument);
  10: Window.BlueBits := StrToInt(Argument);
  11: InitializeLog(Version);
  else EInternalError.Create('OptionProc');
 end;
end;

begin
 Window := TCastleWindowCustom.Create(Application);

 { parse params }
 Window.ParseParameters(StandardParseOptions);
 Parameters.Parse(Options, @OptionProc, nil);
 if Parameters.High <> 0 then
  raise EInvalidParams.CreateFmt('Excessive parameter "%s"', [Parameters[1]]);

 Window.Open;
 try
  Writeln(GLInformationString);
 finally Window.Close end;
end.
