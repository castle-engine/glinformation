program glinformation_glut;

uses GL, GLU, GLExt, Glut, KambiGLUtils;

begin
  glutInit(@Argc, Argv);
  glutCreateWindow('glinformation');
  LoadAllExtensions;
  Writeln(GLInformationString);
end.
