program glinformation_glut;

uses GL, GLU, GLExt, KambiGlut, KambiGLUtils;

begin
  glutInit(@Argc, Argv);
  glutCreateWindow('glinformation');
  LoadAllExtensions;
  Writeln(GLInformationString);
end.
