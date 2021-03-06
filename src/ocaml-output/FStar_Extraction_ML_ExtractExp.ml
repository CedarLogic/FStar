
open Prims

let type_leq : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlty  ->  Prims.bool = (fun g t1 t2 -> (FStar_Extraction_ML_Util.type_leq (FStar_Extraction_ML_Util.delta_unfold g) t1 t2))


let type_leq_c : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.mlexpr Prims.option  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlty  ->  (Prims.bool * FStar_Extraction_ML_Syntax.mlexpr Prims.option) = (fun g t1 t2 -> (FStar_Extraction_ML_Util.type_leq_c (FStar_Extraction_ML_Util.delta_unfold g) t1 t2))


let erasableType : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.mlty  ->  Prims.bool = (fun g t -> (FStar_Extraction_ML_Util.erasableType (FStar_Extraction_ML_Util.delta_unfold g) t))


let eraseTypeDeep : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlty = (fun g t -> (FStar_Extraction_ML_Util.eraseTypeDeep (FStar_Extraction_ML_Util.delta_unfold g) t))


let fail = (fun r msg -> (

let _76_19 = (let _169_27 = (FStar_Absyn_Print.format_error r msg)
in (FStar_All.pipe_left FStar_Util.print_string _169_27))
in (FStar_All.failwith msg)))


let err_uninst = (fun env e _76_25 -> (match (_76_25) with
| (vars, t) -> begin
(let _169_35 = (let _169_34 = (FStar_Absyn_Print.exp_to_string e)
in (let _169_33 = (let _169_31 = (FStar_All.pipe_right vars (FStar_List.map Prims.fst))
in (FStar_All.pipe_right _169_31 (FStar_String.concat ", ")))
in (let _169_32 = (FStar_Extraction_ML_Code.string_of_mlty env.FStar_Extraction_ML_Env.currentModule t)
in (FStar_Util.format3 "Variable %s has a polymorphic type (forall %s. %s); expected it to be fully instantiated" _169_34 _169_33 _169_32))))
in (fail e.FStar_Absyn_Syntax.pos _169_35))
end))


let err_ill_typed_application = (fun e args t -> (let _169_41 = (let _169_40 = (FStar_Absyn_Print.exp_to_string e)
in (let _169_39 = (FStar_Absyn_Print.args_to_string args)
in (FStar_Util.format2 "Ill-typed application: application is %s \n remaining args are %s\n" _169_40 _169_39)))
in (fail e.FStar_Absyn_Syntax.pos _169_41)))


let err_value_restriction = (fun e -> (fail e.FStar_Absyn_Syntax.pos "Refusing to generalize because of the value restriction"))


let err_unexpected_eff = (fun e f0 f1 -> (let _169_47 = (let _169_46 = (FStar_Absyn_Print.exp_to_string e)
in (FStar_Util.format3 "for expression %s, Expected effect %s; got effect %s" _169_46 (FStar_Extraction_ML_Util.eff_to_string f0) (FStar_Extraction_ML_Util.eff_to_string f1)))
in (fail e.FStar_Absyn_Syntax.pos _169_47)))


