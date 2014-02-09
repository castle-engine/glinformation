program glinformation_glut;

uses Glut, CastleGLUtils;

begin
  glutInit(@Argc, Argv);
  glutCreateWindow('glinformation');
  GLInformationInitialize;
  Writeln(GLInformationString);
end.
