.PHONY: compile
compile:
	./compile.sh

# Run also "dircleaner . clean" here to really clean
.PHONY: clean
clean:
	rm -f glinformation glinformation.exe glinformation_glut glinformation_glut.exe
