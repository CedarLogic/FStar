(*--build-config
    options:--admit_fsi FStar.Set --admit_fsi Wysteria --admit_fsi FStar.OrdSet --admit_fsi FStar.IO --admit_fsi Smciface;
    other-files:ghost.fst FStar.FunctionalExtensionality.fst FStar.Set.fsi FStar.Heap.fst FStar.ST.fst FStar.All.fst FStar.IO.fsti list.fst listTot.fst st2.fst ordset.fsi ../../prins.fst ../ffi.fst ../wysteria.fsi psipaper.fst
 --*)

module Smciface

open Prins
open FStar.OrdSet

val psi: ps:prins{ps = union (singleton Alice) (singleton Bob)} -> p:prin{mem p ps} -> x:list int -> Tot (list int)
val psi_opt: ps:prins{ps = union (singleton Alice) (singleton Bob)} -> p:prin{mem p ps} -> x:list int -> Tot (list int)
val psi_mono: ps:prins{ps = union (singleton Alice) (singleton Bob)} -> p:prin{mem p ps} -> x:list int -> Tot (list int)
