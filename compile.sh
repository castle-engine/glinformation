#! /bin/sh
set -eu

# Compile glinformation and glinformation_glut binaries.

if which castle-engine  > /dev/null; then
  # preferred build option: use castle-engine build tool.
  castle-engine simple-compile ${CASTLE_ENGINE_TOOL_OPTIONS:-} glinformation.lpr
  castle-engine simple-compile ${CASTLE_ENGINE_TOOL_OPTIONS:-} glinformation_glut.lpr
else
  # fallback build option: directly call FPC,
  # assuming CGE is in ../castle_game_engine/ .
  #
  # We must do cd ../castle_game_engine/ (and call FPC from that directory)
  # because castle-fpc.cfg file is there and it contains paths relative
  # to that directory.
  cd ../castle_game_engine/
  fpc -dRELEASE ${CASTLE_FPC_OPTIONS:-} @castle-fpc.cfg ../glinformation/glinformation.lpr
  fpc -dRELEASE ${CASTLE_FPC_OPTIONS:-} @castle-fpc.cfg ../glinformation/glinformation_glut.lpr
fi
