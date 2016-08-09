module FStar.DM4F.StExn

let stexn a =
  int -> M (option a * int)

let return (a: Type) (x: a): stexn a =
  fun s ->
    Some x, s

let bind (a: Type) (b: Type) (f: stexn a) (g: a -> Tot (stexn b)): stexn b =
  fun s0 ->
    let tmp = f s0 in
    match tmp with
    | None, s1_fail -> None, s1_fail
    | Some r, s1_proceed -> g r s1_proceed

reifiable reflectable new_effect_for_free {
  STEXN: a:Type -> Effect with
    repr = stexn;
    return = return;
    bind = bind
}

let pre = STEXN.pre
let post = STEXN.post
let wp = STEXN.wp

inline let lift_pure_stexn (a:Type) (wp:pure_wp a) (h0:int) (p:post a) = wp (fun a -> p (Some a, h0))
sub_effect PURE ~> STEXN = lift_pure_stexn
//NOTE: no lift from IntST.STATE to StateExn, since that would break the abstraction of counting abstractions

effect StExn (a:Type) (req:pre) (ens:int -> option a -> int -> GTot Type0) =
       STEXN a
         (fun (h0:int) (p:post a) -> req h0 /\ (forall (r:option a) (h1:int). (req h0 /\ ens h0 r h1) ==> p (r, h1))) (* WP *)

effect S (a:Type) = 
       STEXN a (fun h0 p -> forall x. p x)

//this counts the number of exceptions that are raised
let repr (a:Type) (wp:wp a) =
    n0:int -> PURE (option a * int) (wp n0)

val action_raise : a:Type0 -> Tot (repr a (fun h0 (p:post a) -> p (None, h0 + 1)))
let action_raise a (h:int) = None, h + 1

reifiable let raise (a: Type): STEXN a (fun h0 post -> post (None, h0 + 1)) =
  STEXN.reflect (action_raise a)

//let f = StateExn.reflect (fun h0 -> None, h0); this rightfully fails, since StateExn is not reflectable
val div_intrinsic : i:nat -> j:int -> StExn int
  (requires (fun h -> True))
  (ensures (fun h0 x h1 -> match x with 
			| None -> h0 + 1 = h1 /\ j=0 
			| Some z -> h0 = h1 /\ j<>0 /\ z = i / j))
let div_intrinsic i j =
  if j=0 then raise int
  else i / j

reifiable let div_extrinsic (i:nat) (j:int) : S int =
  if j=0 then raise int
  else i / j

let lemma_div_extrinsic (i:nat) (j:int) :
  Lemma (match reify (div_extrinsic i j) 0 with
         | None, 1 -> j = 0
	 | Some z, 0 -> j <> 0 /\ z = i / j) = ()
