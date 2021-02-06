# glinformation

A tiny utility that prints a lot of information about OpenGL, which describes the 3D rendering capabilities of your system and graphic card.

This utility uses [Castle Game Engine](https://castle-engine.io/).

Note that if you already use [Castle Game Engine](https://castle-engine.io/) or [view3dscene](https://castle-engine.io/view3dscene.php), you can:

- Get the same information by running `view3dscene` and using menu item _Help -> OpenGL Information_.

- Query the same information in your applications using [GLInformationString function](https://castle-engine.io/apidoc-unstable/html/CastleGLUtils.html#GLInformationString).

## Optional command-line options

You can call `glinformation` with some of the options listed below. Requested OpenGL context will have given capabilities (in case of bit sizes, you specify the <i>minimum</i> requested bit size). They are useful to check e.g. is your graphic card able to provide 16-bit stencil buffer.

```
-s / --stencil-bits STENCIL-BUFFER-BIT-SIZE
-a / --alpha-bits ALPHA-CHANNEL-BIT-SIZE
-d / --depth-bits DEPTH-BUFFER-BIT-SIZE
--multi-sampling SAMPLES # 1 means "no multisampling"
--single
--double
```

Also all [standard options understood by CGE OpenGL programs](https://castle-engine.io/opengl_options.php) are allowed, see also [standard command-line options understood by all CGE programs](https://castle-engine.io/common_options.php).

## License

GNU GPL >= 2.
