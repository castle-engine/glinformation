program glcaps_glut;

uses OpenGLh, KambiGlut, KambiGLUtils;

begin
  glutPascalInit;
  glutCreateWindow('glcaps');
  ReadImplementationProperties;
  Writeln(GLCapsString);
end.

{
  Local Variables:
  kam-compile-release-command-win32: "fpcreleaseb"
  kam-compile-release-command-unix: "fpcreleaseb"
  End:
}