let is_constructor : (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  Prims.bool = (fun e -> (match ((let _169_50 = (FStar_Absyn_Util.compress_exp e)
in _169_50.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Exp_fvar (_, Some (FStar_Absyn_Syntax.Data_ctor))) | (FStar_Absyn_Syntax.Exp_fvar (_, Some (FStar_Absyn_Syntax.Record_ctor (_)))) -> begin
true
end
| _76_49 -> begin
false
end))


let rec is_value_or_type_app : FStar_Absyn_Syntax.exp  ->  Prims.bool = (fun e -> (match ((let _169_53 = (FStar_Absyn_Util.compress_exp e)
in _169_53.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Exp_constant (_)) | (FStar_Absyn_Syntax.Exp_bvar (_)) | (FStar_Absyn_Syntax.Exp_fvar (_)) | (FStar_Absyn_Syntax.Exp_abs (_)) -> begin
true
end
| FStar_Absyn_Syntax.Exp_app (head, args) -> begin
if (is_constructor head) then begin
(FStar_All.pipe_right args (FStar_List.for_all (fun _76_70 -> (match (_76_70) with
| (te, _76_69) -> begin
(match (te) with
| FStar_Util.Inl (_76_72) -> begin
true
end
| FStar_Util.Inr (e) -> begin
(is_value_or_type_app e)
end)
end))))
end else begin
(match ((let _169_55 = (FStar_Absyn_Util.compress_exp head)
in _169_55.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Exp_bvar (_)) | (FStar_Absyn_Syntax.Exp_fvar (_)) -> begin
(FStar_All.pipe_right args (FStar_List.for_all (fun _76_1 -> (match (_76_1) with
| (FStar_Util.Inl (te), _76_86) -> begin
true
end
| _76_89 -> begin
false
end))))
end
| _76_91 -> begin
false
end)
end
end
| (FStar_Absyn_Syntax.Exp_meta (FStar_Absyn_Syntax.Meta_desugared (e, _))) | (FStar_Absyn_Syntax.Exp_ascribed (e, _, _)) -> begin
(is_value_or_type_app e)
end
| _76_105 -> begin
false
end))


let rec is_ml_value : FStar_Extraction_ML_Syntax.mlexpr  ->  Prims.bool = (fun e -> (match (e.FStar_Extraction_ML_Syntax.expr) with
| (FStar_Extraction_ML_Syntax.MLE_Const (_)) | (FStar_Extraction_ML_Syntax.MLE_Var (_)) | (FStar_Extraction_ML_Syntax.MLE_Name (_)) | (FStar_Extraction_ML_Syntax.MLE_Fun (_)) -> begin
true
end
| (FStar_Extraction_ML_Syntax.MLE_CTor (_, exps)) | (FStar_Extraction_ML_Syntax.MLE_Tuple (exps)) -> begin
(FStar_Util.for_all is_ml_value exps)
end
| FStar_Extraction_ML_Syntax.MLE_Record (_76_126, fields) -> begin
(FStar_Util.for_all (fun _76_133 -> (match (_76_133) with
| (_76_131, e) -> begin
(is_ml_value e)
end)) fields)
end
| _76_135 -> begin
false
end))


let translate_typ : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.typ  ->  FStar_Extraction_ML_Syntax.mlty = (fun g t -> (let _169_64 = (FStar_Extraction_ML_ExtractTyp.extractTyp g t)
in (eraseTypeDeep g _169_64)))


let translate_typ_of_arg : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.arg  ->  FStar_Extraction_ML_Syntax.mlty = (fun g a -> (let _169_69 = (FStar_Extraction_ML_ExtractTyp.getTypeFromArg g a)
in (eraseTypeDeep g _169_69)))


let instantiate : FStar_Extraction_ML_Syntax.mltyscheme  ->  FStar_Extraction_ML_Syntax.mlty Prims.list  ->  FStar_Extraction_ML_Syntax.mlty = (fun s args -> (FStar_Extraction_ML_Util.subst s args))


let erasable : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.e_tag  ->  FStar_Extraction_ML_Syntax.mlty  ->  Prims.bool = (fun g f t -> ((f = FStar_Extraction_ML_Syntax.E_GHOST) || ((f = FStar_Extraction_ML_Syntax.E_PURE) && (erasableType g t))))


let erase : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.mlexpr  ->  FStar_Extraction_ML_Syntax.e_tag  ->  FStar_Extraction_ML_Syntax.mlty  ->  (FStar_Extraction_ML_Syntax.mlexpr * FStar_Extraction_ML_Syntax.e_tag * FStar_Extraction_ML_Syntax.mlty) = (fun g e f t -> if (erasable g f t) then begin
(

let _76_150 = (FStar_Extraction_ML_Env.debug g (fun _76_149 -> (match (()) with
| () -> begin
(let _169_90 = (FStar_Extraction_ML_Code.string_of_mlexpr g.FStar_Extraction_ML_Env.currentModule e)
in (let _169_89 = (FStar_Extraction_ML_Code.string_of_mlty g.FStar_Extraction_ML_Env.currentModule t)
in (FStar_Util.print2 "Erasing %s at type %s\n" _169_90 _169_89)))
end)))
in (

let e_val = if (type_leq g t FStar_Extraction_ML_Syntax.ml_unit_ty) then begin
FStar_Extraction_ML_Syntax.ml_unit
end else begin
(FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty t) (FStar_Extraction_ML_Syntax.MLE_Coerce (((FStar_Extraction_ML_Syntax.ml_unit), (FStar_Extraction_ML_Syntax.ml_unit_ty), (t)))))
end
in ((e_val), (f), (t))))
end else begin
((e), (f), (t))
end)


let maybe_coerce : FStar_Extraction_ML_Env.env  ->  FStar_Extraction_ML_Syntax.mlexpr  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlexpr = (fun g e tInferred tExpected -> (match ((type_leq_c g (Some (e)) tInferred tExpected)) with
| (true, Some (e')) -> begin
e'
end
| _76_162 -> begin
(FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty tExpected) (FStar_Extraction_ML_Syntax.MLE_Coerce (((e), (tInferred), (tExpected)))))
end))


let extract_pat : FStar_Extraction_ML_Env.env  ->  (FStar_Absyn_Syntax.pat', ((FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax, (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Util.either Prims.option) FStar_Absyn_Syntax.withinfo_t  ->  (FStar_Extraction_ML_Env.env * (FStar_Extraction_ML_Syntax.mlpattern * FStar_Extraction_ML_Syntax.mlexpr Prims.option) Prims.list) = (fun g p -> (

let rec extract_one_pat = (fun disj imp g p -> (match (p.FStar_Absyn_Syntax.v) with
| FStar_Absyn_Syntax.Pat_disj (_76_171) -> begin
(FStar_All.failwith "Impossible")
end
| FStar_Absyn_Syntax.Pat_constant (FStar_Const.Const_int (c, None)) -> begin
(

let i = FStar_Const.Const_int (((c), (None)))
in (

let x = (let _169_111 = (FStar_Absyn_Util.new_bvd None)
in (FStar_Extraction_ML_Syntax.as_mlident _169_111))
in (

let when_clause = (let _169_120 = (let _169_119 = (let _169_118 = (let _169_117 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_int_ty) (FStar_Extraction_ML_Syntax.MLE_Var (x)))
in (let _169_116 = (let _169_115 = (let _169_114 = (let _169_113 = (FStar_Extraction_ML_Util.mlconst_of_const' p.FStar_Absyn_Syntax.p i)
in (FStar_All.pipe_left (fun _169_112 -> FStar_Extraction_ML_Syntax.MLE_Const (_169_112)) _169_113))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_int_ty) _169_114))
in (_169_115)::[])
in (_169_117)::_169_116))
in ((FStar_Extraction_ML_Util.prims_op_equality), (_169_118)))
in FStar_Extraction_ML_Syntax.MLE_App (_169_119))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_bool_ty) _169_120))
in ((g), (Some (((FStar_Extraction_ML_Syntax.MLP_Var (x)), ((when_clause)::[]))))))))
end
| FStar_Absyn_Syntax.Pat_constant (s) -> begin
(let _169_124 = (let _169_123 = (let _169_122 = (let _169_121 = (FStar_Extraction_ML_Util.mlconst_of_const' p.FStar_Absyn_Syntax.p s)
in FStar_Extraction_ML_Syntax.MLP_Const (_169_121))
in ((_169_122), ([])))
in Some (_169_123))
in ((g), (_169_124)))
end
| FStar_Absyn_Syntax.Pat_cons (f, q, pats) -> begin
(

let _76_203 = (match ((FStar_Extraction_ML_Env.lookup_fv g f)) with
| ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (n); FStar_Extraction_ML_Syntax.mlty = _76_191; FStar_Extraction_ML_Syntax.loc = _76_189}, ttys, _76_197) -> begin
((n), (ttys))
end
| _76_200 -> begin
(FStar_All.failwith "Expected a constructor")
end)
in (match (_76_203) with
| (d, tys) -> begin
(

let nTyVars = (FStar_List.length (Prims.fst tys))
in (

let _76_207 = (FStar_Util.first_N nTyVars pats)
in (match (_76_207) with
| (tysVarPats, restPats) -> begin
(

let _76_214 = (FStar_Util.fold_map (fun g _76_211 -> (match (_76_211) with
| (p, imp) -> begin
(extract_one_pat disj true g p)
end)) g tysVarPats)
in (match (_76_214) with
| (g, tyMLPats) -> begin
(

let _76_228 = (FStar_Util.fold_map (fun g _76_218 -> (match (_76_218) with
| (p, imp) -> begin
(

let _76_221 = (extract_one_pat disj false g p)
in (match (_76_221) with
| (env, popt) -> begin
(

let popt = (match (popt) with
| None -> begin
Some (((FStar_Extraction_ML_Syntax.MLP_Wild), ([])))
end
| _76_224 -> begin
popt
end)
in ((env), (popt)))
end))
end)) g restPats)
in (match (_76_228) with
| (g, restMLPats) -> begin
(

let _76_236 = (let _169_130 = (FStar_All.pipe_right (FStar_List.append tyMLPats restMLPats) (FStar_List.collect (fun _76_2 -> (match (_76_2) with
| Some (x) -> begin
(x)::[]
end
| _76_233 -> begin
[]
end))))
in (FStar_All.pipe_right _169_130 FStar_List.split))
in (match (_76_236) with
| (mlPats, when_clauses) -> begin
(let _169_134 = (let _169_133 = (let _169_132 = (FStar_All.pipe_left (FStar_Extraction_ML_Util.resugar_pat q) (FStar_Extraction_ML_Syntax.MLP_CTor (((d), (mlPats)))))
in (let _169_131 = (FStar_All.pipe_right when_clauses FStar_List.flatten)
in ((_169_132), (_169_131))))
in Some (_169_133))
in ((g), (_169_134)))
end))
end))
end))
end)))
end))
end
| FStar_Absyn_Syntax.Pat_var (x) -> begin
(

let mlty = (translate_typ g x.FStar_Absyn_Syntax.sort)
in (

let g = (FStar_Extraction_ML_Env.extend_bv g x (([]), (mlty)) false false imp)
in ((g), (if imp then begin
None
end else begin
Some (((FStar_Extraction_ML_Syntax.MLP_Var ((FStar_Extraction_ML_Syntax.as_mlident x.FStar_Absyn_Syntax.v))), ([])))
end))))
end
| FStar_Absyn_Syntax.Pat_wild (x) when disj -> begin
((g), (Some (((FStar_Extraction_ML_Syntax.MLP_Wild), ([])))))
end
| FStar_Absyn_Syntax.Pat_wild (x) -> begin
(

let mlty = (translate_typ g x.FStar_Absyn_Syntax.sort)
in (

let g = (FStar_Extraction_ML_Env.extend_bv g x (([]), (mlty)) false false imp)
in ((g), (if imp then begin
None
end else begin
Some (((FStar_Extraction_ML_Syntax.MLP_Var ((FStar_Extraction_ML_Syntax.as_mlident x.FStar_Absyn_Syntax.v))), ([])))
end))))
end
| FStar_Absyn_Syntax.Pat_tvar (a) -> begin
(

let mlty = FStar_Extraction_ML_Syntax.MLTY_Top
in (

let g = (FStar_Extraction_ML_Env.extend_ty g a (Some (mlty)))
in ((g), (if imp then begin
None
end else begin
Some (((FStar_Extraction_ML_Syntax.MLP_Wild), ([])))
end))))
end
| (FStar_Absyn_Syntax.Pat_dot_term (_)) | (FStar_Absyn_Syntax.Pat_dot_typ (_)) | (FStar_Absyn_Syntax.Pat_twild (_)) -> begin
((g), (None))
end))
in (

let extract_one_pat = (fun disj g p -> (match ((extract_one_pat disj false g p)) with
| (g, Some (x, v)) -> begin
((g), (((x), (v))))
end
| _76_271 -> begin
(FStar_All.failwith "Impossible")
end))
in (

let mk_when_clause = (fun whens -> (match (whens) with
| [] -> begin
None
end
| (hd)::tl -> begin
(let _169_143 = (FStar_List.fold_left FStar_Extraction_ML_Util.conjoin hd tl)
in Some (_169_143))
end))
in (match (p.FStar_Absyn_Syntax.v) with
| FStar_Absyn_Syntax.Pat_disj ([]) -> begin
(FStar_All.failwith "Impossible")
end
| FStar_Absyn_Syntax.Pat_disj ((p)::pats) -> begin
(

let _76_286 = (extract_one_pat true g p)
in (match (_76_286) with
| (g, p) -> begin
(

let ps = (let _169_146 = (FStar_All.pipe_right pats (FStar_List.map (fun x -> (let _169_145 = (extract_one_pat true g x)
in (Prims.snd _169_145)))))
in (p)::_169_146)
in (

let _76_302 = (FStar_All.pipe_right ps (FStar_List.partition (fun _76_3 -> (match (_76_3) with
| (_76_291, (_76_295)::_76_293) -> begin
true
end
| _76_299 -> begin
false
end))))
in (match (_76_302) with
| (ps_when, rest) -> begin
(

let ps = (FStar_All.pipe_right ps_when (FStar_List.map (fun _76_305 -> (match (_76_305) with
| (x, whens) -> begin
(let _169_149 = (mk_when_clause whens)
in ((x), (_169_149)))
end))))
in (

let res = (match (rest) with
| [] -> begin
((g), (ps))
end
| rest -> begin
(let _169_153 = (let _169_152 = (let _169_151 = (let _169_150 = (FStar_List.map Prims.fst rest)
in FStar_Extraction_ML_Syntax.MLP_Branch (_169_150))
in ((_169_151), (None)))
in (_169_152)::ps)
in ((g), (_169_153)))
end)
in res))
end)))
end))
end
| _76_311 -> begin
(

let _76_316 = (extract_one_pat false g p)
in (match (_76_316) with
| (g, (p, whens)) -> begin
(

let when_clause = (mk_when_clause whens)
in ((g), ((((p), (when_clause)))::[])))
end))
end)))))


