
open Prims

type sort =
| Bool_sort
| Int_sort
| Kind_sort
| Type_sort
| Term_sort
| String_sort
| Ref_sort
| Fuel_sort
| Array of (sort * sort)
| Arrow of (sort * sort)
| Sort of Prims.string


let is_Bool_sort = (fun _discr_ -> (match (_discr_) with
| Bool_sort (_) -> begin
true
end
| _ -> begin
false
end))


let is_Int_sort = (fun _discr_ -> (match (_discr_) with
| Int_sort (_) -> begin
true
end
| _ -> begin
false
end))


let is_Kind_sort = (fun _discr_ -> (match (_discr_) with
| Kind_sort (_) -> begin
true
end
| _ -> begin
false
end))


let is_Type_sort = (fun _discr_ -> (match (_discr_) with
| Type_sort (_) -> begin
true
end
| _ -> begin
false
end))


let is_Term_sort = (fun _discr_ -> (match (_discr_) with
| Term_sort (_) -> begin
true
end
| _ -> begin
false
end))


let is_String_sort = (fun _discr_ -> (match (_discr_) with
| String_sort (_) -> begin
true
end
| _ -> begin
false
end))


let is_Ref_sort = (fun _discr_ -> (match (_discr_) with
| Ref_sort (_) -> begin
true
end
| _ -> begin
false
end))


let is_Fuel_sort = (fun _discr_ -> (match (_discr_) with
| Fuel_sort (_) -> begin
true
end
| _ -> begin
false
end))


let is_Array = (fun _discr_ -> (match (_discr_) with
| Array (_) -> begin
true
end
| _ -> begin
false
end))


