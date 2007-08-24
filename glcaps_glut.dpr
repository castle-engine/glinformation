program glcaps_glut;

uses OpenGLh, KambiGlut, KambiGLUtils;

begin
  glutPascalInit;
  glutCreateWindow('glcaps');
  ReadImplementationProperties;
  Writeln(GLCapsString);
end.
