program glinformation_glut;

uses Glut, CastleGLUtils;

begin
  glutInit(@Argc, Argv);
  glutCreateWindow('glinformation');
  LoadAllExtensions;
  Writeln(GLInformationString);
end.