let is_Arrow = (fun _discr_ -> (match (_discr_) with
| Arrow (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sort = (fun _discr_ -> (match (_discr_) with
| Sort (_) -> begin
true
end
| _ -> begin
false
end))


let ___Array____0 = (fun projectee -> (match (projectee) with
| Array (_47_10) -> begin
_47_10
end))


let ___Arrow____0 = (fun projectee -> (match (projectee) with
| Arrow (_47_13) -> begin
_47_13
end))


let ___Sort____0 = (fun projectee -> (match (projectee) with
| Sort (_47_16) -> begin
_47_16
end))


let rec strSort : sort  ->  Prims.string = (fun x -> (match (x) with
| Bool_sort -> begin
"Bool"
end
| Int_sort -> begin
"Int"
end
| Kind_sort -> begin
"Kind"
end
| Type_sort -> begin
"Type"
end
| Term_sort -> begin
"Term"
end
| String_sort -> begin
"String"
end
| Ref_sort -> begin
"Ref"
end
| Fuel_sort -> begin
"Fuel"
end
| Array (s1, s2) -> begin
(let _140_54 = (strSort s1)
in (let _140_53 = (strSort s2)
in (FStar_Util.format2 "(Array %s %s)" _140_54 _140_53)))
end
| Arrow (s1, s2) -> begin
(let _140_56 = (strSort s1)
in (let _140_55 = (strSort s2)
in (FStar_Util.format2 "(%s -> %s)" _140_56 _140_55)))
end
| Sort (s) -> begin
s
end))


type op =
| True
| False
| Not
| And
| Or
| Imp
| Iff
| Eq
| LT
| LTE
| GT
| GTE
| Add
| Sub
| Div
| Mul
| Minus
| Mod
| ITE
| Var of Prims.string


let is_True = (fun _discr_ -> (match (_discr_) with
| True (_) -> begin
true
end
| _ -> begin
false
end))


let is_False = (fun _discr_ -> (match (_discr_) with
| False (_) -> begin
true
end
| _ -> begin
false
end))


let is_Not = (fun _discr_ -> (match (_discr_) with
| Not (_) -> begin
true
end
| _ -> begin
false
end))


let is_And = (fun _discr_ -> (match (_discr_) with
| And (_) -> begin
true
end
| _ -> begin
false
end))


let is_Or = (fun _discr_ -> (match (_discr_) with
| Or (_) -> begin
true
end
| _ -> begin
false
end))


let is_Imp = (fun _discr_ -> (match (_discr_) with
| Imp (_) -> begin
true
end
| _ -> begin
false
end))


let is_Iff = (fun _discr_ -> (match (_discr_) with
| Iff (_) -> begin
true
end
| _ -> begin
false
end))


let is_Eq = (fun _discr_ -> (match (_discr_) with
| Eq (_) -> begin
true
end
| _ -> begin
false
end))


let is_LT = (fun _discr_ -> (match (_discr_) with
| LT (_) -> begin
true
end
| _ -> begin
false
end))


let is_LTE = (fun _discr_ -> (match (_discr_) with
| LTE (_) -> begin
true
end
| _ -> begin
false
end))


let is_GT = (fun _discr_ -> (match (_discr_) with
| GT (_) -> begin
true
end
| _ -> begin
false
end))


let is_GTE = (fun _discr_ -> (match (_discr_) with
| GTE (_) -> begin
true
end
| _ -> begin
false
end))


let is_Add = (fun _discr_ -> (match (_discr_) with
| Add (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sub = (fun _discr_ -> (match (_discr_) with
| Sub (_) -> begin
true
end
| _ -> begin
false
end))


let is_Div = (fun _discr_ -> (match (_discr_) with
| Div (_) -> begin
true
end
| _ -> begin
false
end))


let is_Mul = (fun _discr_ -> (match (_discr_) with
| Mul (_) -> begin
true
end
| _ -> begin
false
end))


let is_Minus = (fun _discr_ -> (match (_discr_) with
| Minus (_) -> begin
true
end
| _ -> begin
false
end))


let is_Mod = (fun _discr_ -> (match (_discr_) with
| Mod (_) -> begin
true
end
| _ -> begin
false
end))


let is_ITE = (fun _discr_ -> (match (_discr_) with
| ITE (_) -> begin
true
end
| _ -> begin
false
end))


let is_Var = (fun _discr_ -> (match (_discr_) with
| Var (_) -> begin
true
end
| _ -> begin
false
end))


let ___Var____0 = (fun projectee -> (match (projectee) with
| Var (_47_38) -> begin
_47_38
end))


type qop =
| Forall
| Exists


let is_Forall = (fun _discr_ -> (match (_discr_) with
| Forall (_) -> begin
true
end
| _ -> begin
false
end))


let is_Exists = (fun _discr_ -> (match (_discr_) with
| Exists (_) -> begin
true
end
| _ -> begin
false
end))


type term' =
| Integer of Prims.string
| BoundV of Prims.int
| FreeV of fv
| App of (op * term Prims.list)
| Quant of (qop * pat Prims.list Prims.list * Prims.int Prims.option * sort Prims.list * term) 
 and term =
{tm : term'; hash : Prims.string; freevars : fvs FStar_Absyn_Syntax.memo} 
 and pat =
term 
 and fv =
(Prims.string * sort) 
 and fvs =
fv Prims.list


let is_Integer = (fun _discr_ -> (match (_discr_) with
| Integer (_) -> begin
true
end
| _ -> begin
false
end))


let is_BoundV = (fun _discr_ -> (match (_discr_) with
| BoundV (_) -> begin
true
end
| _ -> begin
false
end))


let is_FreeV = (fun _discr_ -> (match (_discr_) with
| FreeV (_) -> begin
true
end
| _ -> begin
false
end))


let is_App = (fun _discr_ -> (match (_discr_) with
| App (_) -> begin
true
end
| _ -> begin
false
end))


let is_Quant = (fun _discr_ -> (match (_discr_) with
| Quant (_) -> begin
true
end
| _ -> begin
false
end))


let is_Mkterm : term  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkterm"))))


let ___Integer____0 = (fun projectee -> (match (projectee) with
| Integer (_47_44) -> begin
_47_44
end))


let ___BoundV____0 = (fun projectee -> (match (projectee) with
| BoundV (_47_47) -> begin
_47_47
end))


let ___FreeV____0 = (fun projectee -> (match (projectee) with
| FreeV (_47_50) -> begin
_47_50
end))


let ___App____0 = (fun projectee -> (match (projectee) with
| App (_47_53) -> begin
_47_53
end))


let ___Quant____0 = (fun projectee -> (match (projectee) with
| Quant (_47_56) -> begin
_47_56
end))


type caption =
Prims.string Prims.option


type binders =
(Prims.string * sort) Prims.list


type projector =
(Prims.string * sort)


type constructor_t =
(Prims.string * projector Prims.list * sort * Prims.int)


type constructors =
constructor_t Prims.list


type decl =
| DefPrelude
| DeclFun of (Prims.string * sort Prims.list * sort * caption)
| DefineFun of (Prims.string * sort Prims.list * sort * term * caption)
| Assume of (term * caption)
| Caption of Prims.string
| Eval of term
| Echo of Prims.string
| Push
| Pop
| CheckSat


let is_DefPrelude = (fun _discr_ -> (match (_discr_) with
| DefPrelude (_) -> begin
true
end
| _ -> begin
false
end))


let is_DeclFun = (fun _discr_ -> (match (_discr_) with
| DeclFun (_) -> begin
true
end
| _ -> begin
false
end))


let is_DefineFun = (fun _discr_ -> (match (_discr_) with
| DefineFun (_) -> begin
true
end
| _ -> begin
false
end))


let is_Assume = (fun _discr_ -> (match (_discr_) with
| Assume (_) -> begin
true
end
| _ -> begin
false
end))


let is_Caption = (fun _discr_ -> (match (_discr_) with
| Caption (_) -> begin
true
end
| _ -> begin
false
end))


let is_Eval = (fun _discr_ -> (match (_discr_) with
| Eval (_) -> begin
true
end
| _ -> begin
false
end))


let is_Echo = (fun _discr_ -> (match (_discr_) with
| Echo (_) -> begin
true
end
| _ -> begin
false
end))


let is_Push = (fun _discr_ -> (match (_discr_) with
| Push (_) -> begin
true
end
| _ -> begin
false
end))


let is_Pop = (fun _discr_ -> (match (_discr_) with
| Pop (_) -> begin
true
end
| _ -> begin
false
end))


let is_CheckSat = (fun _discr_ -> (match (_discr_) with
| CheckSat (_) -> begin
true
end
| _ -> begin
false
end))


let ___DeclFun____0 = (fun projectee -> (match (projectee) with
| DeclFun (_47_60) -> begin
_47_60
end))


let ___DefineFun____0 = (fun projectee -> (match (projectee) with
| DefineFun (_47_63) -> begin
_47_63
end))


let ___Assume____0 = (fun projectee -> (match (projectee) with
| Assume (_47_66) -> begin
_47_66
end))


let ___Caption____0 = (fun projectee -> (match (projectee) with
| Caption (_47_69) -> begin
_47_69
end))


let ___Eval____0 = (fun projectee -> (match (projectee) with
| Eval (_47_72) -> begin
_47_72
end))


let ___Echo____0 = (fun projectee -> (match (projectee) with
| Echo (_47_75) -> begin
_47_75
end))


type decls_t =
decl Prims.list


let fv_eq : fv  ->  fv  ->  Prims.bool = (fun x y -> ((Prims.fst x) = (Prims.fst y)))


let fv_sort = (fun x -> (Prims.snd x))


let freevar_eq : term  ->  term  ->  Prims.bool = (fun x y -> (match (((x.tm), (y.tm))) with
| (FreeV (x), FreeV (y)) -> begin
(fv_eq x y)
end
| _47_87 -> begin
false
end))


let freevar_sort : term  ->  sort = (fun _47_1 -> (match (_47_1) with
| {tm = FreeV (x); hash = _47_92; freevars = _47_90} -> begin
(fv_sort x)
end
| _47_97 -> begin
(FStar_All.failwith "impossible")
end))


let fv_of_term : term  ->  fv = (fun _47_2 -> (match (_47_2) with
| {tm = FreeV (fv); hash = _47_102; freevars = _47_100} -> begin
fv
end
| _47_107 -> begin
(FStar_All.failwith "impossible")
end))


let rec freevars : term  ->  fv Prims.list = (fun t -> (match (t.tm) with
| (Integer (_)) | (BoundV (_)) -> begin
[]
end
| FreeV (fv) -> begin
(fv)::[]
end
| App (_47_118, tms) -> begin
(FStar_List.collect freevars tms)
end
| Quant (_47_123, _47_125, _47_127, _47_129, t) -> begin
(freevars t)
end))


let free_variables : term  ->  fvs = (fun t -> (match ((FStar_ST.read t.freevars)) with
| Some (b) -> begin
b
end
| None -> begin
(

let fvs = (let _140_277 = (freevars t)
in (FStar_Util.remove_dups fv_eq _140_277))
in (

let _47_138 = (FStar_ST.op_Colon_Equals t.freevars (Some (fvs)))
in fvs))
end))


let qop_to_string : qop  ->  Prims.string = (fun _47_3 -> (match (_47_3) with
| Forall -> begin
"forall"
end
| Exists -> begin
"exists"
end))


let op_to_string : op  ->  Prims.string = (fun _47_4 -> (match (_47_4) with
| True -> begin
"true"
end
| False -> begin
"false"
end
| Not -> begin
"not"
end
| And -> begin
"and"
end
| Or -> begin
"or"
end
| Imp -> begin
"implies"
end
| Iff -> begin
"iff"
end
| Eq -> begin
"="
end
| LT -> begin
"<"
end
| LTE -> begin
"<="
end
| GT -> begin
">"
end
| GTE -> begin
">="
end
| Add -> begin
"+"
end
| Sub -> begin
"-"
end
| Div -> begin
"div"
end
| Mul -> begin
"*"
end
| Minus -> begin
"-"
end
| Mod -> begin
"mod"
end
| ITE -> begin
"ite"
end
| Var (s) -> begin
s
end))


let weightToSmt : Prims.int Prims.option  ->  Prims.string = (fun _47_5 -> (match (_47_5) with
| None -> begin
""
end
| Some (i) -> begin
(let _140_284 = (FStar_Util.string_of_int i)
in (FStar_Util.format1 ":weight %s\n" _140_284))
end))


let rec hash_of_term' : term'  ->  Prims.string = (fun t -> (match (t) with
| Integer (i) -> begin
i
end
| BoundV (i) -> begin
(let _140_287 = (FStar_Util.string_of_int i)
in (Prims.strcat "@" _140_287))
end
| FreeV (x) -> begin
(let _140_289 = (let _140_288 = (strSort (Prims.snd x))
in (Prims.strcat ":" _140_288))
in (Prims.strcat (Prims.fst x) _140_289))
end
| App (op, tms) -> begin
(let _140_294 = (let _140_293 = (let _140_292 = (let _140_291 = (FStar_List.map (fun t -> t.hash) tms)
in (FStar_All.pipe_right _140_291 (FStar_String.concat " ")))
in (Prims.strcat _140_292 ")"))
in (Prims.strcat (op_to_string op) _140_293))
in (Prims.strcat "(" _140_294))
end
| Quant (qop, pats, wopt, sorts, body) -> begin
(let _140_302 = (let _140_295 = (FStar_List.map strSort sorts)
in (FStar_All.pipe_right _140_295 (FStar_String.concat " ")))
in (let _140_301 = (weightToSmt wopt)
in (let _140_300 = (let _140_299 = (FStar_All.pipe_right pats (FStar_List.map (fun pats -> (let _140_298 = (FStar_List.map (fun p -> p.hash) pats)
in (FStar_All.pipe_right _140_298 (FStar_String.concat " "))))))
in (FStar_All.pipe_right _140_299 (FStar_String.concat "; ")))
in (FStar_Util.format5 "(%s (%s)(! %s %s %s))" (qop_to_string qop) _140_302 body.hash _140_301 _140_300))))
end))


let __all_terms : term FStar_Util.smap FStar_ST.ref = (let _140_303 = (FStar_Util.smap_create (Prims.parse_int "10000"))
in (FStar_ST.alloc _140_303))


let all_terms : Prims.unit  ->  term FStar_Util.smap = (fun _47_190 -> (match (()) with
| () -> begin
(FStar_ST.read __all_terms)
end))


let mk : term'  ->  term = (fun t -> (

let key = (hash_of_term' t)
in (match ((let _140_308 = (all_terms ())
in (FStar_Util.smap_try_find _140_308 key))) with
| Some (tm) -> begin
tm
end
| None -> begin
(

let tm = (let _140_309 = (FStar_Util.mk_ref None)
in {tm = t; hash = key; freevars = _140_309})
in (

let _47_197 = (let _140_310 = (all_terms ())
in (FStar_Util.smap_add _140_310 key tm))
in tm))
end)))


let mkTrue : term = (mk (App (((True), ([])))))


let mkFalse : term = (mk (App (((False), ([])))))


let mkInteger : Prims.string  ->  term = (fun i -> (mk (Integer (i))))


let mkInteger' : Prims.int  ->  term = (fun i -> (let _140_316 = (let _140_315 = (FStar_Util.string_of_int i)
in Integer (_140_315))
in (mk _140_316)))


let mkBoundV : Prims.int  ->  term = (fun i -> (mk (BoundV (i))))


let mkFreeV : (Prims.string * sort)  ->  term = (fun x -> (mk (FreeV (x))))


let mkApp' : (op * term Prims.list)  ->  term = (fun f -> (mk (App (f))))


let mkApp : (Prims.string * term Prims.list)  ->  term = (fun _47_206 -> (match (_47_206) with
| (s, args) -> begin
(mk (App (((Var (s)), (args)))))
end))


let mkNot : term  ->  term = (fun t -> (match (t.tm) with
| App (True, _47_210) -> begin
mkFalse
end
| App (False, _47_215) -> begin
mkTrue
end
| _47_219 -> begin
(mkApp' ((Not), ((t)::[])))
end))


let mkAnd : (term * term)  ->  term = (fun _47_222 -> (match (_47_222) with
| (t1, t2) -> begin
(match (((t1.tm), (t2.tm))) with
| (App (True, _47_225), _47_229) -> begin
t2
end
| (_47_232, App (True, _47_235)) -> begin
t1
end
| ((App (False, _), _)) | ((_, App (False, _))) -> begin
mkFalse
end
| (App (And, ts1), App (And, ts2)) -> begin
(mkApp' ((And), ((FStar_List.append ts1 ts2))))
end
| (_47_265, App (And, ts2)) -> begin
(mkApp' ((And), ((t1)::ts2)))
end
| (App (And, ts1), _47_276) -> begin
(mkApp' ((And), ((FStar_List.append ts1 ((t2)::[])))))
end
| _47_279 -> begin
(mkApp' ((And), ((t1)::(t2)::[])))
end)
end))


let mkOr : (term * term)  ->  term = (fun _47_282 -> (match (_47_282) with
| (t1, t2) -> begin
(match (((t1.tm), (t2.tm))) with
| ((App (True, _), _)) | ((_, App (True, _))) -> begin
mkTrue
end
| (App (False, _47_301), _47_305) -> begin
t2
end
| (_47_308, App (False, _47_311)) -> begin
t1
end
| (App (Or, ts1), App (Or, ts2)) -> begin
(mkApp' ((Or), ((FStar_List.append ts1 ts2))))
end
| (_47_325, App (Or, ts2)) -> begin
(mkApp' ((Or), ((t1)::ts2)))
end
| (App (Or, ts1), _47_336) -> begin
(mkApp' ((Or), ((FStar_List.append ts1 ((t2)::[])))))
end
| _47_339 -> begin
(mkApp' ((Or), ((t1)::(t2)::[])))
end)
end))


let mkImp : (term * term)  ->  term = (fun _47_342 -> (match (_47_342) with
| (t1, t2) -> begin
(match (((t1.tm), (t2.tm))) with
| (_47_344, App (True, _47_347)) -> begin
mkTrue
end
| (App (True, _47_353), _47_357) -> begin
t2
end
| (_47_360, App (Imp, (t1')::(t2')::[])) -> begin
(let _140_335 = (let _140_334 = (let _140_333 = (mkAnd ((t1), (t1')))
in (_140_333)::(t2')::[])
in ((Imp), (_140_334)))
in (mkApp' _140_335))
end
| _47_369 -> begin
(mkApp' ((Imp), ((t1)::(t2)::[])))
end)
end))


let mk_bin_op : op  ->  (term * term)  ->  term = (fun op _47_373 -> (match (_47_373) with
| (t1, t2) -> begin
(mkApp' ((op), ((t1)::(t2)::[])))
end))


let mkMinus : term  ->  term = (fun t -> (mkApp' ((Minus), ((t)::[]))))


let mkIff : (term * term)  ->  term = (mk_bin_op Iff)


let mkEq : (term * term)  ->  term = (mk_bin_op Eq)


let mkLT : (term * term)  ->  term = (mk_bin_op LT)


let mkLTE : (term * term)  ->  term = (mk_bin_op LTE)


let mkGT : (term * term)  ->  term = (mk_bin_op GT)


let mkGTE : (term * term)  ->  term = (mk_bin_op GTE)


let mkAdd : (term * term)  ->  term = (mk_bin_op Add)


let mkSub : (term * term)  ->  term = (mk_bin_op Sub)


let mkDiv : (term * term)  ->  term = (mk_bin_op Div)


let mkMul : (term * term)  ->  term = (mk_bin_op Mul)


let mkMod : (term * term)  ->  term = (mk_bin_op Mod)


let mkITE : (term * term * term)  ->  term = (fun _47_378 -> (match (_47_378) with
| (t1, t2, t3) -> begin
(match (((t2.tm), (t3.tm))) with
| (App (True, _47_381), App (True, _47_386)) -> begin
mkTrue
end
| (App (True, _47_392), _47_396) -> begin
(let _140_356 = (let _140_355 = (mkNot t1)
in ((_140_355), (t3)))
in (mkImp _140_356))
end
| (_47_399, App (True, _47_402)) -> begin
(mkImp ((t1), (t2)))
end
| (_47_407, _47_409) -> begin
(mkApp' ((ITE), ((t1)::(t2)::(t3)::[])))
end)
end))


let mkCases : term Prims.list  ->  term = (fun t -> (match (t) with
| [] -> begin
(FStar_All.failwith "Impos")
end
| (hd)::tl -> begin
(FStar_List.fold_left (fun out t -> (mkAnd ((out), (t)))) hd tl)
end))


let mkQuant : (qop * pat Prims.list Prims.list * Prims.int Prims.option * sort Prims.list * term)  ->  term = (fun _47_423 -> (match (_47_423) with
| (qop, pats, wopt, vars, body) -> begin
if ((FStar_List.length vars) = (Prims.parse_int "0")) then begin
body
end else begin
(match (body.tm) with
| App (True, _47_426) -> begin
body
end
| _47_430 -> begin
(mk (Quant (((qop), (pats), (wopt), (vars), (body)))))
end)
end
end))


let abstr : fvs  ->  term  ->  term = (fun fvs t -> (

let nvars = (FStar_List.length fvs)
in (

let index_of = (fun fv -> (match ((FStar_Util.try_find_index (fv_eq fv) fvs)) with
| None -> begin
None
end
| Some (i) -> begin
Some ((nvars - (i + (Prims.parse_int "1"))))
end))
in (

let rec aux = (fun ix t -> (match ((FStar_ST.read t.freevars)) with
| Some ([]) -> begin
t
end
| _47_445 -> begin
(match (t.tm) with
| (Integer (_)) | (BoundV (_)) -> begin
t
end
| FreeV (x) -> begin
(match ((index_of x)) with
| None -> begin
t
end
| Some (i) -> begin
(mkBoundV (i + ix))
end)
end
| App (op, tms) -> begin
(let _140_374 = (let _140_373 = (FStar_List.map (aux ix) tms)
in ((op), (_140_373)))
in (mkApp' _140_374))
end
| Quant (qop, pats, wopt, vars, body) -> begin
(

let n = (FStar_List.length vars)
in (let _140_377 = (let _140_376 = (FStar_All.pipe_right pats (FStar_List.map (FStar_List.map (aux (ix + n)))))
in (let _140_375 = (aux (ix + n) body)
in ((qop), (_140_376), (wopt), (vars), (_140_375))))
in (mkQuant _140_377)))
end)
end))
in (aux (Prims.parse_int "0") t)))))


let inst : term Prims.list  ->  term  ->  term = (fun tms t -> (

let n = (FStar_List.length tms)
in (

let rec aux = (fun shift t -> (match (t.tm) with
| (Integer (_)) | (FreeV (_)) -> begin
t
end
| BoundV (i) -> begin
if (((Prims.parse_int "0") <= (i - shift)) && ((i - shift) < n)) then begin
(FStar_List.nth tms (i - shift))
end else begin
t
end
end
| App (op, tms) -> begin
(let _140_387 = (let _140_386 = (FStar_List.map (aux shift) tms)
in ((op), (_140_386)))
in (mkApp' _140_387))
end
| Quant (qop, pats, wopt, vars, body) -> begin
(

let m = (FStar_List.length vars)
in (

let shift = (shift + m)
in (let _140_390 = (let _140_389 = (FStar_All.pipe_right pats (FStar_List.map (FStar_List.map (aux shift))))
in (let _140_388 = (aux shift body)
in ((qop), (_140_389), (wopt), (vars), (_140_388))))
in (mkQuant _140_390))))
end))
in (aux (Prims.parse_int "0") t))))


let mkQuant' : (qop * term Prims.list Prims.list * Prims.int Prims.option * fvs * term)  ->  term = (fun _47_501 -> (match (_47_501) with
| (qop, pats, wopt, vars, body) -> begin
(let _140_396 = (let _140_395 = (FStar_All.pipe_right pats (FStar_List.map (FStar_List.map (abstr vars))))
in (let _140_394 = (FStar_List.map fv_sort vars)
in (let _140_393 = (abstr vars body)
in ((qop), (_140_395), (wopt), (_140_394), (_140_393)))))
in (mkQuant _140_396))
end))


let mkForall'' : (pat Prims.list Prims.list * Prims.int Prims.option * sort Prims.list * term)  ->  term = (fun _47_506 -> (match (_47_506) with
| (pats, wopt, sorts, body) -> begin
(mkQuant ((Forall), (pats), (wopt), (sorts), (body)))
end))


let mkForall' : (pat Prims.list Prims.list * Prims.int Prims.option * fvs * term)  ->  term = (fun _47_511 -> (match (_47_511) with
| (pats, wopt, vars, body) -> begin
(mkQuant' ((Forall), (pats), (wopt), (vars), (body)))
end))


let mkForall : (pat Prims.list Prims.list * fvs * term)  ->  term = (fun _47_515 -> (match (_47_515) with
| (pats, vars, body) -> begin
(mkQuant' ((Forall), (pats), (None), (vars), (body)))
end))


let mkExists : (pat Prims.list Prims.list * fvs * term)  ->  term = (fun _47_519 -> (match (_47_519) with
| (pats, vars, body) -> begin
(mkQuant' ((Exists), (pats), (None), (vars), (body)))
end))


let mkDefineFun : (Prims.string * (Prims.string * sort) Prims.list * sort * term * caption)  ->  decl = (fun _47_525 -> (match (_47_525) with
| (nm, vars, s, tm, c) -> begin
(let _140_409 = (let _140_408 = (FStar_List.map fv_sort vars)
in (let _140_407 = (abstr vars tm)
in ((nm), (_140_408), (s), (_140_407), (c))))
in DefineFun (_140_409))
end))


let constr_id_of_sort : sort  ->  Prims.string = (fun sort -> (let _140_412 = (strSort sort)
in (FStar_Util.format1 "%s_constr_id" _140_412)))


let fresh_token : (Prims.string * sort)  ->  Prims.int  ->  decl = (fun _47_529 id -> (match (_47_529) with
| (tok_name, sort) -> begin
(let _140_425 = (let _140_424 = (let _140_423 = (let _140_422 = (mkInteger' id)
in (let _140_421 = (let _140_420 = (let _140_419 = (constr_id_of_sort sort)
in (let _140_418 = (let _140_417 = (mkApp ((tok_name), ([])))
in (_140_417)::[])
in ((_140_419), (_140_418))))
in (mkApp _140_420))
in ((_140_422), (_140_421))))
in (mkEq _140_423))
in ((_140_424), (Some ("fresh token"))))
in Assume (_140_425))
end))


let constructor_to_decl : constructor_t  ->  decls_t = (fun _47_535 -> (match (_47_535) with
| (name, projectors, sort, id) -> begin
(

let id = (FStar_Util.string_of_int id)
in (

let cdecl = (let _140_429 = (let _140_428 = (FStar_All.pipe_right projectors (FStar_List.map Prims.snd))
in ((name), (_140_428), (sort), (Some ("Constructor"))))
in DeclFun (_140_429))
in (

let n_bvars = (FStar_List.length projectors)
in (

let bvar_name = (fun i -> (let _140_432 = (FStar_Util.string_of_int i)
in (Prims.strcat "x_" _140_432)))
in (

let bvar_index = (fun i -> (n_bvars - (i + (Prims.parse_int "1"))))
in (

let bvar = (fun i s -> (let _140_440 = (let _140_439 = (bvar_name i)
in ((_140_439), (s)))
in (mkFreeV _140_440)))
in (

let bvars = (FStar_All.pipe_right projectors (FStar_List.mapi (fun i _47_550 -> (match (_47_550) with
| (_47_548, s) -> begin
(bvar i s)
end))))
in (

let bvar_names = (FStar_List.map fv_of_term bvars)
in (

let capp = (mkApp ((name), (bvars)))
in (

let cid_app = (let _140_444 = (let _140_443 = (constr_id_of_sort sort)
in ((_140_443), ((capp)::[])))
in (mkApp _140_444))
in (

let cid = (let _140_450 = (let _140_449 = (let _140_448 = (let _140_447 = (let _140_446 = (let _140_445 = (mkInteger id)
in ((_140_445), (cid_app)))
in (mkEq _140_446))
in ((((capp)::[])::[]), (bvar_names), (_140_447)))
in (mkForall _140_448))
in ((_140_449), (Some ("Constructor distinct"))))
in Assume (_140_450))
in (

let disc_name = (Prims.strcat "is-" name)
in (

let xfv = (("x"), (sort))
in (

let xx = (mkFreeV xfv)
in (

let disc_eq = (let _140_455 = (let _140_454 = (let _140_452 = (let _140_451 = (constr_id_of_sort sort)
in ((_140_451), ((xx)::[])))
in (mkApp _140_452))
in (let _140_453 = (mkInteger id)
in ((_140_454), (_140_453))))
in (mkEq _140_455))
in (

let proj_terms = (FStar_All.pipe_right projectors (FStar_List.map (fun _47_562 -> (match (_47_562) with
| (proj, s) -> begin
(mkApp ((proj), ((xx)::[])))
end))))
in (

let disc_inv_body = (let _140_458 = (let _140_457 = (mkApp ((name), (proj_terms)))
in ((xx), (_140_457)))
in (mkEq _140_458))
in (

let disc_ax = (mkAnd ((disc_eq), (disc_inv_body)))
in (

let disc = (mkDefineFun ((disc_name), ((xfv)::[]), (Bool_sort), (disc_ax), (Some ("Discriminator definition"))))
in (

let projs = (let _140_469 = (FStar_All.pipe_right projectors (FStar_List.mapi (fun i _47_570 -> (match (_47_570) with
| (name, s) -> begin
(

let cproj_app = (mkApp ((name), ((capp)::[])))
in (let _140_468 = (let _140_467 = (let _140_466 = (let _140_465 = (let _140_464 = (let _140_463 = (let _140_462 = (let _140_461 = (bvar i s)
in ((cproj_app), (_140_461)))
in (mkEq _140_462))
in ((((capp)::[])::[]), (bvar_names), (_140_463)))
in (mkForall _140_464))
in ((_140_465), (Some ("Projection inverse"))))
in Assume (_140_466))
in (_140_467)::[])
in (DeclFun (((name), ((sort)::[]), (s), (Some ("Projector")))))::_140_468))
end))))
in (FStar_All.pipe_right _140_469 FStar_List.flatten))
in (let _140_476 = (let _140_471 = (let _140_470 = (FStar_Util.format1 "<start constructor %s>" name)
in Caption (_140_470))
in (_140_471)::(cdecl)::(cid)::projs)
in (let _140_475 = (let _140_474 = (let _140_473 = (let _140_472 = (FStar_Util.format1 "</end constructor %s>" name)
in Caption (_140_472))
in (_140_473)::[])
in (FStar_List.append ((disc)::[]) _140_474))
in (FStar_List.append _140_476 _140_475)))))))))))))))))))))))
end))


let name_binders_inner : (Prims.string * sort) Prims.list  ->  Prims.int  ->  sort Prims.list  ->  ((Prims.string * sort) Prims.list * Prims.string Prims.list * Prims.int) = (fun outer_names start sorts -> (

let _47_592 = (FStar_All.pipe_right sorts (FStar_List.fold_left (fun _47_579 s -> (match (_47_579) with
| (names, binders, n) -> begin
(

let prefix = (match (s) with
| Type_sort -> begin
"@a"
end
| Term_sort -> begin
"@x"
end
| _47_584 -> begin
"@u"
end)
in (

let nm = (let _140_485 = (FStar_Util.string_of_int n)
in (Prims.strcat prefix _140_485))
in (

let names = (((nm), (s)))::names
in (

let b = (let _140_486 = (strSort s)
in (FStar_Util.format2 "(%s %s)" nm _140_486))
in ((names), ((b)::binders), ((n + (Prims.parse_int "1"))))))))
end)) ((outer_names), ([]), (start))))
in (match (_47_592) with
| (names, binders, n) -> begin
((names), ((FStar_List.rev binders)), (n))
end)))


let name_binders : sort Prims.list  ->  ((Prims.string * sort) Prims.list * Prims.string Prims.list) = (fun sorts -> (

let _47_597 = (name_binders_inner [] (Prims.parse_int "0") sorts)
in (match (_47_597) with
| (names, binders, n) -> begin
(((FStar_List.rev names)), (binders))
end)))


let termToSmt : term  ->  Prims.string = (fun t -> (

let rec aux = (fun n names t -> (match (t.tm) with
| Integer (i) -> begin
i
end
| BoundV (i) -> begin
(let _140_497 = (FStar_List.nth names i)
in (FStar_All.pipe_right _140_497 Prims.fst))
end
| FreeV (x) -> begin
(Prims.fst x)
end
| App (op, []) -> begin
(op_to_string op)
end
| App (op, tms) -> begin
(let _140_499 = (let _140_498 = (FStar_List.map (aux n names) tms)
in (FStar_All.pipe_right _140_498 (FStar_String.concat "\n")))
in (FStar_Util.format2 "(%s %s)" (op_to_string op) _140_499))
end
| Quant (qop, pats, wopt, sorts, body) -> begin
(

let _47_627 = (name_binders_inner names n sorts)
in (match (_47_627) with
| (names, binders, n) -> begin
(

let binders = (FStar_All.pipe_right binders (FStar_String.concat " "))
in (

let pats_str = (match (pats) with
| (([])::[]) | ([]) -> begin
""
end
| _47_633 -> begin
(let _140_505 = (FStar_All.pipe_right pats (FStar_List.map (fun pats -> (let _140_504 = (let _140_503 = (FStar_List.map (fun p -> (let _140_502 = (aux n names p)
in (FStar_Util.format1 "%s" _140_502))) pats)
in (FStar_String.concat " " _140_503))
in (FStar_Util.format1 "\n:pattern (%s)" _140_504)))))
in (FStar_All.pipe_right _140_505 (FStar_String.concat "\n")))
end)
in (match (((pats), (wopt))) with
| ((([])::[], None)) | (([], None)) -> begin
(let _140_506 = (aux n names body)
in (FStar_Util.format3 "(%s (%s)\n %s);;no pats\n" (qop_to_string qop) binders _140_506))
end
| _47_645 -> begin
(let _140_508 = (aux n names body)
in (let _140_507 = (weightToSmt wopt)
in (FStar_Util.format5 "(%s (%s)\n (! %s\n %s %s))" (qop_to_string qop) binders _140_508 _140_507 pats_str)))
end)))
end))
end))
in (aux (Prims.parse_int "0") [] t)))


let caption_to_string : Prims.string Prims.option  ->  Prims.string = (fun _47_6 -> (match (_47_6) with
| None -> begin
""
end
| Some (c) -> begin
(

let _47_652 = (FStar_Util.splitlines c)
in (match (_47_652) with
| (hd)::tl -> begin
(

let suffix = (match (tl) with
| [] -> begin
""
end
| _47_655 -> begin
"..."
end)
in (FStar_Util.format2 ";;;;;;;;;;;;;;;;%s%s\n" hd suffix))
end))
end))


let rec declToSmt : Prims.string  ->  decl  ->  Prims.string = (fun z3options decl -> (match (decl) with
| DefPrelude -> begin
(mkPrelude z3options)
end
| Caption (c) -> begin
(let _140_517 = (FStar_All.pipe_right (FStar_Util.splitlines c) (fun _47_7 -> (match (_47_7) with
| [] -> begin
""
end
| (h)::t -> begin
h
end)))
in (FStar_Util.format1 "\n; %s" _140_517))
end
| DeclFun (f, argsorts, retsort, c) -> begin
(

let l = (FStar_List.map strSort argsorts)
in (let _140_519 = (caption_to_string c)
in (let _140_518 = (strSort retsort)
in (FStar_Util.format4 "%s(declare-fun %s (%s) %s)" _140_519 f (FStar_String.concat " " l) _140_518))))
end
| DefineFun (f, arg_sorts, retsort, body, c) -> begin
(

let _47_683 = (name_binders arg_sorts)
in (match (_47_683) with
| (names, binders) -> begin
(

let body = (let _140_520 = (FStar_List.map mkFreeV names)
in (inst _140_520 body))
in (let _140_523 = (caption_to_string c)
in (let _140_522 = (strSort retsort)
in (let _140_521 = (termToSmt body)
in (FStar_Util.format5 "%s(define-fun %s (%s) %s\n %s)" _140_523 f (FStar_String.concat " " binders) _140_522 _140_521)))))
end))
end
| Assume (t, c) -> begin
(let _140_525 = (caption_to_string c)
in (let _140_524 = (termToSmt t)
in (FStar_Util.format2 "%s(assert %s)" _140_525 _140_524)))
end
| Eval (t) -> begin
(let _140_526 = (termToSmt t)
in (FStar_Util.format1 "(eval %s)" _140_526))
end
| Echo (s) -> begin
(FStar_Util.format1 "(echo \"%s\")" s)
end
| CheckSat -> begin
"(check-sat)"
end
| Push -> begin
"(push)"
end
| Pop -> begin
"(pop)"
end))
and mkPrelude : Prims.string  ->  Prims.string = (fun z3options -> (

let basic = (Prims.strcat z3options "(declare-sort Ref)\n(declare-fun Ref_constr_id (Ref) Int)\n\n(declare-sort String)\n(declare-fun String_constr_id (String) Int)\n\n(declare-sort Kind)\n(declare-fun Kind_constr_id (Kind) Int)\n\n(declare-sort Type)\n(declare-fun Type_constr_id (Type) Int)\n\n(declare-sort Term)\n(declare-fun Term_constr_id (Term) Int)\n(declare-datatypes () ((Fuel \n(ZFuel) \n(SFuel (prec Fuel)))))\n(declare-fun MaxIFuel () Fuel)\n(declare-fun MaxFuel () Fuel)\n(declare-fun PreKind (Type) Kind)\n(declare-fun PreType (Term) Type)\n(declare-fun Valid (Type) Bool)\n(declare-fun HasKind (Type Kind) Bool)\n(declare-fun HasTypeFuel (Fuel Term Type) Bool)\n(define-fun HasTypeZ ((x Term) (t Type)) Bool\n(HasTypeFuel ZFuel x t))\n(define-fun HasType ((x Term) (t Type)) Bool\n(HasTypeFuel MaxIFuel x t))\n;;fuel irrelevance\n(assert (forall ((f Fuel) (x Term) (t Type))\n(! (= (HasTypeFuel (SFuel f) x t)\n(HasTypeZ x t))\n:pattern ((HasTypeFuel (SFuel f) x t)))))\n(define-fun  IsTyped ((x Term)) Bool\n(exists ((t Type)) (HasTypeZ x t)))\n(declare-fun ApplyEF (Term Fuel) Term)\n(declare-fun ApplyEE (Term Term) Term)\n(declare-fun ApplyET (Term Type) Term)\n(declare-fun ApplyTE (Type Term) Type)\n(declare-fun ApplyTT (Type Type) Type)\n(declare-fun Rank (Term) Int)\n(declare-fun Closure (Term) Term)\n(declare-fun ConsTerm (Term Term) Term)\n(declare-fun ConsType (Type Term) Term)\n(declare-fun ConsFuel (Fuel Term) Term)\n(declare-fun Precedes (Term Term) Type)\n(assert (forall ((t Type))\n(! (implies (exists ((e Term)) (HasType e t))\n(Valid t))\n:pattern ((Valid t)))))\n(assert (forall ((t1 Term) (t2 Term))\n(! (iff (Valid (Precedes t1 t2)) \n(< (Rank t1) (Rank t2)))\n:pattern ((Precedes t1 t2)))))\n(define-fun Prims.Precedes ((a Type) (b Type) (t1 Term) (t2 Term)) Type\n(Precedes t1 t2))\n")
in (

let constrs = ((("String_const"), (((("String_const_proj_0"), (Int_sort)))::[]), (String_sort), ((Prims.parse_int "0"))))::((("Kind_type"), ([]), (Kind_sort), ((Prims.parse_int "0"))))::((("Kind_arrow"), (((("Kind_arrow_id"), (Int_sort)))::[]), (Kind_sort), ((Prims.parse_int "1"))))::((("Kind_uvar"), (((("Kind_uvar_fst"), (Int_sort)))::[]), (Kind_sort), ((Prims.parse_int "2"))))::((("Typ_fun"), (((("Typ_fun_id"), (Int_sort)))::[]), (Type_sort), ((Prims.parse_int "1"))))::((("Typ_app"), (((("Typ_app_fst"), (Type_sort)))::((("Typ_app_snd"), (Type_sort)))::[]), (Type_sort), ((Prims.parse_int "2"))))::((("Typ_dep"), (((("Typ_dep_fst"), (Type_sort)))::((("Typ_dep_snd"), (Term_sort)))::[]), (Type_sort), ((Prims.parse_int "3"))))::((("Typ_uvar"), (((("Typ_uvar_fst"), (Int_sort)))::[]), (Type_sort), ((Prims.parse_int "4"))))::((("Term_unit"), ([]), (Term_sort), ((Prims.parse_int "0"))))::((("BoxInt"), (((("BoxInt_proj_0"), (Int_sort)))::[]), (Term_sort), ((Prims.parse_int "1"))))::((("BoxBool"), (((("BoxBool_proj_0"), (Bool_sort)))::[]), (Term_sort), ((Prims.parse_int "2"))))::((("BoxString"), (((("BoxString_proj_0"), (String_sort)))::[]), (Term_sort), ((Prims.parse_int "3"))))::((("BoxRef"), (((("BoxRef_proj_0"), (Ref_sort)))::[]), (Term_sort), ((Prims.parse_int "4"))))::((("Exp_uvar"), (((("Exp_uvar_fst"), (Int_sort)))::[]), (Term_sort), ((Prims.parse_int "5"))))::((("LexCons"), (((("LexCons_0"), (Term_sort)))::((("LexCons_1"), (Term_sort)))::[]), (Term_sort), ((Prims.parse_int "6"))))::[]
in (

let bcons = (let _140_529 = (let _140_528 = (FStar_All.pipe_right constrs (FStar_List.collect constructor_to_decl))
in (FStar_All.pipe_right _140_528 (FStar_List.map (declToSmt z3options))))
in (FStar_All.pipe_right _140_529 (FStar_String.concat "\n")))
in (

let lex_ordering = "\n(define-fun is-Prims.LexCons ((t Term)) Bool \n(is-LexCons t))\n(assert (forall ((x1 Term) (x2 Term) (y1 Term) (y2 Term))\n(iff (Valid (Precedes (LexCons x1 x2) (LexCons y1 y2)))\n(or (Valid (Precedes x1 y1))\n(and (= x1 y1)\n(Valid (Precedes x2 y2)))))))\n"
in (Prims.strcat basic (Prims.strcat bcons lex_ordering)))))))


let mk_Kind_type : term = (mkApp (("Kind_type"), ([])))


let mk_Kind_uvar : Prims.int  ->  term = (fun i -> (let _140_534 = (let _140_533 = (let _140_532 = (mkInteger' i)
in (_140_532)::[])
in (("Kind_uvar"), (_140_533)))
in (mkApp _140_534)))


let mk_Typ_app : term  ->  term  ->  term = (fun t1 t2 -> (mkApp (("Typ_app"), ((t1)::(t2)::[]))))


let mk_Typ_dep : term  ->  term  ->  term = (fun t1 t2 -> (mkApp (("Typ_dep"), ((t1)::(t2)::[]))))


let mk_Typ_uvar : Prims.int  ->  term = (fun i -> (let _140_547 = (let _140_546 = (let _140_545 = (mkInteger' i)
in (_140_545)::[])
in (("Typ_uvar"), (_140_546)))
in (mkApp _140_547)))


let mk_Exp_uvar : Prims.int  ->  term = (fun i -> (let _140_552 = (let _140_551 = (let _140_550 = (mkInteger' i)
in (_140_550)::[])
in (("Exp_uvar"), (_140_551)))
in (mkApp _140_552)))


let mk_Term_unit : term = (mkApp (("Term_unit"), ([])))


let boxInt : term  ->  term = (fun t -> (mkApp (("BoxInt"), ((t)::[]))))


let unboxInt : term  ->  term = (fun t -> (mkApp (("BoxInt_proj_0"), ((t)::[]))))


let boxBool : term  ->  term = (fun t -> (mkApp (("BoxBool"), ((t)::[]))))


let unboxBool : term  ->  term = (fun t -> (mkApp (("BoxBool_proj_0"), ((t)::[]))))


let boxString : term  ->  term = (fun t -> (mkApp (("BoxString"), ((t)::[]))))


let unboxString : term  ->  term = (fun t -> (mkApp (("BoxString_proj_0"), ((t)::[]))))


let boxRef : term  ->  term = (fun t -> (mkApp (("BoxRef"), ((t)::[]))))


let unboxRef : term  ->  term = (fun t -> (mkApp (("BoxRef_proj_0"), ((t)::[]))))


let boxTerm : sort  ->  term  ->  term = (fun sort t -> (match (sort) with
| Int_sort -> begin
(boxInt t)
end
| Bool_sort -> begin
(boxBool t)
end
| String_sort -> begin
(boxString t)
end
| Ref_sort -> begin
(boxRef t)
end
| _47_723 -> begin
(Prims.raise FStar_Util.Impos)
end))


let unboxTerm : sort  ->  term  ->  term = (fun sort t -> (match (sort) with
| Int_sort -> begin
(unboxInt t)
end
| Bool_sort -> begin
(unboxBool t)
end
| String_sort -> begin
(unboxString t)
end
| Ref_sort -> begin
(unboxRef t)
end
| _47_731 -> begin
(Prims.raise FStar_Util.Impos)
end))


let mk_PreKind : term  ->  term = (fun t -> (mkApp (("PreKind"), ((t)::[]))))


let mk_PreType : term  ->  term = (fun t -> (mkApp (("PreType"), ((t)::[]))))


let mk_Valid : term  ->  term = (fun t -> (match (t.tm) with
| App (Var ("Prims.b2t"), ({tm = App (Var ("Prims.op_Equality"), (_47_746)::(t1)::(t2)::[]); hash = _47_740; freevars = _47_738})::[]) -> begin
(mkEq ((t1), (t2)))
end
| App (Var ("Prims.b2t"), ({tm = App (Var ("Prims.op_disEquality"), (_47_765)::(t1)::(t2)::[]); hash = _47_759; freevars = _47_757})::[]) -> begin
(let _140_583 = (mkEq ((t1), (t2)))
in (mkNot _140_583))
end
| App (Var ("Prims.b2t"), ({tm = App (Var ("Prims.op_LessThanOrEqual"), (t1)::(t2)::[]); hash = _47_778; freevars = _47_776})::[]) -> begin
(let _140_586 = (let _140_585 = (unboxInt t1)
in (let _140_584 = (unboxInt t2)
in ((_140_585), (_140_584))))
in (mkLTE _140_586))
end
| App (Var ("Prims.b2t"), ({tm = App (Var ("Prims.op_LessThan"), (t1)::(t2)::[]); hash = _47_795; freevars = _47_793})::[]) -> begin
(let _140_589 = (let _140_588 = (unboxInt t1)
in (let _140_587 = (unboxInt t2)
in ((_140_588), (_140_587))))
in (mkLT _140_589))
end
| App (Var ("Prims.b2t"), ({tm = App (Var ("Prims.op_GreaterThanOrEqual"), (t1)::(t2)::[]); hash = _47_812; freevars = _47_810})::[]) -> begin
(let _140_592 = (let _140_591 = (unboxInt t1)
in (let _140_590 = (unboxInt t2)
in ((_140_591), (_140_590))))
in (mkGTE _140_592))
end
| App (Var ("Prims.b2t"), ({tm = App (Var ("Prims.op_GreaterThan"), (t1)::(t2)::[]); hash = _47_829; freevars = _47_827})::[]) -> begin
(let _140_595 = (let _140_594 = (unboxInt t1)
in (let _140_593 = (unboxInt t2)
in ((_140_594), (_140_593))))
in (mkGT _140_595))
end
| App (Var ("Prims.b2t"), ({tm = App (Var ("Prims.op_AmpAmp"), (t1)::(t2)::[]); hash = _47_846; freevars = _47_844})::[]) -> begin
(let _140_598 = (let _140_597 = (unboxBool t1)
in (let _140_596 = (unboxBool t2)
in ((_140_597), (_140_596))))
in (mkAnd _140_598))
end
| App (Var ("Prims.b2t"), ({tm = App (Var ("Prims.op_BarBar"), (t1)::(t2)::[]); hash = _47_863; freevars = _47_861})::[]) -> begin
(let _140_601 = (let _140_600 = (unboxBool t1)
in (let _140_599 = (unboxBool t2)
in ((_140_600), (_140_599))))
in (mkOr _140_601))
end
| App (Var ("Prims.b2t"), ({tm = App (Var ("Prims.op_Negation"), (t)::[]); hash = _47_880; freevars = _47_878})::[]) -> begin
(let _140_602 = (unboxBool t)
in (mkNot _140_602))
end
| App (Var ("Prims.b2t"), (t)::[]) -> begin
(unboxBool t)
end
| _47_898 -> begin
(mkApp (("Valid"), ((t)::[])))
end))


let mk_HasType : term  ->  term  ->  term = (fun v t -> (mkApp (("HasType"), ((v)::(t)::[]))))


let mk_HasTypeZ : term  ->  term  ->  term = (fun v t -> (mkApp (("HasTypeZ"), ((v)::(t)::[]))))


let mk_IsTyped : term  ->  term = (fun v -> (mkApp (("IsTyped"), ((v)::[]))))


let mk_HasTypeFuel : term  ->  term  ->  term  ->  term = (fun f v t -> if (FStar_Options.unthrottle_inductives ()) then begin
(mk_HasType v t)
end else begin
(mkApp (("HasTypeFuel"), ((f)::(v)::(t)::[])))
end)


let mk_HasTypeWithFuel : term Prims.option  ->  term  ->  term  ->  term = (fun f v t -> (match (f) with
| None -> begin
(mk_HasType v t)
end
| Some (f) -> begin
(mk_HasTypeFuel f v t)
end))


let mk_Destruct : term  ->  term = (fun v -> (mkApp (("Destruct"), ((v)::[]))))


let mk_HasKind : term  ->  term  ->  term = (fun t k -> (mkApp (("HasKind"), ((t)::(k)::[]))))


let mk_Rank : term  ->  term = (fun x -> (mkApp (("Rank"), ((x)::[]))))


let mk_tester : Prims.string  ->  term  ->  term = (fun n t -> (mkApp (((Prims.strcat "is-" n)), ((t)::[]))))


let mk_ApplyTE : term  ->  term  ->  term = (fun t e -> (mkApp (("ApplyTE"), ((t)::(e)::[]))))


let mk_ApplyTT : term  ->  term  ->  term = (fun t t' -> (mkApp (("ApplyTT"), ((t)::(t')::[]))))


let mk_ApplyET : term  ->  term  ->  term = (fun e t -> (mkApp (("ApplyET"), ((e)::(t)::[]))))


let mk_ApplyEE : term  ->  term  ->  term = (fun e e' -> (mkApp (("ApplyEE"), ((e)::(e')::[]))))


let mk_ApplyEF : term  ->  term  ->  term = (fun e f -> (mkApp (("ApplyEF"), ((e)::(f)::[]))))


let mk_String_const : Prims.int  ->  term = (fun i -> (let _140_661 = (let _140_660 = (let _140_659 = (mkInteger' i)
in (_140_659)::[])
in (("String_const"), (_140_660)))
in (mkApp _140_661)))


let mk_Precedes : term  ->  term  ->  term = (fun x1 x2 -> (let _140_666 = (mkApp (("Precedes"), ((x1)::(x2)::[])))
in (FStar_All.pipe_right _140_666 mk_Valid)))


let mk_LexCons : term  ->  term  ->  term = (fun x1 x2 -> (mkApp (("LexCons"), ((x1)::(x2)::[]))))


let rec n_fuel : Prims.int  ->  term = (fun n -> if (n = (Prims.parse_int "0")) then begin
(mkApp (("ZFuel"), ([])))
end else begin
(let _140_675 = (let _140_674 = (let _140_673 = (n_fuel (n - (Prims.parse_int "1")))
in (_140_673)::[])
in (("SFuel"), (_140_674)))
in (mkApp _140_675))
end)


let fuel_2 : term = (n_fuel (Prims.parse_int "2"))


let fuel_100 : term = (n_fuel (Prims.parse_int "100"))


let mk_and_opt : term Prims.option  ->  term Prims.option  ->  term Prims.option = (fun p1 p2 -> (match (((p1), (p2))) with
| (Some (p1), Some (p2)) -> begin
(let _140_680 = (mkAnd ((p1), (p2)))
in Some (_140_680))
end
| ((Some (p), None)) | ((None, Some (p))) -> begin
Some (p)
end
| (None, None) -> begin
None
end))


let mk_and_opt_l : term Prims.option Prims.list  ->  term Prims.option = (fun pl -> (FStar_List.fold_left (fun out p -> (mk_and_opt p out)) None pl))


let mk_and_l : term Prims.list  ->  term = (fun l -> (match (l) with
| [] -> begin
mkTrue
end
| (hd)::tl -> begin
(FStar_List.fold_left (fun p1 p2 -> (mkAnd ((p1), (p2)))) hd tl)
end))


let mk_or_l : term Prims.list  ->  term = (fun l -> (match (l) with
| [] -> begin
mkFalse
end
| (hd)::tl -> begin
(FStar_List.fold_left (fun p1 p2 -> (mkOr ((p1), (p2)))) hd tl)
end))


let rec print_smt_term : term  ->  Prims.string = (fun t -> (match (t.tm) with
| Integer (n) -> begin
(FStar_Util.format1 "Integer %s" n)
end
| BoundV (n) -> begin
(let _140_697 = (FStar_Util.string_of_int n)
in (FStar_Util.format1 "BoundV %s" _140_697))
end
| FreeV (fv) -> begin
(FStar_Util.format1 "FreeV %s" (Prims.fst fv))
end
| App (op, l) -> begin
(let _140_698 = (print_smt_term_list l)
in (FStar_Util.format2 "App %s [ %s ]" (op_to_string op) _140_698))
end
| Quant (qop, l, _47_983, _47_985, t) -> begin
(let _140_700 = (print_smt_term_list_list l)
in (let _140_699 = (print_smt_term t)
in (FStar_Util.format3 "Quant %s %s %s" (qop_to_string qop) _140_700 _140_699)))
end))
and print_smt_term_list : term Prims.list  ->  Prims.string = (fun l -> (FStar_List.fold_left (fun s t -> (let _140_705 = (let _140_704 = (print_smt_term t)
in (Prims.strcat "; " _140_704))
in (Prims.strcat s _140_705))) "" l))
and print_smt_term_list_list : term Prims.list Prims.list  ->  Prims.string = (fun l -> (FStar_List.fold_left (fun s l -> (let _140_711 = (let _140_710 = (let _140_709 = (print_smt_term_list l)
in (Prims.strcat _140_709 " ] "))
in (Prims.strcat "; [ " _140_710))
in (Prims.strcat s _140_711))) "" l))