let normalize_abs : (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  FStar_Absyn_Syntax.exp = (fun e0 -> (

let rec aux = (fun bs e -> (

let e = (FStar_Absyn_Util.compress_exp e)
in (match (e.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_abs (bs', body) -> begin
(aux (FStar_List.append bs bs') body)
end
| _76_328 -> begin
(

let e' = (FStar_Absyn_Util.unascribe e)
in if (FStar_Absyn_Util.is_fun e') then begin
(aux bs e')
end else begin
(FStar_Absyn_Syntax.mk_Exp_abs ((bs), (e)) None e0.FStar_Absyn_Syntax.pos)
end)
end)))
in (aux [] e0)))


let ffi_mltuple_mlp : Prims.int  ->  (Prims.string Prims.list * Prims.string) = (fun n -> (

let name = if (((Prims.parse_int "2") < n) && (n < (Prims.parse_int "6"))) then begin
(let _169_162 = (FStar_Util.string_of_int n)
in (Prims.strcat "mktuple" _169_162))
end else begin
if (n = (Prims.parse_int "2")) then begin
"mkpair"
end else begin
(FStar_All.failwith "NYI in runtime/allocator/camlstack.mli")
end
end
in ((("Camlstack")::[]), (name))))


let fix_lalloc : FStar_Extraction_ML_Syntax.mlexpr  ->  FStar_Extraction_ML_Syntax.mlexpr = (fun arg -> (match (arg.FStar_Extraction_ML_Syntax.expr) with
| FStar_Extraction_ML_Syntax.MLE_Tuple (args) -> begin
(FStar_All.failwith "unexpected. Prims.TupleN is not specially handled yet. So, F* tuples, which are sugar forPrims.TupleN,  were expected to be extracted as MLE_CTor")
end
| FStar_Extraction_ML_Syntax.MLE_Record (mlns, fields) -> begin
(

let args = (FStar_List.map Prims.snd fields)
in (

let tup = (let _169_169 = (let _169_168 = (let _169_167 = (let _169_166 = (let _169_165 = (ffi_mltuple_mlp (FStar_List.length args))
in FStar_Extraction_ML_Syntax.MLE_Name (_169_165))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.MLTY_Top) _169_166))
in ((_169_167), (args)))
in FStar_Extraction_ML_Syntax.MLE_App (_169_168))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.MLTY_Top) _169_169))
in (

let dummyTy = FStar_Extraction_ML_Syntax.ml_unit_ty
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty dummyTy) (FStar_Extraction_ML_Syntax.MLE_Coerce (((tup), (dummyTy), (dummyTy))))))))
end
| FStar_Extraction_ML_Syntax.MLE_CTor (mlp, args) -> begin
(FStar_All.failwith "NYI: lalloc ctor")
end
| _76_347 -> begin
(FStar_All.failwith "for efficiency, the argument to lalloc should be a head normal form of the type. Extraction will then avoid creating this value on the heap.")
end))


let maybe_lalloc_eta_data : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.fv_qual Prims.option  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlexpr  ->  FStar_Extraction_ML_Syntax.mlexpr = (fun g qual residualType mlAppExpr -> (

let rec eta_args = (fun more_args t -> (match (t) with
| FStar_Extraction_ML_Syntax.MLTY_Fun (t0, _76_357, t1) -> begin
(

let x = (let _169_182 = (FStar_Absyn_Util.gensym ())
in ((_169_182), ((~- ((Prims.parse_int "1"))))))
in (let _169_185 = (let _169_184 = (let _169_183 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty t0) (FStar_Extraction_ML_Syntax.MLE_Var (x)))
in ((((x), (t0))), (_169_183)))
in (_169_184)::more_args)
in (eta_args _169_185 t1)))
end
| FStar_Extraction_ML_Syntax.MLTY_Named (_76_363, _76_365) -> begin
(((FStar_List.rev more_args)), (t))
end
| _76_369 -> begin
(FStar_All.failwith "Impossible")
end))
in (

let as_record = (fun qual e -> (match (((e.FStar_Extraction_ML_Syntax.expr), (qual))) with
| (FStar_Extraction_ML_Syntax.MLE_CTor (_76_374, args), Some (FStar_Absyn_Syntax.Record_ctor (_76_379, fields))) -> begin
(

let path = (FStar_Extraction_ML_Util.record_field_path fields)
in (

let fields = (FStar_Extraction_ML_Util.record_fields fields args)
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty e.FStar_Extraction_ML_Syntax.mlty) (FStar_Extraction_ML_Syntax.MLE_Record (((path), (fields)))))))
end
| _76_388 -> begin
e
end))
in (

let resugar_and_maybe_eta = (fun qual e -> (

let _76_394 = (eta_args [] residualType)
in (match (_76_394) with
| (eargs, tres) -> begin
(match (eargs) with
| [] -> begin
(let _169_194 = (as_record qual e)
in (FStar_Extraction_ML_Util.resugar_exp _169_194))
end
| _76_397 -> begin
(

let _76_400 = (FStar_List.unzip eargs)
in (match (_76_400) with
| (binders, eargs) -> begin
(match (e.FStar_Extraction_ML_Syntax.expr) with
| FStar_Extraction_ML_Syntax.MLE_CTor (head, args) -> begin
(

let body = (let _169_196 = (let _169_195 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty tres) (FStar_Extraction_ML_Syntax.MLE_CTor (((head), ((FStar_List.append args eargs))))))
in (FStar_All.pipe_left (as_record qual) _169_195))
in (FStar_All.pipe_left FStar_Extraction_ML_Util.resugar_exp _169_196))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty e.FStar_Extraction_ML_Syntax.mlty) (FStar_Extraction_ML_Syntax.MLE_Fun (((binders), (body))))))
end
| _76_407 -> begin
(FStar_All.failwith "Impossible")
end)
end))
end)
end)))
in (match (((mlAppExpr.FStar_Extraction_ML_Syntax.expr), (qual))) with
| (FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (mlp); FStar_Extraction_ML_Syntax.mlty = _76_411; FStar_Extraction_ML_Syntax.loc = _76_409}, (mlarg)::[]), _76_420) when (mlp = FStar_Extraction_ML_Syntax.mlp_lalloc) -> begin
(

let _76_423 = (FStar_Extraction_ML_Env.debug g (fun _76_422 -> (match (()) with
| () -> begin
(FStar_Util.print_string "need to do lalloc surgery here\n")
end)))
in (fix_lalloc mlarg))
end
| (_76_426, None) -> begin
mlAppExpr
end
| (FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (mlp); FStar_Extraction_ML_Syntax.mlty = _76_432; FStar_Extraction_ML_Syntax.loc = _76_430}, (mle)::args), Some (FStar_Absyn_Syntax.Record_projector (f))) -> begin
(

let fn = (FStar_Extraction_ML_Util.mlpath_of_lid f)
in (

let proj = FStar_Extraction_ML_Syntax.MLE_Proj (((mle), (fn)))
in (

let e = (match (args) with
| [] -> begin
proj
end
| _76_449 -> begin
(let _169_199 = (let _169_198 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.MLTY_Top) proj)
in ((_169_198), (args)))
in FStar_Extraction_ML_Syntax.MLE_App (_169_199))
end)
in (FStar_Extraction_ML_Syntax.with_ty mlAppExpr.FStar_Extraction_ML_Syntax.mlty e))))
end
| ((FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (mlp); FStar_Extraction_ML_Syntax.mlty = _; FStar_Extraction_ML_Syntax.loc = _}, mlargs), Some (FStar_Absyn_Syntax.Data_ctor))) | ((FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (mlp); FStar_Extraction_ML_Syntax.mlty = _; FStar_Extraction_ML_Syntax.loc = _}, mlargs), Some (FStar_Absyn_Syntax.Record_ctor (_)))) -> begin
(let _169_200 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty mlAppExpr.FStar_Extraction_ML_Syntax.mlty) (FStar_Extraction_ML_Syntax.MLE_CTor (((mlp), (mlargs)))))
in (FStar_All.pipe_left (resugar_and_maybe_eta qual) _169_200))
end
| ((FStar_Extraction_ML_Syntax.MLE_Name (mlp), Some (FStar_Absyn_Syntax.Data_ctor))) | ((FStar_Extraction_ML_Syntax.MLE_Name (mlp), Some (FStar_Absyn_Syntax.Record_ctor (_)))) -> begin
(let _169_201 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty mlAppExpr.FStar_Extraction_ML_Syntax.mlty) (FStar_Extraction_ML_Syntax.MLE_CTor (((mlp), ([])))))
in (FStar_All.pipe_left (resugar_and_maybe_eta qual) _169_201))
end
| _76_489 -> begin
mlAppExpr
end)))))


