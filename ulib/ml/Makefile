FILES=prims.ml FStar_ST.ml FStar_HyperHeap.ml FStar_HST.ml FStar_HyperStack.ml FStar_Mul.ml FStar_Float.ml FStar_Char.ml \
	FStar_Int8.ml FStar_UInt8.ml FStar_Int16.ml FStar_UInt16.ml \
	FStar_Int32.ml FStar_UInt32.ml FStar_Int64.ml FStar_UInt64.ml FStar_UInt128.ml \
	FStar_Int_Cast.ml \
	FStar_BaseTypes.ml \
	FStar_All.ml FStar_IO.ml FStar_Heap.ml FStar_List.ml \
	FStar_Option.ml FStar_String.ml FStar_Set.ml \
	FStar_Buffer.ml

OCAMLOPT=ocamlfind opt -thread -package batteries,zarith,stdint -linkpkg -g $(INCLUDES)
OCAMLDEP=ocamlfind dep
OCAMLMKLIB=ocamlfind mklib

OBJS=$(FILES:.ml=.o)
CMX=$(FILES:.ml=.cmx)

all: $(OBJS)
	ocamlopt -a $(CMX) -o fstarlib.cmxa

# Common rules
.SUFFIXES: .ml .mli .cmo .cmi .cmx

%.o: %.ml
	$(OCAMLOPT) $(OCAMLOPTFLAGS) -c -I $(PRIMS_DIR) -linkpkg $<

depend:
	$(OCAMLDEP) $(FILES) > .depend

CLEAN=*.cmi *.cmo *.cmx *.exe *.o *.a *.cmxa *~

clean:
	rm -f $(CLEAN)

-include .depend
