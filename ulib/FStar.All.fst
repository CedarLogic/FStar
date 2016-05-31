(*
   Copyright 2008-2014 Nikhil Swamy and Microsoft Research

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*)
module FStar.All
open FStar.Heap
open FStar.ST

let all_pre = all_pre_h heap
let all_post (a:Type) = all_post_h heap a
let all_wp (a:Type) = all_wp_h heap a
new_effect ALL = ALL_h heap

inline let lift_state_all (a:Type) (wp:st_wp a) (is_wlp:bool) (p:all_post a) =  wp is_wlp (fun a -> p (V a))
sub_effect STATE ~> ALL = lift_state_all

inline let lift_exn_all (a:Type) (wp:ex_wp a) (is_wlp:bool) (p:all_post a) (h:heap) = wp is_wlp (fun ra -> p ra h)
sub_effect EXN   ~> ALL = lift_exn_all

effect All (a:Type) (pre:all_pre) (post: (heap -> Tot (all_post a))) =
       ALL a
           (fun (is_wlp:bool) (p:all_post a) (h:heap) -> (is_wlp \/ pre h) /\ (forall ra h1. pre h /\ post h ra h1 ==> p ra h1)) (* WP  *)
effect ML (a:Type) =
  ALL a (all_null_wp heap a)

assume val pipe_right: 'a -> ('a -> 'b) -> 'b
assume val pipe_left: ('a -> 'b) -> 'a -> 'b
assume val failwith: string -> All 'a (fun h -> True) (fun h a h' -> is_Err a /\ h==h')
assume val exit: int -> 'a
assume val try_with: (unit -> 'a) -> (exn -> 'a) -> 'a
