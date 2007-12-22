program glcaps_glut;

uses GL, GLU, GLExt, KambiGlut, KambiGLUtils;

begin
  glutPascalInit;
  glutCreateWindow('glcaps');
  LoadAllExtensions;
  Writeln(GLCapsString);
end.
