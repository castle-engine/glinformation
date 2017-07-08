.PHONY: compile
compile:
	./compile.sh

.PHONY: clean
clean:
	rm -Rf glinformation glinformation.exe \
	       glinformation_glut glinformation_glut.exe \
	       glinformation.app glinformation_glut.app \
	       castle-engine-output/
