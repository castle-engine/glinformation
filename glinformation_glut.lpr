program glinformation_glut;

uses Glut, KambiGLUtils;

begin
  glutInit(@Argc, Argv);
  glutCreateWindow('glinformation');
  LoadAllExtensions;
  Writeln(GLInformationString);
end.
