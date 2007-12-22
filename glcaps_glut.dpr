program glcaps_glut;

uses GL, GLU, GLExt, KambiGlut, KambiGLUtils;

begin
  glutPascalInit;
  glutCreateWindow('glcaps');
  ReadImplementationProperties;
  Writeln(GLCapsString);
end.
