.PHONY : clean
build:
	ocamlbuild -use-ocamlfind -package core -tag thread ls_sys.native

clean:
	rm -f *.native
	rm -rf _build/