let check_pats_for_ite : (FStar_Absyn_Syntax.pat * FStar_Absyn_Syntax.exp Prims.option * FStar_Absyn_Syntax.exp) Prims.list  ->  (Prims.bool * FStar_Absyn_Syntax.exp Prims.option * FStar_Absyn_Syntax.exp Prims.option) = (fun l -> (

let def = ((false), (None), (None))
in if ((FStar_List.length l) <> (Prims.parse_int "2")) then begin
def
end else begin
(

let _76_495 = (FStar_List.hd l)
in (match (_76_495) with
| (p1, w1, e1) -> begin
(

let _76_499 = (let _169_204 = (FStar_List.tl l)
in (FStar_List.hd _169_204))
in (match (_76_499) with
| (p2, w2, e2) -> begin
(match (((w1), (w2), (p1.FStar_Absyn_Syntax.v), (p2.FStar_Absyn_Syntax.v))) with
| (None, None, FStar_Absyn_Syntax.Pat_constant (FStar_Const.Const_bool (true)), FStar_Absyn_Syntax.Pat_constant (FStar_Const.Const_bool (false))) -> begin
((true), (Some (e1)), (Some (e2)))
end
| (None, None, FStar_Absyn_Syntax.Pat_constant (FStar_Const.Const_bool (false)), FStar_Absyn_Syntax.Pat_constant (FStar_Const.Const_bool (true))) -> begin
((true), (Some (e2)), (Some (e1)))
end
| _76_519 -> begin
def
end)
end))
end))
end))


