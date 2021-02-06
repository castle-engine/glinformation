.PHONY: compile
compile:
	castle-engine compile

.PHONY: clean
clean:
	rm -Rf glinformation glinformation.exe glinformation.app \
	       castle-engine-output/