let rec check_exp : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.exp  ->  FStar_Extraction_ML_Syntax.e_tag  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlexpr = (fun g e f t -> (

let _76_529 = (let _169_221 = (check_exp' g e f t)
in (erase g _169_221 f t))
in (match (_76_529) with
| (e, _76_526, _76_528) -> begin
e
end)))
and check_exp' : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.exp  ->  FStar_Extraction_ML_Syntax.e_tag  ->  FStar_Extraction_ML_Syntax.mlty  ->  FStar_Extraction_ML_Syntax.mlexpr = (fun g e f t -> (

let _76_537 = (synth_exp g e)
in (match (_76_537) with
| (e0, f0, t0) -> begin
if (FStar_Extraction_ML_Util.eff_leq f0 f) then begin
(maybe_coerce g e0 t0 t)
end else begin
(err_unexpected_eff e f f0)
end
end)))
and synth_exp : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.exp  ->  (FStar_Extraction_ML_Syntax.mlexpr * FStar_Extraction_ML_Syntax.e_tag * FStar_Extraction_ML_Syntax.mlty) = (fun g e -> (

let _76_543 = (synth_exp' g e)
in (match (_76_543) with
| (e, f, t) -> begin
(erase g e f t)
end)))
and synth_exp' : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.exp  ->  (FStar_Extraction_ML_Syntax.mlexpr * FStar_Extraction_ML_Syntax.e_tag * FStar_Extraction_ML_Syntax.mlty) = (fun g e -> (

let _76_547 = (FStar_Extraction_ML_Env.debug g (fun u -> (let _169_233 = (let _169_232 = (FStar_Absyn_Print.tag_of_exp e)
in (let _169_231 = (FStar_Absyn_Print.exp_to_string e)
in (FStar_Util.format2 "now synthesizing expression (%s) :  %s \n" _169_232 _169_231)))
in (FStar_Util.print_string _169_233))))
in (match ((let _169_234 = (FStar_Absyn_Util.compress_exp e)
in _169_234.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Exp_constant (c) -> begin
(

let t = (FStar_Tc_Recheck.typing_const e.FStar_Absyn_Syntax.pos c)
in (

let ml_ty = (translate_typ g t)
in (let _169_238 = (let _169_237 = (let _169_236 = (FStar_Extraction_ML_Util.mlconst_of_const' e.FStar_Absyn_Syntax.pos c)
in (FStar_All.pipe_left (fun _169_235 -> FStar_Extraction_ML_Syntax.MLE_Const (_169_235)) _169_236))
in (FStar_Extraction_ML_Syntax.with_ty ml_ty _169_237))
in ((_169_238), (FStar_Extraction_ML_Syntax.E_PURE), (ml_ty)))))
end
| FStar_Absyn_Syntax.Exp_ascribed (e0, t, f) -> begin
(

let t = (translate_typ g t)
in (

let f = (match (f) with
| None -> begin
(FStar_All.failwith "Ascription node with an empty effect label")
end
| Some (l) -> begin
(FStar_Extraction_ML_ExtractTyp.translate_eff g l)
end)
in (

let e = (check_exp g e0 f t)
in ((e), (f), (t)))))
end
| (FStar_Absyn_Syntax.Exp_bvar (_)) | (FStar_Absyn_Syntax.Exp_fvar (_)) -> begin
(

let _76_576 = (FStar_Extraction_ML_Env.lookup_var g e)
in (match (_76_576) with
| ((x, mltys, _76_573), qual) -> begin
(match (mltys) with
| ([], t) -> begin
(let _169_239 = (maybe_lalloc_eta_data g qual t x)
in ((_169_239), (FStar_Extraction_ML_Syntax.E_PURE), (t)))
end
| _76_581 -> begin
(err_uninst g e mltys)
end)
end))
end
| FStar_Absyn_Syntax.Exp_app (head, args) -> begin
(

let rec synth_app = (fun is_data _76_590 _76_593 restArgs -> (match (((_76_590), (_76_593))) with
| ((mlhead, mlargs_f), (f, t)) -> begin
(match (((restArgs), (t))) with
| ([], _76_597) -> begin
(

let _76_608 = if ((FStar_Absyn_Util.is_primop head) || (FStar_Extraction_ML_Util.codegen_fsharp ())) then begin
(let _169_248 = (FStar_All.pipe_right (FStar_List.rev mlargs_f) (FStar_List.map Prims.fst))
in (([]), (_169_248)))
end else begin
(FStar_List.fold_left (fun _76_601 _76_604 -> (match (((_76_601), (_76_604))) with
| ((lbs, out_args), (arg, f)) -> begin
if ((f = FStar_Extraction_ML_Syntax.E_PURE) || (f = FStar_Extraction_ML_Syntax.E_GHOST)) then begin
((lbs), ((arg)::out_args))
end else begin
(

let x = (let _169_251 = (FStar_Absyn_Util.gensym ())
in ((_169_251), ((~- ((Prims.parse_int "1"))))))
in (let _169_253 = (let _169_252 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty arg.FStar_Extraction_ML_Syntax.mlty) (FStar_Extraction_ML_Syntax.MLE_Var (x)))
in (_169_252)::out_args)
in (((((x), (arg)))::lbs), (_169_253))))
end
end)) (([]), ([])) mlargs_f)
end
in (match (_76_608) with
| (lbs, mlargs) -> begin
(

let app = (let _169_254 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty t) (FStar_Extraction_ML_Syntax.MLE_App (((mlhead), (mlargs)))))
in (FStar_All.pipe_left (maybe_lalloc_eta_data g is_data t) _169_254))
in (

let l_app = (FStar_List.fold_right (fun _76_612 out -> (match (_76_612) with
| (x, arg) -> begin
(FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty out.FStar_Extraction_ML_Syntax.mlty) (FStar_Extraction_ML_Syntax.MLE_Let (((((FStar_Extraction_ML_Syntax.NoLetQualifier), (({FStar_Extraction_ML_Syntax.mllb_name = x; FStar_Extraction_ML_Syntax.mllb_tysc = Some ((([]), (arg.FStar_Extraction_ML_Syntax.mlty))); FStar_Extraction_ML_Syntax.mllb_add_unit = false; FStar_Extraction_ML_Syntax.mllb_def = arg; FStar_Extraction_ML_Syntax.print_typ = true})::[]))), (out)))))
end)) lbs app)
in ((l_app), (f), (t))))
end))
end
| (((FStar_Util.Inl (_76_617), _76_620))::rest, FStar_Extraction_ML_Syntax.MLTY_Fun (tunit, f', t)) -> begin
if (type_leq g tunit FStar_Extraction_ML_Syntax.ml_unit_ty) then begin
(let _169_258 = (let _169_257 = (FStar_Extraction_ML_Util.join f f')
in ((_169_257), (t)))
in (synth_app is_data ((mlhead), ((((FStar_Extraction_ML_Syntax.ml_unit), (FStar_Extraction_ML_Syntax.E_PURE)))::mlargs_f)) _169_258 rest))
end else begin
(FStar_All.failwith "Impossible: ill-typed application")
end
end
| (((FStar_Util.Inr (e0), _76_633))::rest, FStar_Extraction_ML_Syntax.MLTY_Fun (tExpected, f', t)) -> begin
(

let _76_645 = (synth_exp g e0)
in (match (_76_645) with
| (e0, f0, tInferred) -> begin
(

let e0 = (maybe_coerce g e0 tInferred tExpected)
in (let _169_260 = (let _169_259 = (FStar_Extraction_ML_Util.join_l ((f)::(f')::(f0)::[]))
in ((_169_259), (t)))
in (synth_app is_data ((mlhead), ((((e0), (f0)))::mlargs_f)) _169_260 rest)))
end))
end
| _76_648 -> begin
(match ((FStar_Extraction_ML_Util.delta_unfold g t)) with
| Some (t) -> begin
(synth_app is_data ((mlhead), (mlargs_f)) ((f), (t)) restArgs)
end
| None -> begin
(err_ill_typed_application e restArgs t)
end)
end)
end))
in (

let synth_app_maybe_projector = (fun is_data mlhead _76_657 args -> (match (_76_657) with
| (f, t) -> begin
(match (is_data) with
| Some (FStar_Absyn_Syntax.Record_projector (_76_660)) -> begin
(

let rec remove_implicits = (fun args f t -> (match (((args), (t))) with
| (((FStar_Util.Inr (_76_669), Some (FStar_Absyn_Syntax.Implicit (_76_672))))::args, FStar_Extraction_ML_Syntax.MLTY_Fun (_76_678, f', t)) -> begin
(let _169_275 = (FStar_Extraction_ML_Util.join f f')
in (remove_implicits args _169_275 t))
end
| _76_685 -> begin
((args), (f), (t))
end))
in (

let _76_689 = (remove_implicits args f t)
in (match (_76_689) with
| (args, f, t) -> begin
(synth_app is_data ((mlhead), ([])) ((f), (t)) args)
end)))
end
| _76_691 -> begin
(synth_app is_data ((mlhead), ([])) ((f), (t)) args)
end)
end))
in (

let head = (FStar_Absyn_Util.compress_exp head)
in (match (head.FStar_Absyn_Syntax.n) with
| (FStar_Absyn_Syntax.Exp_bvar (_)) | (FStar_Absyn_Syntax.Exp_fvar (_)) -> begin
(

let _76_706 = (FStar_Extraction_ML_Env.lookup_var g head)
in (match (_76_706) with
| ((head_ml, (vars, t), inst_ok), qual) -> begin
(

let has_typ_apps = (match (args) with
| ((FStar_Util.Inl (_76_710), _76_713))::_76_708 -> begin
true
end
| _76_717 -> begin
false
end)
in (

let _76_759 = (match (vars) with
| (_76_722)::_76_720 when ((not (has_typ_apps)) && inst_ok) -> begin
((head_ml), (t), (args))
end
| _76_725 -> begin
(

let n = (FStar_List.length vars)
in if (n <= (FStar_List.length args)) then begin
(

let _76_729 = (FStar_Util.first_N n args)
in (match (_76_729) with
| (prefix, rest) -> begin
(

let prefixAsMLTypes = (FStar_List.map (translate_typ_of_arg g) prefix)
in (

let t = (instantiate ((vars), (t)) prefixAsMLTypes)
in (

let head = (match (head_ml.FStar_Extraction_ML_Syntax.expr) with
| (FStar_Extraction_ML_Syntax.MLE_Name (_)) | (FStar_Extraction_ML_Syntax.MLE_Var (_)) -> begin
(

let _76_738 = head_ml
in {FStar_Extraction_ML_Syntax.expr = _76_738.FStar_Extraction_ML_Syntax.expr; FStar_Extraction_ML_Syntax.mlty = t; FStar_Extraction_ML_Syntax.loc = _76_738.FStar_Extraction_ML_Syntax.loc})
end
| FStar_Extraction_ML_Syntax.MLE_App (head, ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Const (FStar_Extraction_ML_Syntax.MLC_Unit); FStar_Extraction_ML_Syntax.mlty = _76_744; FStar_Extraction_ML_Syntax.loc = _76_742})::[]) -> begin
(FStar_All.pipe_right (FStar_Extraction_ML_Syntax.MLE_App ((((

let _76_751 = head
in {FStar_Extraction_ML_Syntax.expr = _76_751.FStar_Extraction_ML_Syntax.expr; FStar_Extraction_ML_Syntax.mlty = FStar_Extraction_ML_Syntax.MLTY_Fun (((FStar_Extraction_ML_Syntax.ml_unit_ty), (FStar_Extraction_ML_Syntax.E_PURE), (t))); FStar_Extraction_ML_Syntax.loc = _76_751.FStar_Extraction_ML_Syntax.loc})), ((FStar_Extraction_ML_Syntax.ml_unit)::[])))) (FStar_Extraction_ML_Syntax.with_ty t))
end
| _76_754 -> begin
(FStar_All.failwith "Impossible")
end)
in ((head), (t), (rest)))))
end))
end else begin
(err_uninst g head ((vars), (t)))
end)
end)
in (match (_76_759) with
| (head_ml, head_t, args) -> begin
(match (args) with
| [] -> begin
(let _169_276 = (maybe_lalloc_eta_data g qual head_t head_ml)
in ((_169_276), (FStar_Extraction_ML_Syntax.E_PURE), (head_t)))
end
| _76_762 -> begin
(synth_app_maybe_projector qual head_ml ((FStar_Extraction_ML_Syntax.E_PURE), (head_t)) args)
end)
end)))
end))
end
| _76_764 -> begin
(

let _76_768 = (synth_exp g head)
in (match (_76_768) with
| (head, f, t) -> begin
(synth_app_maybe_projector None head ((f), (t)) args)
end))
end))))
end
| FStar_Absyn_Syntax.Exp_abs (bs, body) -> begin
(

let _76_791 = (FStar_List.fold_left (fun _76_775 _76_779 -> (match (((_76_775), (_76_779))) with
| ((ml_bs, env), (b, _76_778)) -> begin
(match (b) with
| FStar_Util.Inl (a) -> begin
(

let env = (FStar_Extraction_ML_Env.extend_ty env a (Some (FStar_Extraction_ML_Syntax.MLTY_Top)))
in (

let ml_b = (let _169_279 = (FStar_Extraction_ML_Env.btvar_as_mlTermVar a)
in ((_169_279), (FStar_Extraction_ML_Syntax.ml_unit_ty)))
in (((ml_b)::ml_bs), (env))))
end
| FStar_Util.Inr (x) -> begin
(

let t = (translate_typ env x.FStar_Absyn_Syntax.sort)
in (

let env = (FStar_Extraction_ML_Env.extend_bv env x (([]), (t)) false false false)
in (

let ml_b = (((FStar_Extraction_ML_Syntax.as_mlident x.FStar_Absyn_Syntax.v)), (t))
in (((ml_b)::ml_bs), (env)))))
end)
end)) (([]), (g)) bs)
in (match (_76_791) with
| (ml_bs, env) -> begin
(

let ml_bs = (FStar_List.rev ml_bs)
in (

let _76_796 = (synth_exp env body)
in (match (_76_796) with
| (ml_body, f, t) -> begin
(

let _76_806 = (FStar_List.fold_right (fun _76_800 _76_803 -> (match (((_76_800), (_76_803))) with
| ((_76_798, targ), (f, t)) -> begin
((FStar_Extraction_ML_Syntax.E_PURE), (FStar_Extraction_ML_Syntax.MLTY_Fun (((targ), (f), (t)))))
end)) ml_bs ((f), (t)))
in (match (_76_806) with
| (f, tfun) -> begin
(let _169_282 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty tfun) (FStar_Extraction_ML_Syntax.MLE_Fun (((ml_bs), (ml_body)))))
in ((_169_282), (f), (tfun)))
end))
end)))
end))
end
| FStar_Absyn_Syntax.Exp_let ((is_rec, lbs), e') -> begin
(

let maybe_generalize = (fun _76_818 -> (match (_76_818) with
| {FStar_Absyn_Syntax.lbname = lbname; FStar_Absyn_Syntax.lbtyp = t; FStar_Absyn_Syntax.lbeff = lbeff; FStar_Absyn_Syntax.lbdef = e} -> begin
(

let f_e = (FStar_Extraction_ML_ExtractTyp.translate_eff g lbeff)
in (

let t = (FStar_Absyn_Util.compress_typ t)
in (match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (bs, c) when (FStar_Extraction_ML_Util.is_type_abstraction bs) -> begin
(

let _76_842 = (match ((FStar_Util.prefix_until (fun _76_4 -> (match (_76_4) with
| (FStar_Util.Inr (_76_827), _76_830) -> begin
true
end
| _76_833 -> begin
false
end)) bs)) with
| None -> begin
((bs), ((FStar_Absyn_Util.comp_result c)))
end
| Some (bs, b, rest) -> begin
(let _169_286 = (FStar_Absyn_Syntax.mk_Typ_fun (((b)::rest), (c)) None c.FStar_Absyn_Syntax.pos)
in ((bs), (_169_286)))
end)
in (match (_76_842) with
| (tbinders, tbody) -> begin
(

let n = (FStar_List.length tbinders)
in (

let e = (normalize_abs e)
in (match (e.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_abs (bs, body) -> begin
if (n <= (FStar_List.length bs)) then begin
(

let _76_851 = (FStar_Util.first_N n bs)
in (match (_76_851) with
| (targs, rest_args) -> begin
(

let expected_t = (match ((FStar_Absyn_Util.mk_subst_binder targs tbinders)) with
| None -> begin
(FStar_All.failwith "Not enough type binders in the body of the let expression")
end
| Some (s) -> begin
(FStar_Absyn_Util.subst_typ s tbody)
end)
in (

let targs = (FStar_All.pipe_right targs (FStar_List.map (fun _76_5 -> (match (_76_5) with
| (FStar_Util.Inl (a), _76_860) -> begin
a
end
| _76_863 -> begin
(FStar_All.failwith "Impossible")
end))))
in (

let env = (FStar_List.fold_left (fun env a -> (FStar_Extraction_ML_Env.extend_ty env a None)) g targs)
in (

let expected_t = (translate_typ env expected_t)
in (

let polytype = (let _169_290 = (FStar_All.pipe_right targs (FStar_List.map FStar_Extraction_ML_Env.btvar_as_mltyvar))
in ((_169_290), (expected_t)))
in (

let add_unit = (match (rest_args) with
| [] -> begin
(not ((is_value_or_type_app body)))
end
| _76_872 -> begin
false
end)
in (

let rest_args = if add_unit then begin
(FStar_Extraction_ML_Util.unit_binder)::rest_args
end else begin
rest_args
end
in (

let body = (match (rest_args) with
| [] -> begin
body
end
| _76_877 -> begin
(FStar_Absyn_Syntax.mk_Exp_abs ((rest_args), (body)) None e.FStar_Absyn_Syntax.pos)
end)
in ((lbname), (f_e), (((t), (((targs), (polytype))))), (add_unit), (body))))))))))
end))
end else begin
(FStar_All.failwith "Not enough type binders")
end
end
| _76_880 -> begin
(err_value_restriction e)
end)))
end))
end
| _76_882 -> begin
(

let expected_t = (translate_typ g t)
in ((lbname), (f_e), (((t), ((([]), ((([]), (expected_t))))))), (false), (e)))
end)))
end))
in (

let check_lb = (fun env _76_897 -> (match (_76_897) with
| (nm, (lbname, f, (t, (targs, polytype)), add_unit, e)) -> begin
(

let env = (FStar_List.fold_left (fun env a -> (FStar_Extraction_ML_Env.extend_ty env a None)) env targs)
in (

let expected_t = if add_unit then begin
FStar_Extraction_ML_Syntax.MLTY_Fun (((FStar_Extraction_ML_Syntax.ml_unit_ty), (FStar_Extraction_ML_Syntax.E_PURE), ((Prims.snd polytype))))
end else begin
(Prims.snd polytype)
end
in (

let e = (check_exp env e f expected_t)
in ((f), ({FStar_Extraction_ML_Syntax.mllb_name = nm; FStar_Extraction_ML_Syntax.mllb_tysc = Some (polytype); FStar_Extraction_ML_Syntax.mllb_add_unit = add_unit; FStar_Extraction_ML_Syntax.mllb_def = e; FStar_Extraction_ML_Syntax.print_typ = true})))))
end))
in (

let lbs = (FStar_All.pipe_right lbs (FStar_List.map maybe_generalize))
in (

let _76_926 = (FStar_List.fold_right (fun lb _76_907 -> (match (_76_907) with
| (env, lbs) -> begin
(

let _76_920 = lb
in (match (_76_920) with
| (lbname, _76_910, (t, (_76_913, polytype)), add_unit, _76_919) -> begin
(

let _76_923 = (FStar_Extraction_ML_Env.extend_lb env lbname t polytype add_unit true)
in (match (_76_923) with
| (env, nm) -> begin
((env), ((((nm), (lb)))::lbs))
end))
end))
end)) lbs ((g), ([])))
in (match (_76_926) with
| (env_body, lbs) -> begin
(

let env_def = if is_rec then begin
env_body
end else begin
g
end
in (

let lbs = (FStar_All.pipe_right lbs (FStar_List.map (check_lb env_def)))
in (

let _76_932 = (synth_exp env_body e')
in (match (_76_932) with
| (e', f', t') -> begin
(

let f = (let _169_300 = (let _169_299 = (FStar_List.map Prims.fst lbs)
in (f')::_169_299)
in (FStar_Extraction_ML_Util.join_l _169_300))
in (

let is_rec = if is_rec then begin
FStar_Extraction_ML_Syntax.Rec
end else begin
FStar_Extraction_ML_Syntax.NoLetQualifier
end
in (let _169_306 = (let _169_305 = (let _169_303 = (let _169_302 = (let _169_301 = (FStar_List.map Prims.snd lbs)
in ((is_rec), (_169_301)))
in ((_169_302), (e')))
in FStar_Extraction_ML_Syntax.MLE_Let (_169_303))
in (let _169_304 = (FStar_Extraction_ML_Util.mlloc_of_range e.FStar_Absyn_Syntax.pos)
in (FStar_Extraction_ML_Syntax.with_ty_loc t' _169_305 _169_304)))
in ((_169_306), (f), (t')))))
end))))
end)))))
end
| FStar_Absyn_Syntax.Exp_match (scrutinee, pats) -> begin
(

let _76_942 = (synth_exp g scrutinee)
in (match (_76_942) with
| (e, f_e, t_e) -> begin
(

let _76_946 = (check_pats_for_ite pats)
in (match (_76_946) with
| (b, then_e, else_e) -> begin
(

let no_lift = (fun x t -> x)
in if b then begin
(match (((then_e), (else_e))) with
| (Some (then_e), Some (else_e)) -> begin
(

let _76_958 = (synth_exp g then_e)
in (match (_76_958) with
| (then_mle, f_then, t_then) -> begin
(

let _76_962 = (synth_exp g else_e)
in (match (_76_962) with
| (else_mle, f_else, t_else) -> begin
(

let _76_965 = if (type_leq g t_then t_else) then begin
((t_else), (no_lift))
end else begin
if (type_leq g t_else t_then) then begin
((t_then), (no_lift))
end else begin
((FStar_Extraction_ML_Syntax.MLTY_Top), (FStar_Extraction_ML_Syntax.apply_obj_repr))
end
end
in (match (_76_965) with
| (t_branch, maybe_lift) -> begin
(let _169_337 = (let _169_335 = (let _169_334 = (let _169_333 = (maybe_lift then_mle t_then)
in (let _169_332 = (let _169_331 = (maybe_lift else_mle t_else)
in Some (_169_331))
in ((e), (_169_333), (_169_332))))
in FStar_Extraction_ML_Syntax.MLE_If (_169_334))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty t_branch) _169_335))
in (let _169_336 = (FStar_Extraction_ML_Util.join f_then f_else)
in ((_169_337), (_169_336), (t_branch))))
end))
end))
end))
end
| _76_967 -> begin
(FStar_All.failwith "ITE pats matched but then and else expressions not found?")
end)
end else begin
(

let mlbranches = (FStar_All.pipe_right pats (FStar_List.collect (fun _76_971 -> (match (_76_971) with
| (pat, when_opt, branch) -> begin
(

let _76_974 = (extract_pat g pat)
in (match (_76_974) with
| (env, p) -> begin
(

let _76_985 = (match (when_opt) with
| None -> begin
((None), (FStar_Extraction_ML_Syntax.E_PURE))
end
| Some (w) -> begin
(

let _76_981 = (synth_exp env w)
in (match (_76_981) with
| (w, f_w, t_w) -> begin
(

let w = (maybe_coerce env w t_w FStar_Extraction_ML_Syntax.ml_bool_ty)
in ((Some (w)), (f_w)))
end))
end)
in (match (_76_985) with
| (when_opt, f_when) -> begin
(

let _76_989 = (synth_exp env branch)
in (match (_76_989) with
| (mlbranch, f_branch, t_branch) -> begin
(FStar_All.pipe_right p (FStar_List.map (fun _76_992 -> (match (_76_992) with
| (p, wopt) -> begin
(

let when_clause = (FStar_Extraction_ML_Util.conjoin_opt wopt when_opt)
in ((p), (((when_clause), (f_when))), (((mlbranch), (f_branch), (t_branch)))))
end))))
end))
end))
end))
end))))
in (match (mlbranches) with
| [] -> begin
(

let _76_1001 = (FStar_Extraction_ML_Env.lookup_fv g (FStar_Absyn_Util.fv FStar_Absyn_Const.failwith_lid))
in (match (_76_1001) with
| (fw, _76_998, _76_1000) -> begin
(let _169_344 = (let _169_343 = (let _169_342 = (let _169_341 = (let _169_340 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_string_ty) (FStar_Extraction_ML_Syntax.MLE_Const (FStar_Extraction_ML_Syntax.MLC_String ("unreachable"))))
in (_169_340)::[])
in ((fw), (_169_341)))
in FStar_Extraction_ML_Syntax.MLE_App (_169_342))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_unit_ty) _169_343))
in ((_169_344), (FStar_Extraction_ML_Syntax.E_PURE), (FStar_Extraction_ML_Syntax.ml_unit_ty)))
end))
end
| ((_76_1004, _76_1006, (_76_1008, f_first, t_first)))::rest -> begin
(

let _76_1034 = (FStar_List.fold_left (fun _76_1016 _76_1026 -> (match (((_76_1016), (_76_1026))) with
| ((topt, f), (_76_1018, _76_1020, (_76_1022, f_branch, t_branch))) -> begin
(

let f = (FStar_Extraction_ML_Util.join f f_branch)
in (

let topt = (match (topt) with
| None -> begin
None
end
| Some (t) -> begin
if (type_leq g t t_branch) then begin
Some (t_branch)
end else begin
if (type_leq g t_branch t) then begin
Some (t)
end else begin
None
end
end
end)
in ((topt), (f))))
end)) ((Some (t_first)), (f_first)) rest)
in (match (_76_1034) with
| (topt, f_match) -> begin
(

let mlbranches = (FStar_All.pipe_right mlbranches (FStar_List.map (fun _76_1045 -> (match (_76_1045) with
| (p, (wopt, _76_1038), (b, _76_1042, t)) -> begin
(

let b = (match (topt) with
| None -> begin
(FStar_Extraction_ML_Syntax.apply_obj_repr b t)
end
| Some (_76_1048) -> begin
b
end)
in ((p), (wopt), (b)))
end))))
in (

let t_match = (match (topt) with
| None -> begin
FStar_Extraction_ML_Syntax.MLTY_Top
end
| Some (t) -> begin
t
end)
in (let _169_348 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty t_match) (FStar_Extraction_ML_Syntax.MLE_Match (((e), (mlbranches)))))
in ((_169_348), (f_match), (t_match)))))
end))
end))
end)
end))
end))
end
| FStar_Absyn_Syntax.Exp_meta (FStar_Absyn_Syntax.Meta_desugared (e, _76_1058)) -> begin
(synth_exp g e)
end
| (FStar_Absyn_Syntax.Exp_uvar (_)) | (FStar_Absyn_Syntax.Exp_delayed (_)) -> begin
(fail e.FStar_Absyn_Syntax.pos "Unexpected expression")
end)))


let fresh : Prims.string  ->  (Prims.string * Prims.int) = (

let c = (FStar_Util.mk_ref (Prims.parse_int "0"))
in (fun x -> (

let _76_1070 = (FStar_Util.incr c)
in (let _169_351 = (FStar_ST.read c)
in ((x), (_169_351))))))


let ind_discriminator_body : FStar_Extraction_ML_Env.env  ->  FStar_Ident.lident  ->  FStar_Ident.lident  ->  FStar_Extraction_ML_Syntax.mlmodule1 = (fun env discName constrName -> (

let fstar_disc_type = (FStar_Tc_Env.lookup_lid env.FStar_Extraction_ML_Env.tcenv discName)
in (

let wildcards = (match (fstar_disc_type.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (binders, _76_1078) -> begin
(let _169_361 = (FStar_All.pipe_right binders (FStar_List.filter (fun _76_6 -> (match (_76_6) with
| (_76_1083, Some (FStar_Absyn_Syntax.Implicit (_76_1085))) -> begin
true
end
| _76_1090 -> begin
false
end))))
in (FStar_All.pipe_right _169_361 (FStar_List.map (fun _76_1091 -> (let _169_360 = (fresh "_")
in ((_169_360), (FStar_Extraction_ML_Syntax.MLTY_Top)))))))
end
| _76_1094 -> begin
(FStar_All.failwith "Discriminator must be a function")
end)
in (

let mlid = (fresh "_discr_")
in (

let targ = FStar_Extraction_ML_Syntax.MLTY_Top
in (

let disc_ty = FStar_Extraction_ML_Syntax.MLTY_Top
in (

let discrBody = (let _169_376 = (let _169_375 = (let _169_374 = (let _169_373 = (let _169_372 = (let _169_371 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty targ) (FStar_Extraction_ML_Syntax.MLE_Name ((([]), ((FStar_Extraction_ML_Syntax.idsym mlid))))))
in (let _169_370 = (let _169_369 = (let _169_365 = (let _169_363 = (let _169_362 = (FStar_Extraction_ML_Syntax.mlpath_of_lident constrName)
in ((_169_362), ((FStar_Extraction_ML_Syntax.MLP_Wild)::[])))
in FStar_Extraction_ML_Syntax.MLP_CTor (_169_363))
in (let _169_364 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_bool_ty) (FStar_Extraction_ML_Syntax.MLE_Const (FStar_Extraction_ML_Syntax.MLC_Bool (true))))
in ((_169_365), (None), (_169_364))))
in (let _169_368 = (let _169_367 = (let _169_366 = (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_bool_ty) (FStar_Extraction_ML_Syntax.MLE_Const (FStar_Extraction_ML_Syntax.MLC_Bool (false))))
in ((FStar_Extraction_ML_Syntax.MLP_Wild), (None), (_169_366)))
in (_169_367)::[])
in (_169_369)::_169_368))
in ((_169_371), (_169_370))))
in FStar_Extraction_ML_Syntax.MLE_Match (_169_372))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty FStar_Extraction_ML_Syntax.ml_bool_ty) _169_373))
in (((FStar_List.append wildcards ((((mlid), (targ)))::[]))), (_169_374)))
in FStar_Extraction_ML_Syntax.MLE_Fun (_169_375))
in (FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty disc_ty) _169_376))
in FStar_Extraction_ML_Syntax.MLM_Let (((FStar_Extraction_ML_Syntax.NoLetQualifier), (({FStar_Extraction_ML_Syntax.mllb_name = (FStar_Extraction_ML_Env.convIdent discName.FStar_Ident.ident); FStar_Extraction_ML_Syntax.mllb_tysc = None; FStar_Extraction_ML_Syntax.mllb_add_unit = false; FStar_Extraction_ML_Syntax.mllb_def = discrBody; FStar_Extraction_ML_Syntax.print_typ = true})::[]))))))))))




