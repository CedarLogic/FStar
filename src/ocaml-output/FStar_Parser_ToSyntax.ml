
open Prims

let trans_aqual : FStar_Parser_AST.arg_qualifier Prims.option  ->  FStar_Syntax_Syntax.arg_qualifier Prims.option = (fun _64_1 -> (match (_64_1) with
| Some (FStar_Parser_AST.Implicit) -> begin
Some (FStar_Syntax_Syntax.imp_tag)
end
| Some (FStar_Parser_AST.Equality) -> begin
Some (FStar_Syntax_Syntax.Equality)
end
| _64_29 -> begin
None
end))


let trans_qual : FStar_Range.range  ->  FStar_Parser_AST.qualifier  ->  FStar_Syntax_Syntax.qualifier = (fun r _64_2 -> (match (_64_2) with
| FStar_Parser_AST.Private -> begin
FStar_Syntax_Syntax.Private
end
| FStar_Parser_AST.Assumption -> begin
FStar_Syntax_Syntax.Assumption
end
| FStar_Parser_AST.Inline -> begin
FStar_Syntax_Syntax.Inline
end
| FStar_Parser_AST.Unfoldable -> begin
FStar_Syntax_Syntax.Unfoldable
end
| FStar_Parser_AST.Irreducible -> begin
FStar_Syntax_Syntax.Irreducible
end
| FStar_Parser_AST.Logic -> begin
FStar_Syntax_Syntax.Logic
end
| FStar_Parser_AST.TotalEffect -> begin
FStar_Syntax_Syntax.TotalEffect
end
| FStar_Parser_AST.Effect -> begin
FStar_Syntax_Syntax.Effect
end
| FStar_Parser_AST.New -> begin
FStar_Syntax_Syntax.New
end
| FStar_Parser_AST.Abstract -> begin
FStar_Syntax_Syntax.Abstract
end
| FStar_Parser_AST.Opaque -> begin
(

let _64_43 = (FStar_TypeChecker_Errors.warn r "The \'opaque\' qualifier is deprecated since its use was strangely schizophrenic. There were two overloaded uses: (1) Given \'opaque val f : t\', the behavior was to exclude the definition of \'f\' to the SMT solver. This corresponds roughly to the new \'irreducible\' qualifier. (2) Given \'opaque type t = t\'\', the behavior was to provide the definition of \'t\' to the SMT solver, but not to inline it, unless absolutely required for unification. This corresponds roughly to the behavior of \'unfoldable\' (which is currently the default).")
in FStar_Syntax_Syntax.Unfoldable)
end
| FStar_Parser_AST.Reflectable -> begin
FStar_Syntax_Syntax.Reflectable
end
| FStar_Parser_AST.Reifiable -> begin
FStar_Syntax_Syntax.Reifiable
end
| FStar_Parser_AST.Noeq -> begin
FStar_Syntax_Syntax.Noeq
end
| FStar_Parser_AST.DefaultEffect -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("The \'default\' qualifier on effects is no longer supported"), (r)))))
end))


let trans_pragma : FStar_Parser_AST.pragma  ->  FStar_Syntax_Syntax.pragma = (fun _64_3 -> (match (_64_3) with
| FStar_Parser_AST.SetOptions (s) -> begin
FStar_Syntax_Syntax.SetOptions (s)
end
| FStar_Parser_AST.ResetOptions (sopt) -> begin
FStar_Syntax_Syntax.ResetOptions (sopt)
end))


let as_imp : FStar_Parser_AST.imp  ->  FStar_Syntax_Syntax.arg_qualifier Prims.option = (fun _64_4 -> (match (_64_4) with
| FStar_Parser_AST.Hash -> begin
Some (FStar_Syntax_Syntax.imp_tag)
end
| _64_57 -> begin
None
end))


let arg_withimp_e = (fun imp t -> ((t), ((as_imp imp))))


let arg_withimp_t = (fun imp t -> (match (imp) with
| FStar_Parser_AST.Hash -> begin
((t), (Some (FStar_Syntax_Syntax.imp_tag)))
end
| _64_64 -> begin
((t), (None))
end))


let contains_binder : FStar_Parser_AST.binder Prims.list  ->  Prims.bool = (fun binders -> (FStar_All.pipe_right binders (FStar_Util.for_some (fun b -> (match (b.FStar_Parser_AST.b) with
| FStar_Parser_AST.Annotated (_64_68) -> begin
true
end
| _64_71 -> begin
false
end)))))


let rec unparen : FStar_Parser_AST.term  ->  FStar_Parser_AST.term = (fun t -> (match (t.FStar_Parser_AST.tm) with
| FStar_Parser_AST.Paren (t) -> begin
(unparen t)
end
| _64_76 -> begin
t
end))


let tm_type_z : FStar_Range.range  ->  FStar_Parser_AST.term = (fun r -> (let _156_23 = (let _156_22 = (FStar_Ident.lid_of_path (("Type0")::[]) r)
in FStar_Parser_AST.Name (_156_22))
in (FStar_Parser_AST.mk_term _156_23 r FStar_Parser_AST.Kind)))


let tm_type : FStar_Range.range  ->  FStar_Parser_AST.term = (fun r -> (let _156_27 = (let _156_26 = (FStar_Ident.lid_of_path (("Type")::[]) r)
in FStar_Parser_AST.Name (_156_26))
in (FStar_Parser_AST.mk_term _156_27 r FStar_Parser_AST.Kind)))


let compile_op : Prims.int  ->  Prims.string  ->  Prims.string = (fun arity s -> (

let name_of_char = (fun _64_5 -> (match (_64_5) with
| '&' -> begin
"Amp"
end
| '@' -> begin
"At"
end
| '+' -> begin
"Plus"
end
| '-' when (arity = 1) -> begin
"Minus"
end
| '-' -> begin
"Subtraction"
end
| '/' -> begin
"Slash"
end
| '<' -> begin
"Less"
end
| '=' -> begin
"Equals"
end
| '>' -> begin
"Greater"
end
| '_' -> begin
"Underscore"
end
| '|' -> begin
"Bar"
end
| '!' -> begin
"Bang"
end
| '^' -> begin
"Hat"
end
| '%' -> begin
"Percent"
end
| '*' -> begin
"Star"
end
| '?' -> begin
"Question"
end
| ':' -> begin
"Colon"
end
| _64_100 -> begin
"UNKNOWN"
end))
in (

let rec aux = (fun i -> if (i = (FStar_String.length s)) then begin
[]
end else begin
(let _156_38 = (let _156_36 = (FStar_Util.char_at s i)
in (name_of_char _156_36))
in (let _156_37 = (aux (i + 1))
in (_156_38)::_156_37))
end)
in (match (s) with
| ".[]<-" -> begin
"op_String_Assignment"
end
| ".()<-" -> begin
"op_Array_Assignment"
end
| ".[]" -> begin
"op_String_Access"
end
| ".()" -> begin
"op_Array_Access"
end
| _64_109 -> begin
(let _156_40 = (let _156_39 = (aux 0)
in (FStar_String.concat "_" _156_39))
in (Prims.strcat "op_" _156_40))
end))))


let compile_op_lid : Prims.int  ->  Prims.string  ->  FStar_Range.range  ->  FStar_Ident.lident = (fun n s r -> (let _156_50 = (let _156_49 = (let _156_48 = (let _156_47 = (compile_op n s)
in ((_156_47), (r)))
in (FStar_Ident.mk_ident _156_48))
in (_156_49)::[])
in (FStar_All.pipe_right _156_50 FStar_Ident.lid_of_ids)))


let op_as_term : FStar_Parser_Env.env  ->  Prims.int  ->  FStar_Range.range  ->  Prims.string  ->  FStar_Syntax_Syntax.term Prims.option = (fun env arity rng s -> (

let r = (fun l dd -> (let _156_65 = (let _156_64 = (let _156_63 = (FStar_Ident.set_lid_range l rng)
in (FStar_Syntax_Syntax.lid_as_fv _156_63 dd None))
in (FStar_All.pipe_right _156_64 FStar_Syntax_Syntax.fv_to_tm))
in Some (_156_65)))
in (

let fallback = (fun _64_121 -> (match (()) with
| () -> begin
(match (s) with
| "=" -> begin
(r FStar_Syntax_Const.op_Eq FStar_Syntax_Syntax.Delta_equational)
end
| ":=" -> begin
(r FStar_Syntax_Const.op_ColonEq FStar_Syntax_Syntax.Delta_equational)
end
| "<" -> begin
(r FStar_Syntax_Const.op_LT FStar_Syntax_Syntax.Delta_equational)
end
| "<=" -> begin
(r FStar_Syntax_Const.op_LTE FStar_Syntax_Syntax.Delta_equational)
end
| ">" -> begin
(r FStar_Syntax_Const.op_GT FStar_Syntax_Syntax.Delta_equational)
end
| ">=" -> begin
(r FStar_Syntax_Const.op_GTE FStar_Syntax_Syntax.Delta_equational)
end
| "&&" -> begin
(r FStar_Syntax_Const.op_And FStar_Syntax_Syntax.Delta_equational)
end
| "||" -> begin
(r FStar_Syntax_Const.op_Or FStar_Syntax_Syntax.Delta_equational)
end
| "+" -> begin
(r FStar_Syntax_Const.op_Addition FStar_Syntax_Syntax.Delta_equational)
end
| "-" when (arity = 1) -> begin
(r FStar_Syntax_Const.op_Minus FStar_Syntax_Syntax.Delta_equational)
end
| "-" -> begin
(r FStar_Syntax_Const.op_Subtraction FStar_Syntax_Syntax.Delta_equational)
end
| "/" -> begin
(r FStar_Syntax_Const.op_Division FStar_Syntax_Syntax.Delta_equational)
end
| "%" -> begin
(r FStar_Syntax_Const.op_Modulus FStar_Syntax_Syntax.Delta_equational)
end
| "!" -> begin
(r FStar_Syntax_Const.read_lid FStar_Syntax_Syntax.Delta_equational)
end
| "@" -> begin
(r FStar_Syntax_Const.list_append_lid FStar_Syntax_Syntax.Delta_equational)
end
| "^" -> begin
(r FStar_Syntax_Const.strcat_lid FStar_Syntax_Syntax.Delta_equational)
end
| "|>" -> begin
(r FStar_Syntax_Const.pipe_right_lid FStar_Syntax_Syntax.Delta_equational)
end
| "<|" -> begin
(r FStar_Syntax_Const.pipe_left_lid FStar_Syntax_Syntax.Delta_equational)
end
| "<>" -> begin
(r FStar_Syntax_Const.op_notEq FStar_Syntax_Syntax.Delta_equational)
end
| "~" -> begin
(r FStar_Syntax_Const.not_lid (FStar_Syntax_Syntax.Delta_unfoldable (2)))
end
| "==" -> begin
(r FStar_Syntax_Const.eq2_lid FStar_Syntax_Syntax.Delta_constant)
end
| "<<" -> begin
(r FStar_Syntax_Const.precedes_lid FStar_Syntax_Syntax.Delta_constant)
end
| "/\\" -> begin
(r FStar_Syntax_Const.and_lid (FStar_Syntax_Syntax.Delta_unfoldable (1)))
end
| "\\/" -> begin
(r FStar_Syntax_Const.or_lid (FStar_Syntax_Syntax.Delta_unfoldable (1)))
end
| "==>" -> begin
(r FStar_Syntax_Const.imp_lid (FStar_Syntax_Syntax.Delta_unfoldable (1)))
end
| "<==>" -> begin
(r FStar_Syntax_Const.iff_lid (FStar_Syntax_Syntax.Delta_unfoldable (2)))
end
| _64_149 -> begin
None
end)
end))
in (match ((let _156_68 = (compile_op_lid arity s rng)
in (FStar_Parser_Env.try_lookup_lid env _156_68))) with
| Some (t) -> begin
Some ((Prims.fst t))
end
| _64_153 -> begin
(fallback ())
end))))


let sort_ftv : FStar_Ident.ident Prims.list  ->  FStar_Ident.ident Prims.list = (fun ftv -> (let _156_75 = (FStar_Util.remove_dups (fun x y -> (x.FStar_Ident.idText = y.FStar_Ident.idText)) ftv)
in (FStar_All.pipe_left (FStar_Util.sort_with (fun x y -> (FStar_String.compare x.FStar_Ident.idText y.FStar_Ident.idText))) _156_75)))


let rec free_type_vars_b : FStar_Parser_Env.env  ->  FStar_Parser_AST.binder  ->  (FStar_Parser_Env.env * FStar_Ident.ident Prims.list) = (fun env binder -> (match (binder.FStar_Parser_AST.b) with
| FStar_Parser_AST.Variable (_64_162) -> begin
((env), ([]))
end
| FStar_Parser_AST.TVariable (x) -> begin
(

let _64_169 = (FStar_Parser_Env.push_bv env x)
in (match (_64_169) with
| (env, _64_168) -> begin
((env), ((x)::[]))
end))
end
| FStar_Parser_AST.Annotated (_64_171, term) -> begin
(let _156_82 = (free_type_vars env term)
in ((env), (_156_82)))
end
| FStar_Parser_AST.TAnnotated (id, _64_177) -> begin
(

let _64_183 = (FStar_Parser_Env.push_bv env id)
in (match (_64_183) with
| (env, _64_182) -> begin
((env), ([]))
end))
end
| FStar_Parser_AST.NoName (t) -> begin
(let _156_83 = (free_type_vars env t)
in ((env), (_156_83)))
end))
and free_type_vars : FStar_Parser_Env.env  ->  FStar_Parser_AST.term  ->  FStar_Ident.ident Prims.list = (fun env t -> (match ((let _156_86 = (unparen t)
in _156_86.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.Labeled (_64_189) -> begin
(FStar_All.failwith "Impossible --- labeled source term")
end
| FStar_Parser_AST.Tvar (a) -> begin
(match ((FStar_Parser_Env.try_lookup_id env a)) with
| None -> begin
(a)::[]
end
| _64_195 -> begin
[]
end)
end
| (FStar_Parser_AST.Wild) | (FStar_Parser_AST.Const (_)) | (FStar_Parser_AST.Var (_)) | (FStar_Parser_AST.Name (_)) -> begin
[]
end
| (FStar_Parser_AST.Assign (_, t)) | (FStar_Parser_AST.Requires (t, _)) | (FStar_Parser_AST.Ensures (t, _)) | (FStar_Parser_AST.NamedTyp (_, t)) | (FStar_Parser_AST.Paren (t)) | (FStar_Parser_AST.Ascribed (t, _)) -> begin
(free_type_vars env t)
end
| FStar_Parser_AST.Construct (_64_229, ts) -> begin
(FStar_List.collect (fun _64_236 -> (match (_64_236) with
| (t, _64_235) -> begin
(free_type_vars env t)
end)) ts)
end
| FStar_Parser_AST.Op (_64_238, ts) -> begin
(FStar_List.collect (free_type_vars env) ts)
end
| FStar_Parser_AST.App (t1, t2, _64_245) -> begin
(let _156_89 = (free_type_vars env t1)
in (let _156_88 = (free_type_vars env t2)
in (FStar_List.append _156_89 _156_88)))
end
| FStar_Parser_AST.Refine (b, t) -> begin
(

let _64_254 = (free_type_vars_b env b)
in (match (_64_254) with
| (env, f) -> begin
(let _156_90 = (free_type_vars env t)
in (FStar_List.append f _156_90))
end))
end
| (FStar_Parser_AST.Product (binders, body)) | (FStar_Parser_AST.Sum (binders, body)) -> begin
(

let _64_270 = (FStar_List.fold_left (fun _64_263 binder -> (match (_64_263) with
| (env, free) -> begin
(

let _64_267 = (free_type_vars_b env binder)
in (match (_64_267) with
| (env, f) -> begin
((env), ((FStar_List.append f free)))
end))
end)) ((env), ([])) binders)
in (match (_64_270) with
| (env, free) -> begin
(let _156_93 = (free_type_vars env body)
in (FStar_List.append free _156_93))
end))
end
| FStar_Parser_AST.Project (t, _64_273) -> begin
(free_type_vars env t)
end
| (FStar_Parser_AST.Abs (_)) | (FStar_Parser_AST.Let (_)) | (FStar_Parser_AST.LetOpen (_)) | (FStar_Parser_AST.If (_)) | (FStar_Parser_AST.QForall (_)) | (FStar_Parser_AST.QExists (_)) | (FStar_Parser_AST.Record (_)) | (FStar_Parser_AST.Match (_)) | (FStar_Parser_AST.TryWith (_)) | (FStar_Parser_AST.Seq (_)) -> begin
[]
end))


let head_and_args : FStar_Parser_AST.term  ->  (FStar_Parser_AST.term * (FStar_Parser_AST.term * FStar_Parser_AST.imp) Prims.list) = (fun t -> (

let rec aux = (fun args t -> (match ((let _156_100 = (unparen t)
in _156_100.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.App (t, arg, imp) -> begin
(aux ((((arg), (imp)))::args) t)
end
| FStar_Parser_AST.Construct (l, args') -> begin
(({FStar_Parser_AST.tm = FStar_Parser_AST.Name (l); FStar_Parser_AST.range = t.FStar_Parser_AST.range; FStar_Parser_AST.level = t.FStar_Parser_AST.level}), ((FStar_List.append args' args)))
end
| _64_320 -> begin
((t), (args))
end))
in (aux [] t)))


let close : FStar_Parser_Env.env  ->  FStar_Parser_AST.term  ->  FStar_Parser_AST.term = (fun env t -> (

let ftv = (let _156_105 = (free_type_vars env t)
in (FStar_All.pipe_left sort_ftv _156_105))
in if ((FStar_List.length ftv) = 0) then begin
t
end else begin
(

let binders = (FStar_All.pipe_right ftv (FStar_List.map (fun x -> (let _156_109 = (let _156_108 = (let _156_107 = (tm_type x.FStar_Ident.idRange)
in ((x), (_156_107)))
in FStar_Parser_AST.TAnnotated (_156_108))
in (FStar_Parser_AST.mk_binder _156_109 x.FStar_Ident.idRange FStar_Parser_AST.Type (Some (FStar_Parser_AST.Implicit)))))))
in (

let result = (FStar_Parser_AST.mk_term (FStar_Parser_AST.Product (((binders), (t)))) t.FStar_Parser_AST.range t.FStar_Parser_AST.level)
in result))
end))


let close_fun : FStar_Parser_Env.env  ->  FStar_Parser_AST.term  ->  FStar_Parser_AST.term = (fun env t -> (

let ftv = (let _156_114 = (free_type_vars env t)
in (FStar_All.pipe_left sort_ftv _156_114))
in if ((FStar_List.length ftv) = 0) then begin
t
end else begin
(

let binders = (FStar_All.pipe_right ftv (FStar_List.map (fun x -> (let _156_118 = (let _156_117 = (let _156_116 = (tm_type x.FStar_Ident.idRange)
in ((x), (_156_116)))
in FStar_Parser_AST.TAnnotated (_156_117))
in (FStar_Parser_AST.mk_binder _156_118 x.FStar_Ident.idRange FStar_Parser_AST.Type (Some (FStar_Parser_AST.Implicit)))))))
in (

let t = (match ((let _156_119 = (unparen t)
in _156_119.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.Product (_64_333) -> begin
t
end
| _64_336 -> begin
(FStar_Parser_AST.mk_term (FStar_Parser_AST.App ((((FStar_Parser_AST.mk_term (FStar_Parser_AST.Name (FStar_Syntax_Const.effect_Tot_lid)) t.FStar_Parser_AST.range t.FStar_Parser_AST.level)), (t), (FStar_Parser_AST.Nothing)))) t.FStar_Parser_AST.range t.FStar_Parser_AST.level)
end)
in (

let result = (FStar_Parser_AST.mk_term (FStar_Parser_AST.Product (((binders), (t)))) t.FStar_Parser_AST.range t.FStar_Parser_AST.level)
in result)))
end))


let rec uncurry : FStar_Parser_AST.binder Prims.list  ->  FStar_Parser_AST.term  ->  (FStar_Parser_AST.binder Prims.list * FStar_Parser_AST.term) = (fun bs t -> (match (t.FStar_Parser_AST.tm) with
| FStar_Parser_AST.Product (binders, t) -> begin
(uncurry (FStar_List.append bs binders) t)
end
| _64_346 -> begin
((bs), (t))
end))


let rec is_app_pattern : FStar_Parser_AST.pattern  ->  Prims.bool = (fun p -> (match (p.FStar_Parser_AST.pat) with
| FStar_Parser_AST.PatAscribed (p, _64_350) -> begin
(is_app_pattern p)
end
| FStar_Parser_AST.PatApp ({FStar_Parser_AST.pat = FStar_Parser_AST.PatVar (_64_356); FStar_Parser_AST.prange = _64_354}, _64_360) -> begin
true
end
| _64_364 -> begin
false
end))


let rec destruct_app_pattern : FStar_Parser_Env.env  ->  Prims.bool  ->  FStar_Parser_AST.pattern  ->  ((FStar_Ident.ident, FStar_Ident.lident) FStar_Util.either * FStar_Parser_AST.pattern Prims.list * FStar_Parser_AST.term Prims.option) = (fun env is_top_level p -> (match (p.FStar_Parser_AST.pat) with
| FStar_Parser_AST.PatAscribed (p, t) -> begin
(

let _64_376 = (destruct_app_pattern env is_top_level p)
in (match (_64_376) with
| (name, args, _64_375) -> begin
((name), (args), (Some (t)))
end))
end
| FStar_Parser_AST.PatApp ({FStar_Parser_AST.pat = FStar_Parser_AST.PatVar (id, _64_381); FStar_Parser_AST.prange = _64_378}, args) when is_top_level -> begin
(let _156_133 = (let _156_132 = (FStar_Parser_Env.qualify env id)
in FStar_Util.Inr (_156_132))
in ((_156_133), (args), (None)))
end
| FStar_Parser_AST.PatApp ({FStar_Parser_AST.pat = FStar_Parser_AST.PatVar (id, _64_392); FStar_Parser_AST.prange = _64_389}, args) -> begin
((FStar_Util.Inl (id)), (args), (None))
end
| _64_400 -> begin
(FStar_All.failwith "Not an app pattern")
end))


type bnd =
| LocalBinder of (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual)
| LetBinder of (FStar_Ident.lident * FStar_Syntax_Syntax.term)


let is_LocalBinder = (fun _discr_ -> (match (_discr_) with
| LocalBinder (_) -> begin
true
end
| _ -> begin
false
end))


let is_LetBinder = (fun _discr_ -> (match (_discr_) with
| LetBinder (_) -> begin
true
end
| _ -> begin
false
end))


let ___LocalBinder____0 = (fun projectee -> (match (projectee) with
| LocalBinder (_64_403) -> begin
_64_403
end))


let ___LetBinder____0 = (fun projectee -> (match (projectee) with
| LetBinder (_64_406) -> begin
_64_406
end))


let binder_of_bnd : bnd  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) = (fun _64_6 -> (match (_64_6) with
| LocalBinder (a, aq) -> begin
((a), (aq))
end
| _64_413 -> begin
(FStar_All.failwith "Impossible")
end))


let as_binder : FStar_Parser_Env.env  ->  FStar_Parser_AST.arg_qualifier Prims.option  ->  (FStar_Ident.ident Prims.option * FStar_Syntax_Syntax.term)  ->  (FStar_Syntax_Syntax.binder * FStar_Parser_Env.env) = (fun env imp _64_7 -> (match (_64_7) with
| (None, k) -> begin
(let _156_170 = (FStar_Syntax_Syntax.null_binder k)
in ((_156_170), (env)))
end
| (Some (a), k) -> begin
(

let _64_426 = (FStar_Parser_Env.push_bv env a)
in (match (_64_426) with
| (env, a) -> begin
(((((

let _64_427 = a
in {FStar_Syntax_Syntax.ppname = _64_427.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _64_427.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = k})), ((trans_aqual imp)))), (env))
end))
end))


type env_t =
FStar_Parser_Env.env


type lenv_t =
FStar_Syntax_Syntax.bv Prims.list


let mk_lb : (FStar_Syntax_Syntax.lbname * FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.term)  ->  FStar_Syntax_Syntax.letbinding = (fun _64_432 -> (match (_64_432) with
| (n, t, e) -> begin
{FStar_Syntax_Syntax.lbname = n; FStar_Syntax_Syntax.lbunivs = []; FStar_Syntax_Syntax.lbtyp = t; FStar_Syntax_Syntax.lbeff = FStar_Syntax_Const.effect_ALL_lid; FStar_Syntax_Syntax.lbdef = e}
end))


let no_annot_abs : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun bs t -> (FStar_Syntax_Util.abs bs t None))


let mk_ref_read = (fun tm -> (

let tm' = (let _156_183 = (let _156_182 = (let _156_178 = (FStar_Syntax_Syntax.lid_as_fv FStar_Syntax_Const.sread_lid FStar_Syntax_Syntax.Delta_constant None)
in (FStar_Syntax_Syntax.fv_to_tm _156_178))
in (let _156_181 = (let _156_180 = (let _156_179 = (FStar_Syntax_Syntax.as_implicit false)
in ((tm), (_156_179)))
in (_156_180)::[])
in ((_156_182), (_156_181))))
in FStar_Syntax_Syntax.Tm_app (_156_183))
in (FStar_Syntax_Syntax.mk tm' None tm.FStar_Syntax_Syntax.pos)))


let mk_ref_alloc = (fun tm -> (

let tm' = (let _156_190 = (let _156_189 = (let _156_185 = (FStar_Syntax_Syntax.lid_as_fv FStar_Syntax_Const.salloc_lid FStar_Syntax_Syntax.Delta_constant None)
in (FStar_Syntax_Syntax.fv_to_tm _156_185))
in (let _156_188 = (let _156_187 = (let _156_186 = (FStar_Syntax_Syntax.as_implicit false)
in ((tm), (_156_186)))
in (_156_187)::[])
in ((_156_189), (_156_188))))
in FStar_Syntax_Syntax.Tm_app (_156_190))
in (FStar_Syntax_Syntax.mk tm' None tm.FStar_Syntax_Syntax.pos)))


let mk_ref_assign = (fun t1 t2 pos -> (

let tm = (let _156_202 = (let _156_201 = (let _156_194 = (FStar_Syntax_Syntax.lid_as_fv FStar_Syntax_Const.swrite_lid FStar_Syntax_Syntax.Delta_constant None)
in (FStar_Syntax_Syntax.fv_to_tm _156_194))
in (let _156_200 = (let _156_199 = (let _156_195 = (FStar_Syntax_Syntax.as_implicit false)
in ((t1), (_156_195)))
in (let _156_198 = (let _156_197 = (let _156_196 = (FStar_Syntax_Syntax.as_implicit false)
in ((t2), (_156_196)))
in (_156_197)::[])
in (_156_199)::_156_198))
in ((_156_201), (_156_200))))
in FStar_Syntax_Syntax.Tm_app (_156_202))
in (FStar_Syntax_Syntax.mk tm None pos)))


let is_special_effect_combinator : Prims.string  ->  Prims.bool = (fun _64_8 -> (match (_64_8) with
| ("repr") | ("post") | ("pre") | ("wp") -> begin
true
end
| _64_449 -> begin
false
end))


let rec desugar_data_pat : FStar_Parser_Env.env  ->  FStar_Parser_AST.pattern  ->  Prims.bool  ->  (env_t * bnd * FStar_Syntax_Syntax.pat) = (fun env p is_mut -> (

let check_linear_pattern_variables = (fun p -> (

let rec pat_vars = (fun p -> (match (p.FStar_Syntax_Syntax.v) with
| (FStar_Syntax_Syntax.Pat_dot_term (_)) | (FStar_Syntax_Syntax.Pat_wild (_)) | (FStar_Syntax_Syntax.Pat_constant (_)) -> begin
FStar_Syntax_Syntax.no_names
end
| FStar_Syntax_Syntax.Pat_var (x) -> begin
(FStar_Util.set_add x FStar_Syntax_Syntax.no_names)
end
| FStar_Syntax_Syntax.Pat_cons (_64_469, pats) -> begin
(FStar_All.pipe_right pats (FStar_List.fold_left (fun out _64_477 -> (match (_64_477) with
| (p, _64_476) -> begin
(let _156_251 = (pat_vars p)
in (FStar_Util.set_union out _156_251))
end)) FStar_Syntax_Syntax.no_names))
end
| FStar_Syntax_Syntax.Pat_disj ([]) -> begin
(FStar_All.failwith "Impossible")
end
| FStar_Syntax_Syntax.Pat_disj ((hd)::tl) -> begin
(

let xs = (pat_vars hd)
in if (not ((FStar_Util.for_all (fun p -> (

let ys = (pat_vars p)
in ((FStar_Util.set_is_subset_of xs ys) && (FStar_Util.set_is_subset_of ys xs)))) tl))) then begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Disjunctive pattern binds different variables in each case"), (p.FStar_Syntax_Syntax.p)))))
end else begin
xs
end)
end))
in (pat_vars p)))
in (

let _64_500 = (match (((is_mut), (p.FStar_Parser_AST.pat))) with
| ((false, _)) | ((true, FStar_Parser_AST.PatVar (_))) -> begin
()
end
| (true, _64_498) -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("let-mutable is for variables only"), (p.FStar_Parser_AST.prange)))))
end)
in (

let push_bv_maybe_mut = if is_mut then begin
FStar_Parser_Env.push_bv_mutable
end else begin
FStar_Parser_Env.push_bv
end
in (

let resolvex = (fun l e x -> (match ((FStar_All.pipe_right l (FStar_Util.find_opt (fun y -> (y.FStar_Syntax_Syntax.ppname.FStar_Ident.idText = x.FStar_Ident.idText))))) with
| Some (y) -> begin
((l), (e), (y))
end
| _64_511 -> begin
(

let _64_514 = (push_bv_maybe_mut e x)
in (match (_64_514) with
| (e, x) -> begin
(((x)::l), (e), (x))
end))
end))
in (

let resolvea = (fun l e a -> (match ((FStar_All.pipe_right l (FStar_Util.find_opt (fun b -> (b.FStar_Syntax_Syntax.ppname.FStar_Ident.idText = a.FStar_Ident.idText))))) with
| Some (b) -> begin
((l), (e), (b))
end
| _64_523 -> begin
(

let _64_526 = (push_bv_maybe_mut e a)
in (match (_64_526) with
| (e, a) -> begin
(((a)::l), (e), (a))
end))
end))
in (

let rec aux = (fun loc env p -> (

let pos = (fun q -> (FStar_Syntax_Syntax.withinfo q FStar_Syntax_Syntax.tun.FStar_Syntax_Syntax.n p.FStar_Parser_AST.prange))
in (

let pos_r = (fun r q -> (FStar_Syntax_Syntax.withinfo q FStar_Syntax_Syntax.tun.FStar_Syntax_Syntax.n r))
in (match (p.FStar_Parser_AST.pat) with
| FStar_Parser_AST.PatOp (op) -> begin
(let _156_287 = (let _156_286 = (let _156_285 = (let _156_284 = (let _156_283 = (compile_op 0 op)
in (FStar_Ident.id_of_text _156_283))
in ((_156_284), (None)))
in FStar_Parser_AST.PatVar (_156_285))
in {FStar_Parser_AST.pat = _156_286; FStar_Parser_AST.prange = p.FStar_Parser_AST.prange})
in (aux loc env _156_287))
end
| FStar_Parser_AST.PatOr ([]) -> begin
(FStar_All.failwith "impossible")
end
| FStar_Parser_AST.PatOr ((p)::ps) -> begin
(

let _64_550 = (aux loc env p)
in (match (_64_550) with
| (loc, env, var, p, _64_549) -> begin
(

let _64_567 = (FStar_List.fold_left (fun _64_554 p -> (match (_64_554) with
| (loc, env, ps) -> begin
(

let _64_563 = (aux loc env p)
in (match (_64_563) with
| (loc, env, _64_559, p, _64_562) -> begin
((loc), (env), ((p)::ps))
end))
end)) ((loc), (env), ([])) ps)
in (match (_64_567) with
| (loc, env, ps) -> begin
(

let pat = (FStar_All.pipe_left pos (FStar_Syntax_Syntax.Pat_disj ((p)::(FStar_List.rev ps))))
in ((loc), (env), (var), (pat), (false)))
end))
end))
end
| FStar_Parser_AST.PatAscribed (p, t) -> begin
(

let _64_578 = (aux loc env p)
in (match (_64_578) with
| (loc, env', binder, p, imp) -> begin
(

let binder = (match (binder) with
| LetBinder (_64_580) -> begin
(FStar_All.failwith "impossible")
end
| LocalBinder (x, aq) -> begin
(

let t = (let _156_290 = (close_fun env t)
in (desugar_term env _156_290))
in LocalBinder ((((

let _64_587 = x
in {FStar_Syntax_Syntax.ppname = _64_587.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _64_587.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t})), (aq))))
end)
in ((loc), (env'), (binder), (p), (imp)))
end))
end
| FStar_Parser_AST.PatWild -> begin
(

let x = (FStar_Syntax_Syntax.new_bv (Some (p.FStar_Parser_AST.prange)) FStar_Syntax_Syntax.tun)
in (let _156_291 = (FStar_All.pipe_left pos (FStar_Syntax_Syntax.Pat_wild (x)))
in ((loc), (env), (LocalBinder (((x), (None)))), (_156_291), (false))))
end
| FStar_Parser_AST.PatConst (c) -> begin
(

let x = (FStar_Syntax_Syntax.new_bv (Some (p.FStar_Parser_AST.prange)) FStar_Syntax_Syntax.tun)
in (let _156_292 = (FStar_All.pipe_left pos (FStar_Syntax_Syntax.Pat_constant (c)))
in ((loc), (env), (LocalBinder (((x), (None)))), (_156_292), (false))))
end
| (FStar_Parser_AST.PatTvar (x, aq)) | (FStar_Parser_AST.PatVar (x, aq)) -> begin
(

let imp = (aq = Some (FStar_Parser_AST.Implicit))
in (

let aq = (trans_aqual aq)
in (

let _64_606 = (resolvex loc env x)
in (match (_64_606) with
| (loc, env, xbv) -> begin
(let _156_293 = (FStar_All.pipe_left pos (FStar_Syntax_Syntax.Pat_var (xbv)))
in ((loc), (env), (LocalBinder (((xbv), (aq)))), (_156_293), (imp)))
end))))
end
| FStar_Parser_AST.PatName (l) -> begin
(

let l = (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_datacon env) l)
in (

let x = (FStar_Syntax_Syntax.new_bv (Some (p.FStar_Parser_AST.prange)) FStar_Syntax_Syntax.tun)
in (let _156_294 = (FStar_All.pipe_left pos (FStar_Syntax_Syntax.Pat_cons (((l), ([])))))
in ((loc), (env), (LocalBinder (((x), (None)))), (_156_294), (false)))))
end
| FStar_Parser_AST.PatApp ({FStar_Parser_AST.pat = FStar_Parser_AST.PatName (l); FStar_Parser_AST.prange = _64_612}, args) -> begin
(

let _64_634 = (FStar_List.fold_right (fun arg _64_623 -> (match (_64_623) with
| (loc, env, args) -> begin
(

let _64_630 = (aux loc env arg)
in (match (_64_630) with
| (loc, env, _64_627, arg, imp) -> begin
((loc), (env), ((((arg), (imp)))::args))
end))
end)) args ((loc), (env), ([])))
in (match (_64_634) with
| (loc, env, args) -> begin
(

let l = (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_datacon env) l)
in (

let x = (FStar_Syntax_Syntax.new_bv (Some (p.FStar_Parser_AST.prange)) FStar_Syntax_Syntax.tun)
in (let _156_297 = (FStar_All.pipe_left pos (FStar_Syntax_Syntax.Pat_cons (((l), (args)))))
in ((loc), (env), (LocalBinder (((x), (None)))), (_156_297), (false)))))
end))
end
| FStar_Parser_AST.PatApp (_64_638) -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Unexpected pattern"), (p.FStar_Parser_AST.prange)))))
end
| FStar_Parser_AST.PatList (pats) -> begin
(

let _64_658 = (FStar_List.fold_right (fun pat _64_646 -> (match (_64_646) with
| (loc, env, pats) -> begin
(

let _64_654 = (aux loc env pat)
in (match (_64_654) with
| (loc, env, _64_650, pat, _64_653) -> begin
((loc), (env), ((pat)::pats))
end))
end)) pats ((loc), (env), ([])))
in (match (_64_658) with
| (loc, env, pats) -> begin
(

let pat = (let _156_310 = (let _156_309 = (let _156_305 = (FStar_Range.end_range p.FStar_Parser_AST.prange)
in (pos_r _156_305))
in (let _156_308 = (let _156_307 = (let _156_306 = (FStar_Syntax_Syntax.lid_as_fv FStar_Syntax_Const.nil_lid FStar_Syntax_Syntax.Delta_constant (Some (FStar_Syntax_Syntax.Data_ctor)))
in ((_156_306), ([])))
in FStar_Syntax_Syntax.Pat_cons (_156_307))
in (FStar_All.pipe_left _156_309 _156_308)))
in (FStar_List.fold_right (fun hd tl -> (

let r = (FStar_Range.union_ranges hd.FStar_Syntax_Syntax.p tl.FStar_Syntax_Syntax.p)
in (let _156_304 = (let _156_303 = (let _156_302 = (FStar_Syntax_Syntax.lid_as_fv FStar_Syntax_Const.cons_lid FStar_Syntax_Syntax.Delta_constant (Some (FStar_Syntax_Syntax.Data_ctor)))
in ((_156_302), ((((hd), (false)))::(((tl), (false)))::[])))
in FStar_Syntax_Syntax.Pat_cons (_156_303))
in (FStar_All.pipe_left (pos_r r) _156_304)))) pats _156_310))
in (

let x = (FStar_Syntax_Syntax.new_bv (Some (p.FStar_Parser_AST.prange)) FStar_Syntax_Syntax.tun)
in ((loc), (env), (LocalBinder (((x), (None)))), (pat), (false))))
end))
end
| FStar_Parser_AST.PatTuple (args, dep) -> begin
(

let _64_684 = (FStar_List.fold_left (fun _64_671 p -> (match (_64_671) with
| (loc, env, pats) -> begin
(

let _64_680 = (aux loc env p)
in (match (_64_680) with
| (loc, env, _64_676, pat, _64_679) -> begin
((loc), (env), ((((pat), (false)))::pats))
end))
end)) ((loc), (env), ([])) args)
in (match (_64_684) with
| (loc, env, args) -> begin
(

let args = (FStar_List.rev args)
in (

let l = if dep then begin
(FStar_Syntax_Util.mk_dtuple_data_lid (FStar_List.length args) p.FStar_Parser_AST.prange)
end else begin
(FStar_Syntax_Util.mk_tuple_data_lid (FStar_List.length args) p.FStar_Parser_AST.prange)
end
in (

let _64_690 = (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_lid env) l)
in (match (_64_690) with
| (constr, _64_689) -> begin
(

let l = (match (constr.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
fv
end
| _64_694 -> begin
(FStar_All.failwith "impossible")
end)
in (

let x = (FStar_Syntax_Syntax.new_bv (Some (p.FStar_Parser_AST.prange)) FStar_Syntax_Syntax.tun)
in (let _156_313 = (FStar_All.pipe_left pos (FStar_Syntax_Syntax.Pat_cons (((l), (args)))))
in ((loc), (env), (LocalBinder (((x), (None)))), (_156_313), (false)))))
end))))
end))
end
| FStar_Parser_AST.PatRecord ([]) -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Unexpected pattern"), (p.FStar_Parser_AST.prange)))))
end
| FStar_Parser_AST.PatRecord (fields) -> begin
(

let _64_704 = (FStar_List.hd fields)
in (match (_64_704) with
| (f, _64_703) -> begin
(

let _64_708 = (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_record_by_field_name env) f)
in (match (_64_708) with
| (record, _64_707) -> begin
(

let fields = (FStar_All.pipe_right fields (FStar_List.map (fun _64_711 -> (match (_64_711) with
| (f, p) -> begin
(let _156_315 = (FStar_Parser_Env.fail_or env (FStar_Parser_Env.qualify_field_to_record env record) f)
in ((_156_315), (p)))
end))))
in (

let args = (FStar_All.pipe_right record.FStar_Parser_Env.fields (FStar_List.map (fun _64_716 -> (match (_64_716) with
| (f, _64_715) -> begin
(match ((FStar_All.pipe_right fields (FStar_List.tryFind (fun _64_720 -> (match (_64_720) with
| (g, _64_719) -> begin
(FStar_Ident.lid_equals f g)
end))))) with
| None -> begin
(FStar_Parser_AST.mk_pattern FStar_Parser_AST.PatWild p.FStar_Parser_AST.prange)
end
| Some (_64_723, p) -> begin
p
end)
end))))
in (

let app = (FStar_Parser_AST.mk_pattern (FStar_Parser_AST.PatApp ((((FStar_Parser_AST.mk_pattern (FStar_Parser_AST.PatName (record.FStar_Parser_Env.constrname)) p.FStar_Parser_AST.prange)), (args)))) p.FStar_Parser_AST.prange)
in (

let _64_735 = (aux loc env app)
in (match (_64_735) with
| (env, e, b, p, _64_734) -> begin
(

let p = (match (p.FStar_Syntax_Syntax.v) with
| FStar_Syntax_Syntax.Pat_cons (fv, args) -> begin
(let _156_324 = (let _156_323 = (let _156_322 = (

let _64_740 = fv
in (let _156_321 = (let _156_320 = (let _156_319 = (let _156_318 = (FStar_All.pipe_right record.FStar_Parser_Env.fields (FStar_List.map Prims.fst))
in ((record.FStar_Parser_Env.typename), (_156_318)))
in FStar_Syntax_Syntax.Record_ctor (_156_319))
in Some (_156_320))
in {FStar_Syntax_Syntax.fv_name = _64_740.FStar_Syntax_Syntax.fv_name; FStar_Syntax_Syntax.fv_delta = _64_740.FStar_Syntax_Syntax.fv_delta; FStar_Syntax_Syntax.fv_qual = _156_321}))
in ((_156_322), (args)))
in FStar_Syntax_Syntax.Pat_cons (_156_323))
in (FStar_All.pipe_left pos _156_324))
end
| _64_743 -> begin
p
end)
in ((env), (e), (b), (p), (false)))
end)))))
end))
end))
end))))
in (

let _64_752 = (aux [] env p)
in (match (_64_752) with
| (_64_746, env, b, p, _64_751) -> begin
(

let _64_753 = (let _156_325 = (check_linear_pattern_variables p)
in (FStar_All.pipe_left Prims.ignore _156_325))
in ((env), (b), (p)))
end)))))))))
and desugar_binding_pat_maybe_top : Prims.bool  ->  FStar_Parser_Env.env  ->  FStar_Parser_AST.pattern  ->  Prims.bool  ->  (env_t * bnd * FStar_Syntax_Syntax.pat Prims.option) = (fun top env p is_mut -> (

let mklet = (fun x -> (let _156_334 = (let _156_333 = (let _156_332 = (FStar_Parser_Env.qualify env x)
in ((_156_332), (FStar_Syntax_Syntax.tun)))
in LetBinder (_156_333))
in ((env), (_156_334), (None))))
in if top then begin
(match (p.FStar_Parser_AST.pat) with
| FStar_Parser_AST.PatOp (x) -> begin
(let _156_336 = (let _156_335 = (compile_op 0 x)
in (FStar_Ident.id_of_text _156_335))
in (mklet _156_336))
end
| FStar_Parser_AST.PatVar (x, _64_765) -> begin
(mklet x)
end
| FStar_Parser_AST.PatAscribed ({FStar_Parser_AST.pat = FStar_Parser_AST.PatVar (x, _64_772); FStar_Parser_AST.prange = _64_769}, t) -> begin
(let _156_340 = (let _156_339 = (let _156_338 = (FStar_Parser_Env.qualify env x)
in (let _156_337 = (desugar_term env t)
in ((_156_338), (_156_337))))
in LetBinder (_156_339))
in ((env), (_156_340), (None)))
end
| _64_780 -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Unexpected pattern at the top-level"), (p.FStar_Parser_AST.prange)))))
end)
end else begin
(

let _64_784 = (desugar_data_pat env p is_mut)
in (match (_64_784) with
| (env, binder, p) -> begin
(

let p = (match (p.FStar_Syntax_Syntax.v) with
| (FStar_Syntax_Syntax.Pat_var (_)) | (FStar_Syntax_Syntax.Pat_wild (_)) -> begin
None
end
| _64_792 -> begin
Some (p)
end)
in ((env), (binder), (p)))
end))
end))
and desugar_binding_pat : FStar_Parser_Env.env  ->  FStar_Parser_AST.pattern  ->  (env_t * bnd * FStar_Syntax_Syntax.pat Prims.option) = (fun env p -> (desugar_binding_pat_maybe_top false env p false))
and desugar_match_pat_maybe_top : Prims.bool  ->  FStar_Parser_Env.env  ->  FStar_Parser_AST.pattern  ->  (env_t * FStar_Syntax_Syntax.pat) = (fun _64_796 env pat -> (

let _64_804 = (desugar_data_pat env pat false)
in (match (_64_804) with
| (env, _64_802, pat) -> begin
((env), (pat))
end)))
and desugar_match_pat : FStar_Parser_Env.env  ->  FStar_Parser_AST.pattern  ->  (env_t * FStar_Syntax_Syntax.pat) = (fun env p -> (desugar_match_pat_maybe_top false env p))
and desugar_term : FStar_Parser_Env.env  ->  FStar_Parser_AST.term  ->  FStar_Syntax_Syntax.term = (fun env e -> (

let env = (

let _64_809 = env
in {FStar_Parser_Env.curmodule = _64_809.FStar_Parser_Env.curmodule; FStar_Parser_Env.modules = _64_809.FStar_Parser_Env.modules; FStar_Parser_Env.open_namespaces = _64_809.FStar_Parser_Env.open_namespaces; FStar_Parser_Env.modul_abbrevs = _64_809.FStar_Parser_Env.modul_abbrevs; FStar_Parser_Env.sigaccum = _64_809.FStar_Parser_Env.sigaccum; FStar_Parser_Env.localbindings = _64_809.FStar_Parser_Env.localbindings; FStar_Parser_Env.recbindings = _64_809.FStar_Parser_Env.recbindings; FStar_Parser_Env.sigmap = _64_809.FStar_Parser_Env.sigmap; FStar_Parser_Env.default_result_effect = _64_809.FStar_Parser_Env.default_result_effect; FStar_Parser_Env.iface = _64_809.FStar_Parser_Env.iface; FStar_Parser_Env.admitted_iface = _64_809.FStar_Parser_Env.admitted_iface; FStar_Parser_Env.expect_typ = false})
in (desugar_term_maybe_top false env e)))
and desugar_typ : FStar_Parser_Env.env  ->  FStar_Parser_AST.term  ->  FStar_Syntax_Syntax.term = (fun env e -> (

let env = (

let _64_814 = env
in {FStar_Parser_Env.curmodule = _64_814.FStar_Parser_Env.curmodule; FStar_Parser_Env.modules = _64_814.FStar_Parser_Env.modules; FStar_Parser_Env.open_namespaces = _64_814.FStar_Parser_Env.open_namespaces; FStar_Parser_Env.modul_abbrevs = _64_814.FStar_Parser_Env.modul_abbrevs; FStar_Parser_Env.sigaccum = _64_814.FStar_Parser_Env.sigaccum; FStar_Parser_Env.localbindings = _64_814.FStar_Parser_Env.localbindings; FStar_Parser_Env.recbindings = _64_814.FStar_Parser_Env.recbindings; FStar_Parser_Env.sigmap = _64_814.FStar_Parser_Env.sigmap; FStar_Parser_Env.default_result_effect = _64_814.FStar_Parser_Env.default_result_effect; FStar_Parser_Env.iface = _64_814.FStar_Parser_Env.iface; FStar_Parser_Env.admitted_iface = _64_814.FStar_Parser_Env.admitted_iface; FStar_Parser_Env.expect_typ = true})
in (desugar_term_maybe_top false env e)))
and desugar_machine_integer : FStar_Parser_Env.env  ->  Prims.string  ->  (FStar_Const.signedness * FStar_Const.width)  ->  FStar_Range.range  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (fun env repr _64_821 range -> (match (_64_821) with
| (signedness, width) -> begin
(

let lid = (Prims.strcat "FStar." (Prims.strcat (match (signedness) with
| FStar_Const.Unsigned -> begin
"U"
end
| FStar_Const.Signed -> begin
""
end) (Prims.strcat "Int" (Prims.strcat (match (width) with
| FStar_Const.Int8 -> begin
"8"
end
| FStar_Const.Int16 -> begin
"16"
end
| FStar_Const.Int32 -> begin
"32"
end
| FStar_Const.Int64 -> begin
"64"
end) (Prims.strcat "." (Prims.strcat (match (signedness) with
| FStar_Const.Unsigned -> begin
"u"
end
| FStar_Const.Signed -> begin
""
end) "int_to_t"))))))
in (

let lid = (FStar_Ident.lid_of_path (FStar_Ident.path_of_text lid) range)
in (

let lid = (match ((FStar_Parser_Env.try_lookup_lid env lid)) with
| Some (lid) -> begin
(Prims.fst lid)
end
| None -> begin
(let _156_356 = (FStar_Util.format1 "%s not in scope\n" (FStar_Ident.text_of_lid lid))
in (FStar_All.failwith _156_356))
end)
in (

let repr = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_int (((repr), (None))))) None range)
in (let _156_361 = (let _156_360 = (let _156_359 = (let _156_358 = (let _156_357 = (FStar_Syntax_Syntax.as_implicit false)
in ((repr), (_156_357)))
in (_156_358)::[])
in ((lid), (_156_359)))
in FStar_Syntax_Syntax.Tm_app (_156_360))
in (FStar_Syntax_Syntax.mk _156_361 None range))))))
end))
and desugar_term_maybe_top : Prims.bool  ->  env_t  ->  FStar_Parser_AST.term  ->  FStar_Syntax_Syntax.term = (fun top_level env top -> (

let mk = (fun e -> (FStar_Syntax_Syntax.mk e None top.FStar_Parser_AST.range))
in (

let setpos = (fun e -> (

let _64_845 = e
in {FStar_Syntax_Syntax.n = _64_845.FStar_Syntax_Syntax.n; FStar_Syntax_Syntax.tk = _64_845.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = top.FStar_Parser_AST.range; FStar_Syntax_Syntax.vars = _64_845.FStar_Syntax_Syntax.vars}))
in (match ((let _156_369 = (unparen top)
in _156_369.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.Wild -> begin
(setpos FStar_Syntax_Syntax.tun)
end
| FStar_Parser_AST.Labeled (_64_849) -> begin
(desugar_formula env top)
end
| FStar_Parser_AST.Requires (t, lopt) -> begin
(desugar_formula env t)
end
| FStar_Parser_AST.Ensures (t, lopt) -> begin
(desugar_formula env t)
end
| FStar_Parser_AST.Const (FStar_Const.Const_int (i, Some (size))) -> begin
(desugar_machine_integer env i size top.FStar_Parser_AST.range)
end
| FStar_Parser_AST.Const (c) -> begin
(mk (FStar_Syntax_Syntax.Tm_constant (c)))
end
| FStar_Parser_AST.Op ("=!=", args) -> begin
(desugar_term env (FStar_Parser_AST.mk_term (FStar_Parser_AST.Op ((("~"), (((FStar_Parser_AST.mk_term (FStar_Parser_AST.Op ((("=="), (args)))) top.FStar_Parser_AST.range top.FStar_Parser_AST.level))::[])))) top.FStar_Parser_AST.range top.FStar_Parser_AST.level))
end
| FStar_Parser_AST.Op ("*", (_64_875)::(_64_873)::[]) when (let _156_370 = (op_as_term env 2 top.FStar_Parser_AST.range "*")
in (FStar_All.pipe_right _156_370 FStar_Option.isNone)) -> begin
(

let rec flatten = (fun t -> (match (t.FStar_Parser_AST.tm) with
| FStar_Parser_AST.Op ("*", (t1)::(t2)::[]) -> begin
(let _156_373 = (flatten t1)
in (FStar_List.append _156_373 ((t2)::[])))
end
| _64_888 -> begin
(t)::[]
end))
in (

let targs = (let _156_377 = (let _156_374 = (unparen top)
in (flatten _156_374))
in (FStar_All.pipe_right _156_377 (FStar_List.map (fun t -> (let _156_376 = (desugar_typ env t)
in (FStar_Syntax_Syntax.as_arg _156_376))))))
in (

let _64_894 = (let _156_378 = (FStar_Syntax_Util.mk_tuple_lid (FStar_List.length targs) top.FStar_Parser_AST.range)
in (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_lid env) _156_378))
in (match (_64_894) with
| (tup, _64_893) -> begin
(mk (FStar_Syntax_Syntax.Tm_app (((tup), (targs)))))
end))))
end
| FStar_Parser_AST.Tvar (a) -> begin
(let _156_380 = (let _156_379 = (FStar_Parser_Env.fail_or2 (FStar_Parser_Env.try_lookup_id env) a)
in (Prims.fst _156_379))
in (FStar_All.pipe_left setpos _156_380))
end
| FStar_Parser_AST.Op (s, args) -> begin
(match ((op_as_term env (FStar_List.length args) top.FStar_Parser_AST.range s)) with
| None -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((((Prims.strcat "Unexpected or unbound operator: " s)), (top.FStar_Parser_AST.range)))))
end
| Some (op) -> begin
if ((FStar_List.length args) > 0) then begin
(

let args = (FStar_All.pipe_right args (FStar_List.map (fun t -> (let _156_382 = (desugar_term env t)
in ((_156_382), (None))))))
in (mk (FStar_Syntax_Syntax.Tm_app (((op), (args))))))
end else begin
op
end
end)
end
| FStar_Parser_AST.Name ({FStar_Ident.ns = _64_912; FStar_Ident.ident = _64_910; FStar_Ident.nsstr = _64_908; FStar_Ident.str = "Type0"}) -> begin
(mk (FStar_Syntax_Syntax.Tm_type (FStar_Syntax_Syntax.U_zero)))
end
| FStar_Parser_AST.Name ({FStar_Ident.ns = _64_921; FStar_Ident.ident = _64_919; FStar_Ident.nsstr = _64_917; FStar_Ident.str = "Type"}) -> begin
(mk (FStar_Syntax_Syntax.Tm_type (FStar_Syntax_Syntax.U_unknown)))
end
| FStar_Parser_AST.Name ({FStar_Ident.ns = _64_930; FStar_Ident.ident = _64_928; FStar_Ident.nsstr = _64_926; FStar_Ident.str = "Effect"}) -> begin
(mk (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_effect)))
end
| FStar_Parser_AST.Name ({FStar_Ident.ns = _64_939; FStar_Ident.ident = _64_937; FStar_Ident.nsstr = _64_935; FStar_Ident.str = "True"}) -> begin
(let _156_383 = (FStar_Ident.set_lid_range FStar_Syntax_Const.true_lid top.FStar_Parser_AST.range)
in (FStar_Syntax_Syntax.fvar _156_383 FStar_Syntax_Syntax.Delta_constant None))
end
| FStar_Parser_AST.Name ({FStar_Ident.ns = _64_948; FStar_Ident.ident = _64_946; FStar_Ident.nsstr = _64_944; FStar_Ident.str = "False"}) -> begin
(let _156_384 = (FStar_Ident.set_lid_range FStar_Syntax_Const.false_lid top.FStar_Parser_AST.range)
in (FStar_Syntax_Syntax.fvar _156_384 FStar_Syntax_Syntax.Delta_constant None))
end
| FStar_Parser_AST.Var ({FStar_Ident.ns = (eff)::rest; FStar_Ident.ident = {FStar_Ident.idText = txt; FStar_Ident.idRange = _64_956}; FStar_Ident.nsstr = _64_954; FStar_Ident.str = _64_952}) when ((is_special_effect_combinator txt) && (let _156_385 = (FStar_Ident.lid_of_ids ((eff)::rest))
in (FStar_Parser_Env.is_effect_name env _156_385))) -> begin
(match ((let _156_386 = (FStar_Ident.lid_of_ids ((eff)::rest))
in (FStar_Parser_Env.try_lookup_effect_defn env _156_386))) with
| Some (ed) -> begin
(let _156_387 = (FStar_Ident.lid_of_path (FStar_Ident.path_of_text (Prims.strcat (FStar_Ident.text_of_lid ed.FStar_Syntax_Syntax.mname) (Prims.strcat "_" txt))) FStar_Range.dummyRange)
in (FStar_Syntax_Syntax.fvar _156_387 (FStar_Syntax_Syntax.Delta_unfoldable (1)) None))
end
| None -> begin
(FStar_All.failwith "immpossible special_effect_combinator")
end)
end
| FStar_Parser_AST.Assign (ident, t2) -> begin
(

let t2 = (desugar_term env t2)
in (

let _64_974 = (FStar_Parser_Env.fail_or2 (FStar_Parser_Env.try_lookup_id env) ident)
in (match (_64_974) with
| (t1, mut) -> begin
(

let _64_975 = if (not (mut)) then begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Can only assign to mutable values"), (top.FStar_Parser_AST.range)))))
end else begin
()
end
in (mk_ref_assign t1 t2 top.FStar_Parser_AST.range))
end)))
end
| (FStar_Parser_AST.Var (l)) | (FStar_Parser_AST.Name (l)) -> begin
(

let _64_982 = (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_lid env) l)
in (match (_64_982) with
| (tm, mut) -> begin
(

let tm = (setpos tm)
in if mut then begin
(let _156_390 = (let _156_389 = (let _156_388 = (mk_ref_read tm)
in ((_156_388), (FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Mutable_rval))))
in FStar_Syntax_Syntax.Tm_meta (_156_389))
in (FStar_All.pipe_left mk _156_390))
end else begin
tm
end)
end))
end
| FStar_Parser_AST.Construct (l, args) -> begin
(match ((FStar_Parser_Env.try_lookup_datacon env l)) with
| Some (head) -> begin
(

let _64_992 = (let _156_391 = (mk (FStar_Syntax_Syntax.Tm_fvar (head)))
in ((_156_391), (true)))
in (match (_64_992) with
| (head, is_data) -> begin
(match (args) with
| [] -> begin
head
end
| _64_995 -> begin
(

let args = (FStar_List.map (fun _64_998 -> (match (_64_998) with
| (t, imp) -> begin
(

let te = (desugar_term env t)
in (arg_withimp_e imp te))
end)) args)
in (

let app = (mk (FStar_Syntax_Syntax.Tm_app (((head), (args)))))
in if is_data then begin
(mk (FStar_Syntax_Syntax.Tm_meta (((app), (FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Data_app))))))
end else begin
app
end))
end)
end))
end
| None -> begin
(

let l = (FStar_Parser_Env.expand_module_abbrev env l)
in (

let env = (FStar_Parser_Env.push_namespace env l)
in (match (args) with
| ((e, _64_1007))::[] -> begin
(desugar_term_maybe_top top_level env e)
end
| _64_1011 -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("The Foo.Bar (...) local open takes exactly one argument"), (top.FStar_Parser_AST.range)))))
end)))
end)
end
| FStar_Parser_AST.Sum (binders, t) -> begin
(

let _64_1036 = (FStar_List.fold_left (fun _64_1019 b -> (match (_64_1019) with
| (env, tparams, typs) -> begin
(

let _64_1023 = (desugar_binder env b)
in (match (_64_1023) with
| (xopt, t) -> begin
(

let _64_1029 = (match (xopt) with
| None -> begin
(let _156_395 = (FStar_Syntax_Syntax.new_bv (Some (top.FStar_Parser_AST.range)) FStar_Syntax_Syntax.tun)
in ((env), (_156_395)))
end
| Some (x) -> begin
(FStar_Parser_Env.push_bv env x)
end)
in (match (_64_1029) with
| (env, x) -> begin
(let _156_399 = (let _156_398 = (let _156_397 = (let _156_396 = (no_annot_abs tparams t)
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _156_396))
in (_156_397)::[])
in (FStar_List.append typs _156_398))
in ((env), ((FStar_List.append tparams (((((

let _64_1030 = x
in {FStar_Syntax_Syntax.ppname = _64_1030.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _64_1030.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t})), (None)))::[]))), (_156_399)))
end))
end))
end)) ((env), ([]), ([])) (FStar_List.append binders (((FStar_Parser_AST.mk_binder (FStar_Parser_AST.NoName (t)) t.FStar_Parser_AST.range FStar_Parser_AST.Type None))::[])))
in (match (_64_1036) with
| (env, _64_1034, targs) -> begin
(

let _64_1040 = (let _156_400 = (FStar_Syntax_Util.mk_dtuple_lid (FStar_List.length targs) top.FStar_Parser_AST.range)
in (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_lid env) _156_400))
in (match (_64_1040) with
| (tup, _64_1039) -> begin
(FStar_All.pipe_left mk (FStar_Syntax_Syntax.Tm_app (((tup), (targs)))))
end))
end))
end
| FStar_Parser_AST.Product (binders, t) -> begin
(

let _64_1047 = (uncurry binders t)
in (match (_64_1047) with
| (bs, t) -> begin
(

let rec aux = (fun env bs _64_9 -> (match (_64_9) with
| [] -> begin
(

let cod = (desugar_comp top.FStar_Parser_AST.range true env t)
in (let _156_407 = (FStar_Syntax_Util.arrow (FStar_List.rev bs) cod)
in (FStar_All.pipe_left setpos _156_407)))
end
| (hd)::tl -> begin
(

let mlenv = (FStar_Parser_Env.default_ml env)
in (

let bb = (desugar_binder mlenv hd)
in (

let _64_1061 = (as_binder env hd.FStar_Parser_AST.aqual bb)
in (match (_64_1061) with
| (b, env) -> begin
(aux env ((b)::bs) tl)
end))))
end))
in (aux env [] bs))
end))
end
| FStar_Parser_AST.Refine (b, f) -> begin
(match ((desugar_binder env b)) with
| (None, _64_1068) -> begin
(FStar_All.failwith "Missing binder in refinement")
end
| b -> begin
(

let _64_1076 = (as_binder env None b)
in (match (_64_1076) with
| ((x, _64_1073), env) -> begin
(

let f = (desugar_formula env f)
in (let _156_408 = (FStar_Syntax_Util.refine x f)
in (FStar_All.pipe_left setpos _156_408)))
end))
end)
end
| FStar_Parser_AST.Abs (binders, body) -> begin
(

let _64_1096 = (FStar_List.fold_left (fun _64_1084 pat -> (match (_64_1084) with
| (env, ftvs) -> begin
(match (pat.FStar_Parser_AST.pat) with
| FStar_Parser_AST.PatAscribed (_64_1087, t) -> begin
(let _156_412 = (let _156_411 = (free_type_vars env t)
in (FStar_List.append _156_411 ftvs))
in ((env), (_156_412)))
end
| _64_1092 -> begin
((env), (ftvs))
end)
end)) ((env), ([])) binders)
in (match (_64_1096) with
| (_64_1094, ftv) -> begin
(

let ftv = (sort_ftv ftv)
in (

let binders = (let _156_414 = (FStar_All.pipe_right ftv (FStar_List.map (fun a -> (FStar_Parser_AST.mk_pattern (FStar_Parser_AST.PatTvar (((a), (Some (FStar_Parser_AST.Implicit))))) top.FStar_Parser_AST.range))))
in (FStar_List.append _156_414 binders))
in (

let rec aux = (fun env bs sc_pat_opt _64_10 -> (match (_64_10) with
| [] -> begin
(

let body = (desugar_term env body)
in (

let body = (match (sc_pat_opt) with
| Some (sc, pat) -> begin
(

let body = (let _156_424 = (let _156_423 = (FStar_Syntax_Syntax.pat_bvs pat)
in (FStar_All.pipe_right _156_423 (FStar_List.map FStar_Syntax_Syntax.mk_binder)))
in (FStar_Syntax_Subst.close _156_424 body))
in (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_match (((sc), ((((pat), (None), (body)))::[])))) None body.FStar_Syntax_Syntax.pos))
end
| None -> begin
body
end)
in (let _156_425 = (no_annot_abs (FStar_List.rev bs) body)
in (setpos _156_425))))
end
| (p)::rest -> begin
(

let _64_1120 = (desugar_binding_pat env p)
in (match (_64_1120) with
| (env, b, pat) -> begin
(

let _64_1171 = (match (b) with
| LetBinder (_64_1122) -> begin
(FStar_All.failwith "Impossible")
end
| LocalBinder (x, aq) -> begin
(

let sc_pat_opt = (match (((pat), (sc_pat_opt))) with
| (None, _64_1130) -> begin
sc_pat_opt
end
| (Some (p), None) -> begin
(let _156_427 = (let _156_426 = (FStar_Syntax_Syntax.bv_to_name x)
in ((_156_426), (p)))
in Some (_156_427))
end
| (Some (p), Some (sc, p')) -> begin
(match (((sc.FStar_Syntax_Syntax.n), (p'.FStar_Syntax_Syntax.v))) with
| (FStar_Syntax_Syntax.Tm_name (_64_1144), _64_1147) -> begin
(

let tup2 = (let _156_428 = (FStar_Syntax_Util.mk_tuple_data_lid 2 top.FStar_Parser_AST.range)
in (FStar_Syntax_Syntax.lid_as_fv _156_428 FStar_Syntax_Syntax.Delta_constant (Some (FStar_Syntax_Syntax.Data_ctor))))
in (

let sc = (let _156_436 = (let _156_435 = (let _156_434 = (mk (FStar_Syntax_Syntax.Tm_fvar (tup2)))
in (let _156_433 = (let _156_432 = (FStar_Syntax_Syntax.as_arg sc)
in (let _156_431 = (let _156_430 = (let _156_429 = (FStar_Syntax_Syntax.bv_to_name x)
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _156_429))
in (_156_430)::[])
in (_156_432)::_156_431))
in ((_156_434), (_156_433))))
in FStar_Syntax_Syntax.Tm_app (_156_435))
in (FStar_Syntax_Syntax.mk _156_436 None top.FStar_Parser_AST.range))
in (

let p = (let _156_437 = (FStar_Range.union_ranges p'.FStar_Syntax_Syntax.p p.FStar_Syntax_Syntax.p)
in (FStar_Syntax_Syntax.withinfo (FStar_Syntax_Syntax.Pat_cons (((tup2), ((((p'), (false)))::(((p), (false)))::[])))) FStar_Syntax_Syntax.tun.FStar_Syntax_Syntax.n _156_437))
in Some (((sc), (p))))))
end
| (FStar_Syntax_Syntax.Tm_app (_64_1153, args), FStar_Syntax_Syntax.Pat_cons (_64_1158, pats)) -> begin
(

let tupn = (let _156_438 = (FStar_Syntax_Util.mk_tuple_data_lid (1 + (FStar_List.length args)) top.FStar_Parser_AST.range)
in (FStar_Syntax_Syntax.lid_as_fv _156_438 FStar_Syntax_Syntax.Delta_constant (Some (FStar_Syntax_Syntax.Data_ctor))))
in (

let sc = (let _156_445 = (let _156_444 = (let _156_443 = (mk (FStar_Syntax_Syntax.Tm_fvar (tupn)))
in (let _156_442 = (let _156_441 = (let _156_440 = (let _156_439 = (FStar_Syntax_Syntax.bv_to_name x)
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _156_439))
in (_156_440)::[])
in (FStar_List.append args _156_441))
in ((_156_443), (_156_442))))
in FStar_Syntax_Syntax.Tm_app (_156_444))
in (mk _156_445))
in (

let p = (let _156_446 = (FStar_Range.union_ranges p'.FStar_Syntax_Syntax.p p.FStar_Syntax_Syntax.p)
in (FStar_Syntax_Syntax.withinfo (FStar_Syntax_Syntax.Pat_cons (((tupn), ((FStar_List.append pats ((((p), (false)))::[])))))) FStar_Syntax_Syntax.tun.FStar_Syntax_Syntax.n _156_446))
in Some (((sc), (p))))))
end
| _64_1167 -> begin
(FStar_All.failwith "Impossible")
end)
end)
in ((((x), (aq))), (sc_pat_opt)))
end)
in (match (_64_1171) with
| (b, sc_pat_opt) -> begin
(aux env ((b)::bs) sc_pat_opt rest)
end))
end))
end))
in (aux env [] None binders))))
end))
end
| FStar_Parser_AST.App ({FStar_Parser_AST.tm = FStar_Parser_AST.Var (a); FStar_Parser_AST.range = _64_1175; FStar_Parser_AST.level = _64_1173}, phi, _64_1181) when ((FStar_Ident.lid_equals a FStar_Syntax_Const.assert_lid) || (FStar_Ident.lid_equals a FStar_Syntax_Const.assume_lid)) -> begin
(

let phi = (desugar_formula env phi)
in (let _156_454 = (let _156_453 = (let _156_452 = (FStar_Syntax_Syntax.fvar a FStar_Syntax_Syntax.Delta_equational None)
in (let _156_451 = (let _156_450 = (FStar_Syntax_Syntax.as_arg phi)
in (let _156_449 = (let _156_448 = (let _156_447 = (mk (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_unit)))
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _156_447))
in (_156_448)::[])
in (_156_450)::_156_449))
in ((_156_452), (_156_451))))
in FStar_Syntax_Syntax.Tm_app (_156_453))
in (mk _156_454)))
end
| FStar_Parser_AST.App (_64_1186) -> begin
(

let rec aux = (fun args e -> (match ((let _156_459 = (unparen e)
in _156_459.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.App (e, t, imp) -> begin
(

let arg = (let _156_460 = (desugar_term env t)
in (FStar_All.pipe_left (arg_withimp_e imp) _156_460))
in (aux ((arg)::args) e))
end
| _64_1198 -> begin
(

let head = (desugar_term env e)
in (mk (FStar_Syntax_Syntax.Tm_app (((head), (args))))))
end))
in (aux [] top))
end
| FStar_Parser_AST.Seq (t1, t2) -> begin
(let _156_463 = (let _156_462 = (let _156_461 = (desugar_term env (FStar_Parser_AST.mk_term (FStar_Parser_AST.Let (((FStar_Parser_AST.NoLetQualifier), (((((FStar_Parser_AST.mk_pattern FStar_Parser_AST.PatWild t1.FStar_Parser_AST.range)), (t1)))::[]), (t2)))) top.FStar_Parser_AST.range FStar_Parser_AST.Expr))
in ((_156_461), (FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Sequence))))
in FStar_Syntax_Syntax.Tm_meta (_156_462))
in (mk _156_463))
end
| FStar_Parser_AST.LetOpen (lid, e) -> begin
(

let lid = (FStar_Parser_Env.expand_module_abbrev env lid)
in (

let env = (FStar_Parser_Env.push_namespace env lid)
in (desugar_term_maybe_top top_level env e)))
end
| FStar_Parser_AST.Let (qual, ((pat, _snd))::_tl, body) -> begin
(

let is_rec = (qual = FStar_Parser_AST.Rec)
in (

let ds_let_rec_or_app = (fun _64_1221 -> (match (()) with
| () -> begin
(

let bindings = (((pat), (_snd)))::_tl
in (

let funs = (FStar_All.pipe_right bindings (FStar_List.map (fun _64_1225 -> (match (_64_1225) with
| (p, def) -> begin
if (is_app_pattern p) then begin
(let _156_467 = (destruct_app_pattern env top_level p)
in ((_156_467), (def)))
end else begin
(match ((FStar_Parser_AST.un_function p def)) with
| Some (p, def) -> begin
(let _156_468 = (destruct_app_pattern env top_level p)
in ((_156_468), (def)))
end
| _64_1231 -> begin
(match (p.FStar_Parser_AST.pat) with
| FStar_Parser_AST.PatAscribed ({FStar_Parser_AST.pat = FStar_Parser_AST.PatVar (id, _64_1236); FStar_Parser_AST.prange = _64_1233}, t) -> begin
if top_level then begin
(let _156_471 = (let _156_470 = (let _156_469 = (FStar_Parser_Env.qualify env id)
in FStar_Util.Inr (_156_469))
in ((_156_470), ([]), (Some (t))))
in ((_156_471), (def)))
end else begin
((((FStar_Util.Inl (id)), ([]), (Some (t)))), (def))
end
end
| FStar_Parser_AST.PatVar (id, _64_1245) -> begin
if top_level then begin
(let _156_474 = (let _156_473 = (let _156_472 = (FStar_Parser_Env.qualify env id)
in FStar_Util.Inr (_156_472))
in ((_156_473), ([]), (None)))
in ((_156_474), (def)))
end else begin
((((FStar_Util.Inl (id)), ([]), (None))), (def))
end
end
| _64_1249 -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Unexpected let binding"), (p.FStar_Parser_AST.prange)))))
end)
end)
end
end))))
in (

let _64_1278 = (FStar_List.fold_left (fun _64_1254 _64_1263 -> (match (((_64_1254), (_64_1263))) with
| ((env, fnames, rec_bindings), ((f, _64_1257, _64_1259), _64_1262)) -> begin
(

let _64_1274 = (match (f) with
| FStar_Util.Inl (x) -> begin
(

let _64_1268 = (FStar_Parser_Env.push_bv env x)
in (match (_64_1268) with
| (env, xx) -> begin
(let _156_478 = (let _156_477 = (FStar_Syntax_Syntax.mk_binder xx)
in (_156_477)::rec_bindings)
in ((env), (FStar_Util.Inl (xx)), (_156_478)))
end))
end
| FStar_Util.Inr (l) -> begin
(let _156_479 = (FStar_Parser_Env.push_top_level_rec_binding env l.FStar_Ident.ident FStar_Syntax_Syntax.Delta_equational)
in ((_156_479), (FStar_Util.Inr (l)), (rec_bindings)))
end)
in (match (_64_1274) with
| (env, lbname, rec_bindings) -> begin
((env), ((lbname)::fnames), (rec_bindings))
end))
end)) ((env), ([]), ([])) funs)
in (match (_64_1278) with
| (env', fnames, rec_bindings) -> begin
(

let fnames = (FStar_List.rev fnames)
in (

let desugar_one_def = (fun env lbname _64_1289 -> (match (_64_1289) with
| ((_64_1284, args, result_t), def) -> begin
(

let def = (match (result_t) with
| None -> begin
def
end
| Some (t) -> begin
(let _156_486 = (FStar_Range.union_ranges t.FStar_Parser_AST.range def.FStar_Parser_AST.range)
in (FStar_Parser_AST.mk_term (FStar_Parser_AST.Ascribed (((def), (t)))) _156_486 FStar_Parser_AST.Expr))
end)
in (

let def = (match (args) with
| [] -> begin
def
end
| _64_1296 -> begin
(FStar_Parser_AST.mk_term (FStar_Parser_AST.un_curry_abs args def) top.FStar_Parser_AST.range top.FStar_Parser_AST.level)
end)
in (

let body = (desugar_term env def)
in (

let lbname = (match (lbname) with
| FStar_Util.Inl (x) -> begin
FStar_Util.Inl (x)
end
| FStar_Util.Inr (l) -> begin
(let _156_488 = (let _156_487 = (FStar_Syntax_Util.incr_delta_qualifier body)
in (FStar_Syntax_Syntax.lid_as_fv l _156_487 None))
in FStar_Util.Inr (_156_488))
end)
in (

let body = if is_rec then begin
(FStar_Syntax_Subst.close rec_bindings body)
end else begin
body
end
in (mk_lb ((lbname), (FStar_Syntax_Syntax.tun), (body))))))))
end))
in (

let lbs = (FStar_List.map2 (desugar_one_def (if is_rec then begin
env'
end else begin
env
end)) fnames funs)
in (

let body = (desugar_term env' body)
in (let _156_491 = (let _156_490 = (let _156_489 = (FStar_Syntax_Subst.close rec_bindings body)
in ((((is_rec), (lbs))), (_156_489)))
in FStar_Syntax_Syntax.Tm_let (_156_490))
in (FStar_All.pipe_left mk _156_491))))))
end))))
end))
in (

let ds_non_rec = (fun pat t1 t2 -> (

let t1 = (desugar_term env t1)
in (

let is_mutable = (qual = FStar_Parser_AST.Mutable)
in (

let t1 = if is_mutable then begin
(mk_ref_alloc t1)
end else begin
t1
end
in (

let _64_1317 = (desugar_binding_pat_maybe_top top_level env pat is_mutable)
in (match (_64_1317) with
| (env, binder, pat) -> begin
(

let tm = (match (binder) with
| LetBinder (l, t) -> begin
(

let body = (desugar_term env t2)
in (

let fv = (let _156_498 = (FStar_Syntax_Util.incr_delta_qualifier t1)
in (FStar_Syntax_Syntax.lid_as_fv l _156_498 None))
in (FStar_All.pipe_left mk (FStar_Syntax_Syntax.Tm_let (((((false), (({FStar_Syntax_Syntax.lbname = FStar_Util.Inr (fv); FStar_Syntax_Syntax.lbunivs = []; FStar_Syntax_Syntax.lbtyp = t; FStar_Syntax_Syntax.lbeff = FStar_Syntax_Const.effect_ALL_lid; FStar_Syntax_Syntax.lbdef = t1})::[]))), (body)))))))
end
| LocalBinder (x, _64_1326) -> begin
(

let body = (desugar_term env t2)
in (

let body = (match (pat) with
| (None) | (Some ({FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_wild (_); FStar_Syntax_Syntax.ty = _; FStar_Syntax_Syntax.p = _})) -> begin
body
end
| Some (pat) -> begin
(let _156_503 = (let _156_502 = (let _156_501 = (FStar_Syntax_Syntax.bv_to_name x)
in (let _156_500 = (let _156_499 = (FStar_Syntax_Util.branch ((pat), (None), (body)))
in (_156_499)::[])
in ((_156_501), (_156_500))))
in FStar_Syntax_Syntax.Tm_match (_156_502))
in (FStar_Syntax_Syntax.mk _156_503 None body.FStar_Syntax_Syntax.pos))
end)
in (let _156_508 = (let _156_507 = (let _156_506 = (let _156_505 = (let _156_504 = (FStar_Syntax_Syntax.mk_binder x)
in (_156_504)::[])
in (FStar_Syntax_Subst.close _156_505 body))
in ((((false), (((mk_lb ((FStar_Util.Inl (x)), (x.FStar_Syntax_Syntax.sort), (t1))))::[]))), (_156_506)))
in FStar_Syntax_Syntax.Tm_let (_156_507))
in (FStar_All.pipe_left mk _156_508))))
end)
in if is_mutable then begin
(FStar_All.pipe_left mk (FStar_Syntax_Syntax.Tm_meta (((tm), (FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Mutable_alloc))))))
end else begin
tm
end)
end))))))
in if (is_rec || (is_app_pattern pat)) then begin
(ds_let_rec_or_app ())
end else begin
(ds_non_rec pat _snd body)
end)))
end
| FStar_Parser_AST.If (t1, t2, t3) -> begin
(

let x = (FStar_Syntax_Syntax.new_bv (Some (t3.FStar_Parser_AST.range)) FStar_Syntax_Syntax.tun)
in (let _156_519 = (let _156_518 = (let _156_517 = (desugar_term env t1)
in (let _156_516 = (let _156_515 = (let _156_510 = (FStar_Syntax_Syntax.withinfo (FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_bool (true))) FStar_Syntax_Syntax.tun.FStar_Syntax_Syntax.n t2.FStar_Parser_AST.range)
in (let _156_509 = (desugar_term env t2)
in ((_156_510), (None), (_156_509))))
in (let _156_514 = (let _156_513 = (let _156_512 = (FStar_Syntax_Syntax.withinfo (FStar_Syntax_Syntax.Pat_wild (x)) FStar_Syntax_Syntax.tun.FStar_Syntax_Syntax.n t3.FStar_Parser_AST.range)
in (let _156_511 = (desugar_term env t3)
in ((_156_512), (None), (_156_511))))
in (_156_513)::[])
in (_156_515)::_156_514))
in ((_156_517), (_156_516))))
in FStar_Syntax_Syntax.Tm_match (_156_518))
in (mk _156_519)))
end
| FStar_Parser_AST.TryWith (e, branches) -> begin
(

let r = top.FStar_Parser_AST.range
in (

let handler = (FStar_Parser_AST.mk_function branches r r)
in (

let body = (FStar_Parser_AST.mk_function (((((FStar_Parser_AST.mk_pattern (FStar_Parser_AST.PatConst (FStar_Const.Const_unit)) r)), (None), (e)))::[]) r r)
in (

let a1 = (FStar_Parser_AST.mk_term (FStar_Parser_AST.App ((((FStar_Parser_AST.mk_term (FStar_Parser_AST.Var (FStar_Syntax_Const.try_with_lid)) r top.FStar_Parser_AST.level)), (body), (FStar_Parser_AST.Nothing)))) r top.FStar_Parser_AST.level)
in (

let a2 = (FStar_Parser_AST.mk_term (FStar_Parser_AST.App (((a1), (handler), (FStar_Parser_AST.Nothing)))) r top.FStar_Parser_AST.level)
in (desugar_term env a2))))))
end
| FStar_Parser_AST.Match (e, branches) -> begin
(

let desugar_branch = (fun _64_1367 -> (match (_64_1367) with
| (pat, wopt, b) -> begin
(

let _64_1370 = (desugar_match_pat env pat)
in (match (_64_1370) with
| (env, pat) -> begin
(

let wopt = (match (wopt) with
| None -> begin
None
end
| Some (e) -> begin
(let _156_522 = (desugar_term env e)
in Some (_156_522))
end)
in (

let b = (desugar_term env b)
in (FStar_Syntax_Util.branch ((pat), (wopt), (b)))))
end))
end))
in (let _156_526 = (let _156_525 = (let _156_524 = (desugar_term env e)
in (let _156_523 = (FStar_List.map desugar_branch branches)
in ((_156_524), (_156_523))))
in FStar_Syntax_Syntax.Tm_match (_156_525))
in (FStar_All.pipe_left mk _156_526)))
end
| FStar_Parser_AST.Ascribed (e, t) -> begin
(

let env = (FStar_Parser_Env.default_ml env)
in (

let c = (desugar_comp t.FStar_Parser_AST.range true env t)
in (

let annot = if (FStar_Syntax_Util.is_ml_comp c) then begin
FStar_Util.Inl ((FStar_Syntax_Util.comp_result c))
end else begin
FStar_Util.Inr (c)
end
in (let _156_529 = (let _156_528 = (let _156_527 = (desugar_term env e)
in ((_156_527), (annot), (None)))
in FStar_Syntax_Syntax.Tm_ascribed (_156_528))
in (FStar_All.pipe_left mk _156_529)))))
end
| FStar_Parser_AST.Record (_64_1384, []) -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Unexpected empty record"), (top.FStar_Parser_AST.range)))))
end
| FStar_Parser_AST.Record (eopt, fields) -> begin
(

let _64_1395 = (FStar_List.hd fields)
in (match (_64_1395) with
| (f, _64_1394) -> begin
(

let qfn = (fun g -> (FStar_Ident.lid_of_ids (FStar_List.append f.FStar_Ident.ns ((g)::[]))))
in (

let _64_1401 = (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_record_by_field_name env) f)
in (match (_64_1401) with
| (record, _64_1400) -> begin
(

let get_field = (fun xopt f -> (

let fn = f.FStar_Ident.ident
in (

let found = (FStar_All.pipe_right fields (FStar_Util.find_opt (fun _64_1409 -> (match (_64_1409) with
| (g, _64_1408) -> begin
(

let gn = g.FStar_Ident.ident
in (fn.FStar_Ident.idText = gn.FStar_Ident.idText))
end))))
in (match (found) with
| Some (_64_1413, e) -> begin
(let _156_537 = (qfn fn)
in ((_156_537), (e)))
end
| None -> begin
(match (xopt) with
| None -> begin
(let _156_540 = (let _156_539 = (let _156_538 = (FStar_Util.format1 "Field %s is missing" (FStar_Ident.text_of_lid f))
in ((_156_538), (top.FStar_Parser_AST.range)))
in FStar_Syntax_Syntax.Error (_156_539))
in (Prims.raise _156_540))
end
| Some (x) -> begin
(let _156_541 = (qfn fn)
in ((_156_541), ((FStar_Parser_AST.mk_term (FStar_Parser_AST.Project (((x), (f)))) x.FStar_Parser_AST.range x.FStar_Parser_AST.level))))
end)
end))))
in (

let recterm = (match (eopt) with
| None -> begin
(let _156_546 = (let _156_545 = (FStar_All.pipe_right record.FStar_Parser_Env.fields (FStar_List.map (fun _64_1425 -> (match (_64_1425) with
| (f, _64_1424) -> begin
(let _156_544 = (let _156_543 = (get_field None f)
in (FStar_All.pipe_left Prims.snd _156_543))
in ((_156_544), (FStar_Parser_AST.Nothing)))
end))))
in ((record.FStar_Parser_Env.constrname), (_156_545)))
in FStar_Parser_AST.Construct (_156_546))
end
| Some (e) -> begin
(

let x = (FStar_Ident.gen e.FStar_Parser_AST.range)
in (

let xterm = (let _156_548 = (let _156_547 = (FStar_Ident.lid_of_ids ((x)::[]))
in FStar_Parser_AST.Var (_156_547))
in (FStar_Parser_AST.mk_term _156_548 x.FStar_Ident.idRange FStar_Parser_AST.Expr))
in (

let record = (let _156_551 = (let _156_550 = (FStar_All.pipe_right record.FStar_Parser_Env.fields (FStar_List.map (fun _64_1433 -> (match (_64_1433) with
| (f, _64_1432) -> begin
(get_field (Some (xterm)) f)
end))))
in ((None), (_156_550)))
in FStar_Parser_AST.Record (_156_551))
in FStar_Parser_AST.Let (((FStar_Parser_AST.NoLetQualifier), (((((FStar_Parser_AST.mk_pattern (FStar_Parser_AST.PatVar (((x), (None)))) x.FStar_Ident.idRange)), (e)))::[]), ((FStar_Parser_AST.mk_term record top.FStar_Parser_AST.range top.FStar_Parser_AST.level)))))))
end)
in (

let recterm = (FStar_Parser_AST.mk_term recterm top.FStar_Parser_AST.range top.FStar_Parser_AST.level)
in (

let e = (desugar_term env recterm)
in (match (e.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_meta ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (fv); FStar_Syntax_Syntax.tk = _64_1449; FStar_Syntax_Syntax.pos = _64_1447; FStar_Syntax_Syntax.vars = _64_1445}, args); FStar_Syntax_Syntax.tk = _64_1443; FStar_Syntax_Syntax.pos = _64_1441; FStar_Syntax_Syntax.vars = _64_1439}, FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Data_app)) -> begin
(

let e = (let _156_559 = (let _156_558 = (let _156_557 = (let _156_556 = (FStar_Ident.set_lid_range fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v e.FStar_Syntax_Syntax.pos)
in (let _156_555 = (let _156_554 = (let _156_553 = (let _156_552 = (FStar_All.pipe_right record.FStar_Parser_Env.fields (FStar_List.map Prims.fst))
in ((record.FStar_Parser_Env.typename), (_156_552)))
in FStar_Syntax_Syntax.Record_ctor (_156_553))
in Some (_156_554))
in (FStar_Syntax_Syntax.fvar _156_556 FStar_Syntax_Syntax.Delta_constant _156_555)))
in ((_156_557), (args)))
in FStar_Syntax_Syntax.Tm_app (_156_558))
in (FStar_All.pipe_left mk _156_559))
in (FStar_All.pipe_left mk (FStar_Syntax_Syntax.Tm_meta (((e), (FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Data_app)))))))
end
| _64_1463 -> begin
e
end)))))
end)))
end))
end
| FStar_Parser_AST.Project (e, f) -> begin
(

let _64_1470 = (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_projector_by_field_name env) f)
in (match (_64_1470) with
| (fieldname, is_rec) -> begin
(

let e = (desugar_term env e)
in (

let fn = (

let _64_1475 = (FStar_Util.prefix fieldname.FStar_Ident.ns)
in (match (_64_1475) with
| (ns, _64_1474) -> begin
(FStar_Ident.lid_of_ids (FStar_List.append ns ((f.FStar_Ident.ident)::[])))
end))
in (

let qual = if is_rec then begin
Some (FStar_Syntax_Syntax.Record_projector (fn))
end else begin
None
end
in (let _156_565 = (let _156_564 = (let _156_563 = (let _156_560 = (FStar_Ident.set_lid_range fieldname (FStar_Ident.range_of_lid f))
in (FStar_Syntax_Syntax.fvar _156_560 FStar_Syntax_Syntax.Delta_equational qual))
in (let _156_562 = (let _156_561 = (FStar_Syntax_Syntax.as_arg e)
in (_156_561)::[])
in ((_156_563), (_156_562))))
in FStar_Syntax_Syntax.Tm_app (_156_564))
in (FStar_All.pipe_left mk _156_565)))))
end))
end
| (FStar_Parser_AST.NamedTyp (_, e)) | (FStar_Parser_AST.Paren (e)) -> begin
(desugar_term env e)
end
| _64_1485 when (top.FStar_Parser_AST.level = FStar_Parser_AST.Formula) -> begin
(desugar_formula env top)
end
| _64_1487 -> begin
(FStar_Parser_AST.error "Unexpected term" top top.FStar_Parser_AST.range)
end))))
and desugar_args : FStar_Parser_Env.env  ->  (FStar_Parser_AST.term * FStar_Parser_AST.imp) Prims.list  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list = (fun env args -> (FStar_All.pipe_right args (FStar_List.map (fun _64_1492 -> (match (_64_1492) with
| (a, imp) -> begin
(let _156_569 = (desugar_term env a)
in (arg_withimp_e imp _156_569))
end)))))
and desugar_comp : FStar_Range.range  ->  Prims.bool  ->  FStar_Parser_Env.env  ->  FStar_Parser_AST.term  ->  (FStar_Syntax_Syntax.comp', Prims.unit) FStar_Syntax_Syntax.syntax = (fun r default_ok env t -> (

let fail = (fun msg -> (Prims.raise (FStar_Syntax_Syntax.Error (((msg), (r))))))
in (

let is_requires = (fun _64_1504 -> (match (_64_1504) with
| (t, _64_1503) -> begin
(match ((let _156_577 = (unparen t)
in _156_577.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.Requires (_64_1506) -> begin
true
end
| _64_1509 -> begin
false
end)
end))
in (

let is_ensures = (fun _64_1514 -> (match (_64_1514) with
| (t, _64_1513) -> begin
(match ((let _156_580 = (unparen t)
in _156_580.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.Ensures (_64_1516) -> begin
true
end
| _64_1519 -> begin
false
end)
end))
in (

let is_app = (fun head _64_1525 -> (match (_64_1525) with
| (t, _64_1524) -> begin
(match ((let _156_585 = (unparen t)
in _156_585.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.App ({FStar_Parser_AST.tm = FStar_Parser_AST.Var (d); FStar_Parser_AST.range = _64_1529; FStar_Parser_AST.level = _64_1527}, _64_1534, _64_1536) -> begin
(d.FStar_Ident.ident.FStar_Ident.idText = head)
end
| _64_1540 -> begin
false
end)
end))
in (

let is_decreases = (is_app "decreases")
in (

let pre_process_comp_typ = (fun t -> (

let _64_1546 = (head_and_args t)
in (match (_64_1546) with
| (head, args) -> begin
(match (head.FStar_Parser_AST.tm) with
| FStar_Parser_AST.Name (lemma) when (lemma.FStar_Ident.ident.FStar_Ident.idText = "Lemma") -> begin
(

let unit_tm = (((FStar_Parser_AST.mk_term (FStar_Parser_AST.Name (FStar_Syntax_Const.unit_lid)) t.FStar_Parser_AST.range FStar_Parser_AST.Type)), (FStar_Parser_AST.Nothing))
in (

let nil_pat = (((FStar_Parser_AST.mk_term (FStar_Parser_AST.Name (FStar_Syntax_Const.nil_lid)) t.FStar_Parser_AST.range FStar_Parser_AST.Expr)), (FStar_Parser_AST.Nothing))
in (

let req_true = (((FStar_Parser_AST.mk_term (FStar_Parser_AST.Requires ((((FStar_Parser_AST.mk_term (FStar_Parser_AST.Name (FStar_Syntax_Const.true_lid)) t.FStar_Parser_AST.range FStar_Parser_AST.Formula)), (None)))) t.FStar_Parser_AST.range FStar_Parser_AST.Type)), (FStar_Parser_AST.Nothing))
in (

let args = (match (args) with
| [] -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Not enough arguments to \'Lemma\'"), (t.FStar_Parser_AST.range)))))
end
| (ens)::[] -> begin
(unit_tm)::(req_true)::(ens)::(nil_pat)::[]
end
| (req)::(ens)::[] when ((is_requires req) && (is_ensures ens)) -> begin
(unit_tm)::(req)::(ens)::(nil_pat)::[]
end
| (ens)::(dec)::[] when ((is_ensures ens) && (is_decreases dec)) -> begin
(unit_tm)::(req_true)::(ens)::(nil_pat)::(dec)::[]
end
| (req)::(ens)::(dec)::[] when (((is_requires req) && (is_ensures ens)) && (is_app "decreases" dec)) -> begin
(unit_tm)::(req)::(ens)::(nil_pat)::(dec)::[]
end
| more -> begin
(unit_tm)::more
end)
in (

let head = (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_effect_name env) lemma)
in ((head), (args)))))))
end
| FStar_Parser_AST.Name (l) when (FStar_Parser_Env.is_effect_name env l) -> begin
(let _156_589 = (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_effect_name env) l)
in ((_156_589), (args)))
end
| FStar_Parser_AST.Name (l) when ((let _156_590 = (FStar_Parser_Env.current_module env)
in (FStar_Ident.lid_equals _156_590 FStar_Syntax_Const.prims_lid)) && (l.FStar_Ident.ident.FStar_Ident.idText = "Tot")) -> begin
(let _156_591 = (FStar_Ident.set_lid_range FStar_Syntax_Const.effect_Tot_lid head.FStar_Parser_AST.range)
in ((_156_591), (args)))
end
| FStar_Parser_AST.Name (l) when ((let _156_592 = (FStar_Parser_Env.current_module env)
in (FStar_Ident.lid_equals _156_592 FStar_Syntax_Const.prims_lid)) && (l.FStar_Ident.ident.FStar_Ident.idText = "GTot")) -> begin
(let _156_593 = (FStar_Ident.set_lid_range FStar_Syntax_Const.effect_GTot_lid head.FStar_Parser_AST.range)
in ((_156_593), (args)))
end
| FStar_Parser_AST.Name (l) when ((((l.FStar_Ident.ident.FStar_Ident.idText = "Type") || (l.FStar_Ident.ident.FStar_Ident.idText = "Type0")) || (l.FStar_Ident.ident.FStar_Ident.idText = "Effect")) && default_ok) -> begin
(let _156_594 = (FStar_Ident.set_lid_range FStar_Syntax_Const.effect_Tot_lid head.FStar_Parser_AST.range)
in ((_156_594), ((((t), (FStar_Parser_AST.Nothing)))::[])))
end
| _64_1577 when default_ok -> begin
(let _156_595 = (FStar_Ident.set_lid_range env.FStar_Parser_Env.default_result_effect head.FStar_Parser_AST.range)
in ((_156_595), ((((t), (FStar_Parser_AST.Nothing)))::[])))
end
| _64_1579 -> begin
(let _156_597 = (let _156_596 = (FStar_Parser_AST.term_to_string t)
in (FStar_Util.format1 "%s is not an effect" _156_596))
in (fail _156_597))
end)
end)))
in (

let _64_1582 = (pre_process_comp_typ t)
in (match (_64_1582) with
| (eff, args) -> begin
(

let _64_1583 = if ((FStar_List.length args) = 0) then begin
(let _156_599 = (let _156_598 = (FStar_Syntax_Print.lid_to_string eff)
in (FStar_Util.format1 "Not enough args to effect %s" _156_598))
in (fail _156_599))
end else begin
()
end
in (

let _64_1587 = (let _156_601 = (FStar_List.hd args)
in (let _156_600 = (FStar_List.tl args)
in ((_156_601), (_156_600))))
in (match (_64_1587) with
| (result_arg, rest) -> begin
(

let result_typ = (desugar_typ env (Prims.fst result_arg))
in (

let rest = (desugar_args env rest)
in (

let _64_1612 = (FStar_All.pipe_right rest (FStar_List.partition (fun _64_1593 -> (match (_64_1593) with
| (t, _64_1592) -> begin
(match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (fv); FStar_Syntax_Syntax.tk = _64_1599; FStar_Syntax_Syntax.pos = _64_1597; FStar_Syntax_Syntax.vars = _64_1595}, (_64_1604)::[]) -> begin
(FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.decreases_lid)
end
| _64_1609 -> begin
false
end)
end))))
in (match (_64_1612) with
| (dec, rest) -> begin
(

let decreases_clause = (FStar_All.pipe_right dec (FStar_List.map (fun _64_1616 -> (match (_64_1616) with
| (t, _64_1615) -> begin
(match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_app (_64_1618, ((arg, _64_1621))::[]) -> begin
FStar_Syntax_Syntax.DECREASES (arg)
end
| _64_1627 -> begin
(FStar_All.failwith "impos")
end)
end))))
in (

let no_additional_args = (((FStar_List.length decreases_clause) = 0) && ((FStar_List.length rest) = 0))
in if (no_additional_args && (FStar_Ident.lid_equals eff FStar_Syntax_Const.effect_Tot_lid)) then begin
(FStar_Syntax_Syntax.mk_Total result_typ)
end else begin
if (no_additional_args && (FStar_Ident.lid_equals eff FStar_Syntax_Const.effect_GTot_lid)) then begin
(FStar_Syntax_Syntax.mk_GTotal result_typ)
end else begin
(

let flags = if (FStar_Ident.lid_equals eff FStar_Syntax_Const.effect_Lemma_lid) then begin
(FStar_Syntax_Syntax.LEMMA)::[]
end else begin
if (FStar_Ident.lid_equals eff FStar_Syntax_Const.effect_Tot_lid) then begin
(FStar_Syntax_Syntax.TOTAL)::[]
end else begin
if (FStar_Ident.lid_equals eff FStar_Syntax_Const.effect_ML_lid) then begin
(FStar_Syntax_Syntax.MLEFFECT)::[]
end else begin
if (FStar_Ident.lid_equals eff FStar_Syntax_Const.effect_GTot_lid) then begin
(FStar_Syntax_Syntax.SOMETRIVIAL)::[]
end else begin
[]
end
end
end
end
in (

let rest = if (FStar_Ident.lid_equals eff FStar_Syntax_Const.effect_Lemma_lid) then begin
(match (rest) with
| (req)::(ens)::((pat, aq))::[] -> begin
(

let pat = (match (pat.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (fv) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.nil_lid) -> begin
(

let nil = (FStar_Syntax_Syntax.mk_Tm_uinst pat ((FStar_Syntax_Syntax.U_succ (FStar_Syntax_Syntax.U_zero))::[]))
in (

let pattern = (let _156_605 = (let _156_604 = (FStar_Ident.set_lid_range FStar_Syntax_Const.pattern_lid pat.FStar_Syntax_Syntax.pos)
in (FStar_Syntax_Syntax.fvar _156_604 FStar_Syntax_Syntax.Delta_constant None))
in (FStar_Syntax_Syntax.mk_Tm_uinst _156_605 ((FStar_Syntax_Syntax.U_zero)::[])))
in (FStar_Syntax_Syntax.mk_Tm_app nil ((((pattern), (Some (FStar_Syntax_Syntax.imp_tag))))::[]) None pat.FStar_Syntax_Syntax.pos)))
end
| _64_1642 -> begin
pat
end)
in (let _156_609 = (let _156_608 = (let _156_607 = (let _156_606 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta (((pat), (FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Meta_smt_pat))))) None pat.FStar_Syntax_Syntax.pos)
in ((_156_606), (aq)))
in (_156_607)::[])
in (ens)::_156_608)
in (req)::_156_609))
end
| _64_1645 -> begin
rest
end)
end else begin
rest
end
in (FStar_Syntax_Syntax.mk_Comp {FStar_Syntax_Syntax.effect_name = eff; FStar_Syntax_Syntax.result_typ = result_typ; FStar_Syntax_Syntax.effect_args = rest; FStar_Syntax_Syntax.flags = (FStar_List.append flags decreases_clause)})))
end
end))
end))))
end)))
end)))))))))
and desugar_formula : env_t  ->  FStar_Parser_AST.term  ->  FStar_Syntax_Syntax.term = (fun env f -> (

let connective = (fun s -> (match (s) with
| "/\\" -> begin
Some (FStar_Syntax_Const.and_lid)
end
| "\\/" -> begin
Some (FStar_Syntax_Const.or_lid)
end
| "==>" -> begin
Some (FStar_Syntax_Const.imp_lid)
end
| "<==>" -> begin
Some (FStar_Syntax_Const.iff_lid)
end
| "~" -> begin
Some (FStar_Syntax_Const.not_lid)
end
| _64_1657 -> begin
None
end))
in (

let mk = (fun t -> (FStar_Syntax_Syntax.mk t None f.FStar_Parser_AST.range))
in (

let pos = (fun t -> (t None f.FStar_Parser_AST.range))
in (

let setpos = (fun t -> (

let _64_1664 = t
in {FStar_Syntax_Syntax.n = _64_1664.FStar_Syntax_Syntax.n; FStar_Syntax_Syntax.tk = _64_1664.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = f.FStar_Parser_AST.range; FStar_Syntax_Syntax.vars = _64_1664.FStar_Syntax_Syntax.vars}))
in (

let desugar_quant = (fun q b pats body -> (

let tk = (desugar_binder env (

let _64_1671 = b
in {FStar_Parser_AST.b = _64_1671.FStar_Parser_AST.b; FStar_Parser_AST.brange = _64_1671.FStar_Parser_AST.brange; FStar_Parser_AST.blevel = FStar_Parser_AST.Formula; FStar_Parser_AST.aqual = _64_1671.FStar_Parser_AST.aqual}))
in (

let desugar_pats = (fun env pats -> (FStar_List.map (fun es -> (FStar_All.pipe_right es (FStar_List.map (fun e -> (let _156_644 = (desugar_term env e)
in (FStar_All.pipe_left (arg_withimp_t FStar_Parser_AST.Nothing) _156_644)))))) pats))
in (match (tk) with
| (Some (a), k) -> begin
(

let _64_1685 = (FStar_Parser_Env.push_bv env a)
in (match (_64_1685) with
| (env, a) -> begin
(

let a = (

let _64_1686 = a
in {FStar_Syntax_Syntax.ppname = _64_1686.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _64_1686.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = k})
in (

let pats = (desugar_pats env pats)
in (

let body = (desugar_formula env body)
in (

let body = (match (pats) with
| [] -> begin
body
end
| _64_1693 -> begin
(mk (FStar_Syntax_Syntax.Tm_meta (((body), (FStar_Syntax_Syntax.Meta_pattern (pats))))))
end)
in (

let body = (let _156_647 = (let _156_646 = (let _156_645 = (FStar_Syntax_Syntax.mk_binder a)
in (_156_645)::[])
in (no_annot_abs _156_646 body))
in (FStar_All.pipe_left setpos _156_647))
in (let _156_653 = (let _156_652 = (let _156_651 = (let _156_648 = (FStar_Ident.set_lid_range q b.FStar_Parser_AST.brange)
in (FStar_Syntax_Syntax.fvar _156_648 (FStar_Syntax_Syntax.Delta_unfoldable (1)) None))
in (let _156_650 = (let _156_649 = (FStar_Syntax_Syntax.as_arg body)
in (_156_649)::[])
in ((_156_651), (_156_650))))
in FStar_Syntax_Syntax.Tm_app (_156_652))
in (FStar_All.pipe_left mk _156_653)))))))
end))
end
| _64_1697 -> begin
(FStar_All.failwith "impossible")
end))))
in (

let push_quant = (fun q binders pats body -> (match (binders) with
| (b)::(b')::_rest -> begin
(

let rest = (b')::_rest
in (

let body = (let _156_668 = (q ((rest), (pats), (body)))
in (let _156_667 = (FStar_Range.union_ranges b'.FStar_Parser_AST.brange body.FStar_Parser_AST.range)
in (FStar_Parser_AST.mk_term _156_668 _156_667 FStar_Parser_AST.Formula)))
in (let _156_669 = (q (((b)::[]), ([]), (body)))
in (FStar_Parser_AST.mk_term _156_669 f.FStar_Parser_AST.range FStar_Parser_AST.Formula))))
end
| _64_1711 -> begin
(FStar_All.failwith "impossible")
end))
in (match ((let _156_670 = (unparen f)
in _156_670.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.Labeled (f, l, p) -> begin
(

let f = (desugar_formula env f)
in (FStar_All.pipe_left mk (FStar_Syntax_Syntax.Tm_meta (((f), (FStar_Syntax_Syntax.Meta_labeled (((l), (f.FStar_Syntax_Syntax.pos), (p)))))))))
end
| (FStar_Parser_AST.QForall ([], _, _)) | (FStar_Parser_AST.QExists ([], _, _)) -> begin
(FStar_All.failwith "Impossible: Quantifier without binders")
end
| FStar_Parser_AST.QForall ((_1)::(_2)::_3, pats, body) -> begin
(

let binders = (_1)::(_2)::_3
in (let _156_672 = (push_quant (fun x -> FStar_Parser_AST.QForall (x)) binders pats body)
in (desugar_formula env _156_672)))
end
| FStar_Parser_AST.QExists ((_1)::(_2)::_3, pats, body) -> begin
(

let binders = (_1)::(_2)::_3
in (let _156_674 = (push_quant (fun x -> FStar_Parser_AST.QExists (x)) binders pats body)
in (desugar_formula env _156_674)))
end
| FStar_Parser_AST.QForall ((b)::[], pats, body) -> begin
(desugar_quant FStar_Syntax_Const.forall_lid b pats body)
end
| FStar_Parser_AST.QExists ((b)::[], pats, body) -> begin
(desugar_quant FStar_Syntax_Const.exists_lid b pats body)
end
| FStar_Parser_AST.Paren (f) -> begin
(desugar_formula env f)
end
| _64_1769 -> begin
(desugar_term env f)
end))))))))
and typars_of_binders : FStar_Parser_Env.env  ->  FStar_Parser_AST.binder Prims.list  ->  (FStar_Parser_Env.env * (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list) = (fun env bs -> (

let _64_1793 = (FStar_List.fold_left (fun _64_1774 b -> (match (_64_1774) with
| (env, out) -> begin
(

let tk = (desugar_binder env (

let _64_1776 = b
in {FStar_Parser_AST.b = _64_1776.FStar_Parser_AST.b; FStar_Parser_AST.brange = _64_1776.FStar_Parser_AST.brange; FStar_Parser_AST.blevel = FStar_Parser_AST.Formula; FStar_Parser_AST.aqual = _64_1776.FStar_Parser_AST.aqual}))
in (match (tk) with
| (Some (a), k) -> begin
(

let _64_1785 = (FStar_Parser_Env.push_bv env a)
in (match (_64_1785) with
| (env, a) -> begin
(

let a = (

let _64_1786 = a
in {FStar_Syntax_Syntax.ppname = _64_1786.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _64_1786.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = k})
in ((env), ((((a), ((trans_aqual b.FStar_Parser_AST.aqual))))::out)))
end))
end
| _64_1790 -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Unexpected binder"), (b.FStar_Parser_AST.brange)))))
end))
end)) ((env), ([])) bs)
in (match (_64_1793) with
| (env, tpars) -> begin
((env), ((FStar_List.rev tpars)))
end)))
and desugar_binder : FStar_Parser_Env.env  ->  FStar_Parser_AST.binder  ->  (FStar_Ident.ident Prims.option * FStar_Syntax_Syntax.term) = (fun env b -> (match (b.FStar_Parser_AST.b) with
| (FStar_Parser_AST.TAnnotated (x, t)) | (FStar_Parser_AST.Annotated (x, t)) -> begin
(let _156_681 = (desugar_typ env t)
in ((Some (x)), (_156_681)))
end
| FStar_Parser_AST.TVariable (x) -> begin
(let _156_682 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (FStar_Syntax_Syntax.U_unknown)) None x.FStar_Ident.idRange)
in ((Some (x)), (_156_682)))
end
| FStar_Parser_AST.NoName (t) -> begin
(let _156_683 = (desugar_typ env t)
in ((None), (_156_683)))
end
| FStar_Parser_AST.Variable (x) -> begin
((Some (x)), (FStar_Syntax_Syntax.tun))
end))


let mk_data_discriminators : FStar_Syntax_Syntax.qualifier Prims.list  ->  FStar_Parser_Env.env  ->  FStar_Ident.lid  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list  ->  FStar_Syntax_Syntax.term  ->  FStar_Ident.lident Prims.list  ->  FStar_Syntax_Syntax.sigelt Prims.list = (fun quals env t tps k datas -> (

let quals = (fun q -> if ((FStar_All.pipe_left Prims.op_Negation env.FStar_Parser_Env.iface) || env.FStar_Parser_Env.admitted_iface) then begin
(FStar_List.append ((FStar_Syntax_Syntax.Assumption)::q) quals)
end else begin
(FStar_List.append q quals)
end)
in (

let binders = (let _156_699 = (let _156_698 = (FStar_Syntax_Util.arrow_formals k)
in (Prims.fst _156_698))
in (FStar_List.append tps _156_699))
in (

let p = (FStar_Ident.range_of_lid t)
in (

let _64_1820 = (FStar_Syntax_Util.args_of_binders binders)
in (match (_64_1820) with
| (binders, args) -> begin
(

let imp_binders = (FStar_All.pipe_right binders (FStar_List.map (fun _64_1824 -> (match (_64_1824) with
| (x, _64_1823) -> begin
((x), (Some (FStar_Syntax_Syntax.imp_tag)))
end))))
in (

let binders = (let _156_705 = (let _156_704 = (let _156_703 = (let _156_702 = (let _156_701 = (FStar_Syntax_Syntax.lid_as_fv t FStar_Syntax_Syntax.Delta_constant None)
in (FStar_Syntax_Syntax.fv_to_tm _156_701))
in (FStar_Syntax_Syntax.mk_Tm_app _156_702 args None p))
in (FStar_All.pipe_left FStar_Syntax_Syntax.null_binder _156_703))
in (_156_704)::[])
in (FStar_List.append imp_binders _156_705))
in (

let disc_type = (let _156_708 = (let _156_707 = (let _156_706 = (FStar_Syntax_Syntax.lid_as_fv FStar_Syntax_Const.bool_lid FStar_Syntax_Syntax.Delta_constant None)
in (FStar_Syntax_Syntax.fv_to_tm _156_706))
in (FStar_Syntax_Syntax.mk_Total _156_707))
in (FStar_Syntax_Util.arrow binders _156_708))
in (FStar_All.pipe_right datas (FStar_List.map (fun d -> (

let disc_name = (FStar_Syntax_Util.mk_discriminator d)
in (let _156_711 = (let _156_710 = (quals ((FStar_Syntax_Syntax.Logic)::(FStar_Syntax_Syntax.Discriminator (d))::[]))
in ((disc_name), ([]), (disc_type), (_156_710), ((FStar_Ident.range_of_lid disc_name))))
in FStar_Syntax_Syntax.Sig_declare_typ (_156_711)))))))))
end))))))


let mk_indexed_projectors : FStar_Syntax_Syntax.qualifier Prims.list  ->  FStar_Syntax_Syntax.fv_qual  ->  Prims.bool  ->  FStar_Parser_Env.env  ->  FStar_Ident.lident  ->  FStar_Ident.lid  ->  FStar_Syntax_Syntax.binders  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list  ->  FStar_Syntax_Syntax.binder Prims.list  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.sigelt Prims.list = (fun iquals fvq refine_domain env tc lid inductive_tps imp_tps fields t -> (

let p = (FStar_Ident.range_of_lid lid)
in (

let pos = (fun q -> (FStar_Syntax_Syntax.withinfo q FStar_Syntax_Syntax.tun.FStar_Syntax_Syntax.n p))
in (

let projectee = (fun ptyp -> (FStar_Syntax_Syntax.gen_bv "projectee" (Some (p)) ptyp))
in (

let tps = (FStar_List.map2 (fun _64_1848 _64_1852 -> (match (((_64_1848), (_64_1852))) with
| ((_64_1846, imp), (x, _64_1851)) -> begin
((x), (imp))
end)) inductive_tps imp_tps)
in (

let _64_1953 = (

let _64_1856 = (FStar_Syntax_Util.head_and_args t)
in (match (_64_1856) with
| (head, args0) -> begin
(

let args = (

let rec arguments = (fun tps args -> (match (((tps), (args))) with
| ([], _64_1862) -> begin
args
end
| (_64_1865, []) -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Not enough arguments to type"), ((FStar_Ident.range_of_lid lid))))))
end
| (((_64_1870, Some (FStar_Syntax_Syntax.Implicit (_64_1872))))::tps', ((_64_1879, Some (FStar_Syntax_Syntax.Implicit (_64_1881))))::args') -> begin
(arguments tps' args')
end
| (((_64_1889, Some (FStar_Syntax_Syntax.Implicit (_64_1891))))::tps', ((_64_1899, _64_1901))::_64_1897) -> begin
(arguments tps' args)
end
| (((_64_1908, _64_1910))::_64_1906, ((a, Some (FStar_Syntax_Syntax.Implicit (_64_1917))))::_64_1914) -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Unexpected implicit annotation on argument"), (a.FStar_Syntax_Syntax.pos)))))
end
| (((_64_1925, _64_1927))::tps', ((_64_1932, _64_1934))::args') -> begin
(arguments tps' args')
end))
in (arguments inductive_tps args0))
in (

let indices = (FStar_All.pipe_right args (FStar_List.map (fun _64_1939 -> (let _156_743 = (FStar_Syntax_Syntax.new_bv (Some (p)) FStar_Syntax_Syntax.tun)
in (FStar_All.pipe_right _156_743 FStar_Syntax_Syntax.mk_binder)))))
in (

let arg_typ = (let _156_748 = (let _156_744 = (FStar_Syntax_Syntax.lid_as_fv tc FStar_Syntax_Syntax.Delta_constant None)
in (FStar_Syntax_Syntax.fv_to_tm _156_744))
in (let _156_747 = (FStar_All.pipe_right (FStar_List.append tps indices) (FStar_List.map (fun _64_1944 -> (match (_64_1944) with
| (x, imp) -> begin
(let _156_746 = (FStar_Syntax_Syntax.bv_to_name x)
in ((_156_746), (imp)))
end))))
in (FStar_Syntax_Syntax.mk_Tm_app _156_748 _156_747 None p)))
in (

let arg_binder = if (not (refine_domain)) then begin
(let _156_749 = (projectee arg_typ)
in (FStar_Syntax_Syntax.mk_binder _156_749))
end else begin
(

let disc_name = (FStar_Syntax_Util.mk_discriminator lid)
in (

let x = (FStar_Syntax_Syntax.new_bv (Some (p)) arg_typ)
in (let _156_758 = (

let _64_1948 = (projectee arg_typ)
in (let _156_757 = (let _156_756 = (let _156_755 = (let _156_754 = (let _156_750 = (FStar_Ident.set_lid_range disc_name p)
in (FStar_Syntax_Syntax.fvar _156_750 FStar_Syntax_Syntax.Delta_equational None))
in (let _156_753 = (let _156_752 = (let _156_751 = (FStar_Syntax_Syntax.bv_to_name x)
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _156_751))
in (_156_752)::[])
in (FStar_Syntax_Syntax.mk_Tm_app _156_754 _156_753 None p)))
in (FStar_Syntax_Util.b2t _156_755))
in (FStar_Syntax_Util.refine x _156_756))
in {FStar_Syntax_Syntax.ppname = _64_1948.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _64_1948.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _156_757}))
in (FStar_Syntax_Syntax.mk_binder _156_758))))
end
in ((arg_binder), (indices))))))
end))
in (match (_64_1953) with
| (arg_binder, indices) -> begin
(

let arg_exp = (FStar_Syntax_Syntax.bv_to_name (Prims.fst arg_binder))
in (

let imp_binders = (let _156_760 = (FStar_All.pipe_right indices (FStar_List.map (fun _64_1958 -> (match (_64_1958) with
| (x, _64_1957) -> begin
((x), (Some (FStar_Syntax_Syntax.imp_tag)))
end))))
in (FStar_List.append imp_tps _156_760))
in (

let binders = (FStar_List.append imp_binders ((arg_binder)::[]))
in (

let arg = (FStar_Syntax_Util.arg_of_non_null_binder arg_binder)
in (

let subst = (FStar_All.pipe_right fields (FStar_List.mapi (fun i _64_1966 -> (match (_64_1966) with
| (a, _64_1965) -> begin
(

let _64_1970 = (FStar_Syntax_Util.mk_field_projector_name lid a i)
in (match (_64_1970) with
| (field_name, _64_1969) -> begin
(

let proj = (let _156_764 = (let _156_763 = (FStar_Syntax_Syntax.lid_as_fv field_name FStar_Syntax_Syntax.Delta_equational None)
in (FStar_Syntax_Syntax.fv_to_tm _156_763))
in (FStar_Syntax_Syntax.mk_Tm_app _156_764 ((arg)::[]) None p))
in FStar_Syntax_Syntax.NT (((a), (proj))))
end))
end))))
in (

let ntps = (FStar_List.length tps)
in (

let all_params = (FStar_List.append imp_tps fields)
in (let _156_800 = (FStar_All.pipe_right fields (FStar_List.mapi (fun i _64_1979 -> (match (_64_1979) with
| (x, _64_1978) -> begin
(

let _64_1983 = (FStar_Syntax_Util.mk_field_projector_name lid x i)
in (match (_64_1983) with
| (field_name, _64_1982) -> begin
(

let t = (let _156_768 = (let _156_767 = (FStar_Syntax_Subst.subst subst x.FStar_Syntax_Syntax.sort)
in (FStar_Syntax_Syntax.mk_Total _156_767))
in (FStar_Syntax_Util.arrow binders _156_768))
in (

let only_decl = (((let _156_769 = (FStar_Parser_Env.current_module env)
in (FStar_Ident.lid_equals FStar_Syntax_Const.prims_lid _156_769)) || (fvq <> FStar_Syntax_Syntax.Data_ctor)) || (let _156_771 = (let _156_770 = (FStar_Parser_Env.current_module env)
in _156_770.FStar_Ident.str)
in (FStar_Options.dont_gen_projectors _156_771)))
in (

let no_decl = (FStar_Syntax_Syntax.is_type x.FStar_Syntax_Syntax.sort)
in (

let quals = (fun q -> if only_decl then begin
(FStar_Syntax_Syntax.Assumption)::q
end else begin
q
end)
in (

let quals = (quals ((FStar_Syntax_Syntax.Projector (((lid), (x.FStar_Syntax_Syntax.ppname))))::iquals))
in (

let decl = FStar_Syntax_Syntax.Sig_declare_typ (((field_name), ([]), (t), (quals), ((FStar_Ident.range_of_lid field_name))))
in if only_decl then begin
(decl)::[]
end else begin
(

let projection = (FStar_Syntax_Syntax.gen_bv x.FStar_Syntax_Syntax.ppname.FStar_Ident.idText None FStar_Syntax_Syntax.tun)
in (

let arg_pats = (FStar_All.pipe_right all_params (FStar_List.mapi (fun j _64_1995 -> (match (_64_1995) with
| (x, imp) -> begin
(

let b = (FStar_Syntax_Syntax.is_implicit imp)
in if ((i + ntps) = j) then begin
(let _156_776 = (pos (FStar_Syntax_Syntax.Pat_var (projection)))
in ((_156_776), (b)))
end else begin
if (b && (j < ntps)) then begin
(let _156_780 = (let _156_779 = (let _156_778 = (let _156_777 = (FStar_Syntax_Syntax.gen_bv x.FStar_Syntax_Syntax.ppname.FStar_Ident.idText None FStar_Syntax_Syntax.tun)
in ((_156_777), (FStar_Syntax_Syntax.tun)))
in FStar_Syntax_Syntax.Pat_dot_term (_156_778))
in (pos _156_779))
in ((_156_780), (b)))
end else begin
(let _156_783 = (let _156_782 = (let _156_781 = (FStar_Syntax_Syntax.gen_bv x.FStar_Syntax_Syntax.ppname.FStar_Ident.idText None FStar_Syntax_Syntax.tun)
in FStar_Syntax_Syntax.Pat_wild (_156_781))
in (pos _156_782))
in ((_156_783), (b)))
end
end)
end))))
in (

let pat = (let _156_788 = (let _156_786 = (let _156_785 = (let _156_784 = (FStar_Syntax_Syntax.lid_as_fv lid FStar_Syntax_Syntax.Delta_constant (Some (fvq)))
in ((_156_784), (arg_pats)))
in FStar_Syntax_Syntax.Pat_cons (_156_785))
in (FStar_All.pipe_right _156_786 pos))
in (let _156_787 = (FStar_Syntax_Syntax.bv_to_name projection)
in ((_156_788), (None), (_156_787))))
in (

let body = (let _156_792 = (let _156_791 = (let _156_790 = (let _156_789 = (FStar_Syntax_Util.branch pat)
in (_156_789)::[])
in ((arg_exp), (_156_790)))
in FStar_Syntax_Syntax.Tm_match (_156_791))
in (FStar_Syntax_Syntax.mk _156_792 None p))
in (

let imp = (no_annot_abs binders body)
in (

let dd = if (FStar_All.pipe_right quals (FStar_List.contains FStar_Syntax_Syntax.Abstract)) then begin
FStar_Syntax_Syntax.Delta_abstract (FStar_Syntax_Syntax.Delta_equational)
end else begin
FStar_Syntax_Syntax.Delta_equational
end
in (

let lb = (let _156_794 = (let _156_793 = (FStar_Syntax_Syntax.lid_as_fv field_name dd None)
in FStar_Util.Inr (_156_793))
in {FStar_Syntax_Syntax.lbname = _156_794; FStar_Syntax_Syntax.lbunivs = []; FStar_Syntax_Syntax.lbtyp = FStar_Syntax_Syntax.tun; FStar_Syntax_Syntax.lbeff = FStar_Syntax_Const.effect_Tot_lid; FStar_Syntax_Syntax.lbdef = imp})
in (

let impl = (let _156_799 = (let _156_798 = (let _156_797 = (let _156_796 = (FStar_All.pipe_right lb.FStar_Syntax_Syntax.lbname FStar_Util.right)
in (FStar_All.pipe_right _156_796 (fun fv -> fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)))
in (_156_797)::[])
in ((((false), ((lb)::[]))), (p), (_156_798), (quals)))
in FStar_Syntax_Syntax.Sig_let (_156_799))
in if no_decl then begin
(impl)::[]
end else begin
(decl)::(impl)::[]
end))))))))
end))))))
end))
end))))
in (FStar_All.pipe_right _156_800 FStar_List.flatten)))))))))
end)))))))


let mk_data_projectors : FStar_Syntax_Syntax.qualifier Prims.list  ->  FStar_Parser_Env.env  ->  (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.sigelt)  ->  FStar_Syntax_Syntax.sigelt Prims.list = (fun iquals env _64_2009 -> (match (_64_2009) with
| (inductive_tps, se) -> begin
(match (se) with
| FStar_Syntax_Syntax.Sig_datacon (lid, _64_2012, t, l, n, quals, _64_2018, _64_2020) when (not ((FStar_Ident.lid_equals lid FStar_Syntax_Const.lexcons_lid))) -> begin
(

let refine_domain = if (FStar_All.pipe_right quals (FStar_Util.for_some (fun _64_11 -> (match (_64_11) with
| FStar_Syntax_Syntax.RecordConstructor (_64_2025) -> begin
true
end
| _64_2028 -> begin
false
end)))) then begin
false
end else begin
(match ((FStar_Parser_Env.find_all_datacons env l)) with
| Some (l) -> begin
((FStar_List.length l) > 1)
end
| _64_2032 -> begin
true
end)
end
in (

let _64_2036 = (FStar_Syntax_Util.arrow_formals t)
in (match (_64_2036) with
| (formals, cod) -> begin
(match (formals) with
| [] -> begin
[]
end
| _64_2039 -> begin
(

let fv_qual = (match ((FStar_Util.find_map quals (fun _64_12 -> (match (_64_12) with
| FStar_Syntax_Syntax.RecordConstructor (fns) -> begin
Some (FStar_Syntax_Syntax.Record_ctor (((lid), (fns))))
end
| _64_2044 -> begin
None
end)))) with
| None -> begin
FStar_Syntax_Syntax.Data_ctor
end
| Some (q) -> begin
q
end)
in (

let iquals = if (FStar_List.contains FStar_Syntax_Syntax.Abstract iquals) then begin
(FStar_Syntax_Syntax.Private)::iquals
end else begin
iquals
end
in (

let _64_2052 = (FStar_Util.first_N n formals)
in (match (_64_2052) with
| (tps, rest) -> begin
(mk_indexed_projectors iquals fv_qual refine_domain env l lid inductive_tps tps rest cod)
end))))
end)
end)))
end
| _64_2054 -> begin
[]
end)
end))


let mk_typ_abbrev : FStar_Ident.lident  ->  FStar_Syntax_Syntax.univ_name Prims.list  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.term  ->  FStar_Ident.lident Prims.list  ->  FStar_Syntax_Syntax.qualifier Prims.list  ->  FStar_Range.range  ->  FStar_Syntax_Syntax.sigelt = (fun lid uvs typars k t lids quals rng -> (

let dd = if (FStar_All.pipe_right quals (FStar_List.contains FStar_Syntax_Syntax.Abstract)) then begin
(let _156_825 = (FStar_Syntax_Util.incr_delta_qualifier t)
in FStar_Syntax_Syntax.Delta_abstract (_156_825))
end else begin
(FStar_Syntax_Util.incr_delta_qualifier t)
end
in (

let lb = (let _156_830 = (let _156_826 = (FStar_Syntax_Syntax.lid_as_fv lid dd None)
in FStar_Util.Inr (_156_826))
in (let _156_829 = (let _156_827 = (FStar_Syntax_Syntax.mk_Total k)
in (FStar_Syntax_Util.arrow typars _156_827))
in (let _156_828 = (no_annot_abs typars t)
in {FStar_Syntax_Syntax.lbname = _156_830; FStar_Syntax_Syntax.lbunivs = uvs; FStar_Syntax_Syntax.lbtyp = _156_829; FStar_Syntax_Syntax.lbeff = FStar_Syntax_Const.effect_Tot_lid; FStar_Syntax_Syntax.lbdef = _156_828})))
in FStar_Syntax_Syntax.Sig_let (((((false), ((lb)::[]))), (rng), (lids), (quals))))))


let rec desugar_tycon : FStar_Parser_Env.env  ->  FStar_Range.range  ->  FStar_Syntax_Syntax.qualifier Prims.list  ->  FStar_Parser_AST.tycon Prims.list  ->  (env_t * FStar_Syntax_Syntax.sigelts) = (fun env rng quals tcs -> (

let tycon_id = (fun _64_13 -> (match (_64_13) with
| (FStar_Parser_AST.TyconAbstract (id, _, _)) | (FStar_Parser_AST.TyconAbbrev (id, _, _, _)) | (FStar_Parser_AST.TyconRecord (id, _, _, _)) | (FStar_Parser_AST.TyconVariant (id, _, _, _)) -> begin
id
end))
in (

let binder_to_term = (fun b -> (match (b.FStar_Parser_AST.b) with
| (FStar_Parser_AST.Annotated (x, _)) | (FStar_Parser_AST.Variable (x)) -> begin
(let _156_844 = (let _156_843 = (FStar_Ident.lid_of_ids ((x)::[]))
in FStar_Parser_AST.Var (_156_843))
in (FStar_Parser_AST.mk_term _156_844 x.FStar_Ident.idRange FStar_Parser_AST.Expr))
end
| (FStar_Parser_AST.TAnnotated (a, _)) | (FStar_Parser_AST.TVariable (a)) -> begin
(FStar_Parser_AST.mk_term (FStar_Parser_AST.Tvar (a)) a.FStar_Ident.idRange FStar_Parser_AST.Type)
end
| FStar_Parser_AST.NoName (t) -> begin
t
end))
in (

let tot = (FStar_Parser_AST.mk_term (FStar_Parser_AST.Name (FStar_Syntax_Const.effect_Tot_lid)) rng FStar_Parser_AST.Expr)
in (

let with_constructor_effect = (fun t -> (FStar_Parser_AST.mk_term (FStar_Parser_AST.App (((tot), (t), (FStar_Parser_AST.Nothing)))) t.FStar_Parser_AST.range t.FStar_Parser_AST.level))
in (

let apply_binders = (fun t binders -> (

let imp_of_aqual = (fun b -> (match (b.FStar_Parser_AST.aqual) with
| Some (FStar_Parser_AST.Implicit) -> begin
FStar_Parser_AST.Hash
end
| _64_2129 -> begin
FStar_Parser_AST.Nothing
end))
in (FStar_List.fold_left (fun out b -> (let _156_857 = (let _156_856 = (let _156_855 = (binder_to_term b)
in ((out), (_156_855), ((imp_of_aqual b))))
in FStar_Parser_AST.App (_156_856))
in (FStar_Parser_AST.mk_term _156_857 out.FStar_Parser_AST.range out.FStar_Parser_AST.level))) t binders)))
in (

let tycon_record_as_variant = (fun _64_14 -> (match (_64_14) with
| FStar_Parser_AST.TyconRecord (id, parms, kopt, fields) -> begin
(

let constrName = (FStar_Ident.mk_ident (((Prims.strcat "Mk" id.FStar_Ident.idText)), (id.FStar_Ident.idRange)))
in (

let mfields = (FStar_List.map (fun _64_2142 -> (match (_64_2142) with
| (x, t) -> begin
(FStar_Parser_AST.mk_binder (FStar_Parser_AST.Annotated ((((FStar_Syntax_Util.mangle_field_name x)), (t)))) x.FStar_Ident.idRange FStar_Parser_AST.Expr None)
end)) fields)
in (

let result = (let _156_863 = (let _156_862 = (let _156_861 = (FStar_Ident.lid_of_ids ((id)::[]))
in FStar_Parser_AST.Var (_156_861))
in (FStar_Parser_AST.mk_term _156_862 id.FStar_Ident.idRange FStar_Parser_AST.Type))
in (apply_binders _156_863 parms))
in (

let constrTyp = (FStar_Parser_AST.mk_term (FStar_Parser_AST.Product (((mfields), ((with_constructor_effect result))))) id.FStar_Ident.idRange FStar_Parser_AST.Type)
in (let _156_865 = (FStar_All.pipe_right fields (FStar_List.map (fun _64_2149 -> (match (_64_2149) with
| (x, _64_2148) -> begin
(FStar_Parser_Env.qualify env x)
end))))
in ((FStar_Parser_AST.TyconVariant (((id), (parms), (kopt), ((((constrName), (Some (constrTyp)), (false)))::[])))), (_156_865)))))))
end
| _64_2151 -> begin
(FStar_All.failwith "impossible")
end))
in (

let desugar_abstract_tc = (fun quals _env mutuals _64_15 -> (match (_64_15) with
| FStar_Parser_AST.TyconAbstract (id, binders, kopt) -> begin
(

let _64_2165 = (typars_of_binders _env binders)
in (match (_64_2165) with
| (_env', typars) -> begin
(

let k = (match (kopt) with
| None -> begin
FStar_Syntax_Util.ktype
end
| Some (k) -> begin
(desugar_term _env' k)
end)
in (

let tconstr = (let _156_876 = (let _156_875 = (let _156_874 = (FStar_Ident.lid_of_ids ((id)::[]))
in FStar_Parser_AST.Var (_156_874))
in (FStar_Parser_AST.mk_term _156_875 id.FStar_Ident.idRange FStar_Parser_AST.Type))
in (apply_binders _156_876 binders))
in (

let qlid = (FStar_Parser_Env.qualify _env id)
in (

let typars = (FStar_Syntax_Subst.close_binders typars)
in (

let k = (FStar_Syntax_Subst.close typars k)
in (

let se = FStar_Syntax_Syntax.Sig_inductive_typ (((qlid), ([]), (typars), (k), (mutuals), ([]), (quals), (rng)))
in (

let _env = (FStar_Parser_Env.push_top_level_rec_binding _env id FStar_Syntax_Syntax.Delta_constant)
in (

let _env2 = (FStar_Parser_Env.push_top_level_rec_binding _env' id FStar_Syntax_Syntax.Delta_constant)
in ((_env), (_env2), (se), (tconstr))))))))))
end))
end
| _64_2178 -> begin
(FStar_All.failwith "Unexpected tycon")
end))
in (

let push_tparams = (fun env bs -> (

let _64_2193 = (FStar_List.fold_left (fun _64_2184 _64_2187 -> (match (((_64_2184), (_64_2187))) with
| ((env, tps), (x, imp)) -> begin
(

let _64_2190 = (FStar_Parser_Env.push_bv env x.FStar_Syntax_Syntax.ppname)
in (match (_64_2190) with
| (env, y) -> begin
((env), ((((y), (imp)))::tps))
end))
end)) ((env), ([])) bs)
in (match (_64_2193) with
| (env, bs) -> begin
((env), ((FStar_List.rev bs)))
end)))
in (match (tcs) with
| (FStar_Parser_AST.TyconAbstract (id, bs, kopt))::[] -> begin
(

let kopt = (match (kopt) with
| None -> begin
(let _156_883 = (tm_type_z id.FStar_Ident.idRange)
in Some (_156_883))
end
| _64_2202 -> begin
kopt
end)
in (

let tc = FStar_Parser_AST.TyconAbstract (((id), (bs), (kopt)))
in (

let _64_2212 = (desugar_abstract_tc quals env [] tc)
in (match (_64_2212) with
| (_64_2206, _64_2208, se, _64_2211) -> begin
(

let se = (match (se) with
| FStar_Syntax_Syntax.Sig_inductive_typ (l, _64_2215, typars, k, [], [], quals, rng) -> begin
(

let quals = if (FStar_All.pipe_right quals (FStar_List.contains FStar_Syntax_Syntax.Assumption)) then begin
quals
end else begin
(

let _64_2224 = (let _156_885 = (FStar_Range.string_of_range rng)
in (let _156_884 = (FStar_Syntax_Print.lid_to_string l)
in (FStar_Util.print2 "%s (Warning): Adding an implicit \'assume new\' qualifier on %s\n" _156_885 _156_884)))
in (FStar_Syntax_Syntax.Assumption)::(FStar_Syntax_Syntax.New)::quals)
end
in (

let t = (match (typars) with
| [] -> begin
k
end
| _64_2229 -> begin
(let _156_888 = (let _156_887 = (let _156_886 = (FStar_Syntax_Syntax.mk_Total k)
in ((typars), (_156_886)))
in FStar_Syntax_Syntax.Tm_arrow (_156_887))
in (FStar_Syntax_Syntax.mk _156_888 None rng))
end)
in FStar_Syntax_Syntax.Sig_declare_typ (((l), ([]), (t), (quals), (rng)))))
end
| _64_2232 -> begin
se
end)
in (

let env = (FStar_Parser_Env.push_sigelt env se)
in ((env), ((se)::[]))))
end))))
end
| (FStar_Parser_AST.TyconAbbrev (id, binders, kopt, t))::[] -> begin
(

let _64_2244 = (typars_of_binders env binders)
in (match (_64_2244) with
| (env', typars) -> begin
(

let k = (match (kopt) with
| None -> begin
if (FStar_Util.for_some (fun _64_16 -> (match (_64_16) with
| FStar_Syntax_Syntax.Effect -> begin
true
end
| _64_2249 -> begin
false
end)) quals) then begin
FStar_Syntax_Syntax.teff
end else begin
FStar_Syntax_Syntax.tun
end
end
| Some (k) -> begin
(desugar_term env' k)
end)
in (

let t0 = t
in (

let quals = if (FStar_All.pipe_right quals (FStar_Util.for_some (fun _64_17 -> (match (_64_17) with
| FStar_Syntax_Syntax.Logic -> begin
true
end
| _64_2257 -> begin
false
end)))) then begin
quals
end else begin
if (t0.FStar_Parser_AST.level = FStar_Parser_AST.Formula) then begin
(FStar_Syntax_Syntax.Logic)::quals
end else begin
quals
end
end
in (

let se = if (FStar_All.pipe_right quals (FStar_List.contains FStar_Syntax_Syntax.Effect)) then begin
(

let c = (desugar_comp t.FStar_Parser_AST.range false env' t)
in (

let typars = (FStar_Syntax_Subst.close_binders typars)
in (

let c = (FStar_Syntax_Subst.close_comp typars c)
in (let _156_894 = (let _156_893 = (FStar_Parser_Env.qualify env id)
in (let _156_892 = (FStar_All.pipe_right quals (FStar_List.filter (fun _64_18 -> (match (_64_18) with
| FStar_Syntax_Syntax.Effect -> begin
false
end
| _64_2265 -> begin
true
end))))
in ((_156_893), ([]), (typars), (c), (_156_892), (rng))))
in FStar_Syntax_Syntax.Sig_effect_abbrev (_156_894)))))
end else begin
(

let t = (desugar_typ env' t)
in (

let nm = (FStar_Parser_Env.qualify env id)
in (mk_typ_abbrev nm [] typars k t ((nm)::[]) quals rng)))
end
in (

let env = (FStar_Parser_Env.push_sigelt env se)
in ((env), ((se)::[])))))))
end))
end
| (FStar_Parser_AST.TyconRecord (_64_2271))::[] -> begin
(

let trec = (FStar_List.hd tcs)
in (

let _64_2277 = (tycon_record_as_variant trec)
in (match (_64_2277) with
| (t, fs) -> begin
(desugar_tycon env rng ((FStar_Syntax_Syntax.RecordType (fs))::quals) ((t)::[]))
end)))
end
| (_64_2281)::_64_2279 -> begin
(

let env0 = env
in (

let mutuals = (FStar_List.map (fun x -> (FStar_All.pipe_left (FStar_Parser_Env.qualify env) (tycon_id x))) tcs)
in (

let rec collect_tcs = (fun quals et tc -> (

let _64_2292 = et
in (match (_64_2292) with
| (env, tcs) -> begin
(match (tc) with
| FStar_Parser_AST.TyconRecord (_64_2294) -> begin
(

let trec = tc
in (

let _64_2299 = (tycon_record_as_variant trec)
in (match (_64_2299) with
| (t, fs) -> begin
(collect_tcs ((FStar_Syntax_Syntax.RecordType (fs))::quals) ((env), (tcs)) t)
end)))
end
| FStar_Parser_AST.TyconVariant (id, binders, kopt, constructors) -> begin
(

let _64_2311 = (desugar_abstract_tc quals env mutuals (FStar_Parser_AST.TyconAbstract (((id), (binders), (kopt)))))
in (match (_64_2311) with
| (env, _64_2308, se, tconstr) -> begin
((env), ((FStar_Util.Inl (((se), (constructors), (tconstr), (quals))))::tcs))
end))
end
| FStar_Parser_AST.TyconAbbrev (id, binders, kopt, t) -> begin
(

let _64_2323 = (desugar_abstract_tc quals env mutuals (FStar_Parser_AST.TyconAbstract (((id), (binders), (kopt)))))
in (match (_64_2323) with
| (env, _64_2320, se, tconstr) -> begin
((env), ((FStar_Util.Inr (((se), (t), (quals))))::tcs))
end))
end
| _64_2325 -> begin
(FStar_All.failwith "Unrecognized mutual type definition")
end)
end)))
in (

let _64_2328 = (FStar_List.fold_left (collect_tcs quals) ((env), ([])) tcs)
in (match (_64_2328) with
| (env, tcs) -> begin
(

let tcs = (FStar_List.rev tcs)
in (

let tps_sigelts = (FStar_All.pipe_right tcs (FStar_List.collect (fun _64_20 -> (match (_64_20) with
| FStar_Util.Inr (FStar_Syntax_Syntax.Sig_inductive_typ (id, uvs, tpars, k, _64_2336, _64_2338, _64_2340, _64_2342), t, quals) -> begin
(

let _64_2352 = (push_tparams env tpars)
in (match (_64_2352) with
| (env_tps, _64_2351) -> begin
(

let t = (desugar_term env_tps t)
in (let _156_904 = (let _156_903 = (mk_typ_abbrev id uvs tpars k t ((id)::[]) quals rng)
in (([]), (_156_903)))
in (_156_904)::[]))
end))
end
| FStar_Util.Inl (FStar_Syntax_Syntax.Sig_inductive_typ (tname, univs, tpars, k, mutuals, _64_2360, tags, _64_2363), constrs, tconstr, quals) -> begin
(

let tycon = ((tname), (tpars), (k))
in (

let _64_2374 = (push_tparams env tpars)
in (match (_64_2374) with
| (env_tps, tps) -> begin
(

let data_tpars = (FStar_List.map (fun _64_2378 -> (match (_64_2378) with
| (x, _64_2377) -> begin
((x), (Some (FStar_Syntax_Syntax.Implicit (true))))
end)) tps)
in (

let _64_2402 = (let _156_916 = (FStar_All.pipe_right constrs (FStar_List.map (fun _64_2383 -> (match (_64_2383) with
| (id, topt, of_notation) -> begin
(

let t = if of_notation then begin
(match (topt) with
| Some (t) -> begin
(FStar_Parser_AST.mk_term (FStar_Parser_AST.Product (((((FStar_Parser_AST.mk_binder (FStar_Parser_AST.NoName (t)) t.FStar_Parser_AST.range t.FStar_Parser_AST.level None))::[]), (tconstr)))) t.FStar_Parser_AST.range t.FStar_Parser_AST.level)
end
| None -> begin
tconstr
end)
end else begin
(match (topt) with
| None -> begin
(FStar_All.failwith "Impossible")
end
| Some (t) -> begin
t
end)
end
in (

let t = (let _156_908 = (FStar_Parser_Env.default_total env_tps)
in (let _156_907 = (close env_tps t)
in (desugar_term _156_908 _156_907)))
in (

let name = (FStar_Parser_Env.qualify env id)
in (

let quals = (FStar_All.pipe_right tags (FStar_List.collect (fun _64_19 -> (match (_64_19) with
| FStar_Syntax_Syntax.RecordType (fns) -> begin
(FStar_Syntax_Syntax.RecordConstructor (fns))::[]
end
| _64_2397 -> begin
[]
end))))
in (

let ntps = (FStar_List.length data_tpars)
in (let _156_915 = (let _156_914 = (let _156_913 = (let _156_912 = (let _156_911 = (let _156_910 = (FStar_All.pipe_right t FStar_Syntax_Util.name_function_binders)
in (FStar_Syntax_Syntax.mk_Total _156_910))
in (FStar_Syntax_Util.arrow data_tpars _156_911))
in ((name), (univs), (_156_912), (tname), (ntps), (quals), (mutuals), (rng)))
in FStar_Syntax_Syntax.Sig_datacon (_156_913))
in ((tps), (_156_914)))
in ((name), (_156_915))))))))
end))))
in (FStar_All.pipe_left FStar_List.split _156_916))
in (match (_64_2402) with
| (constrNames, constrs) -> begin
((([]), (FStar_Syntax_Syntax.Sig_inductive_typ (((tname), (univs), (tpars), (k), (mutuals), (constrNames), (tags), (rng))))))::constrs
end)))
end)))
end
| _64_2404 -> begin
(FStar_All.failwith "impossible")
end))))
in (

let sigelts = (FStar_All.pipe_right tps_sigelts (FStar_List.map Prims.snd))
in (

let bundle = (let _156_918 = (let _156_917 = (FStar_List.collect FStar_Syntax_Util.lids_of_sigelt sigelts)
in ((sigelts), (quals), (_156_917), (rng)))
in FStar_Syntax_Syntax.Sig_bundle (_156_918))
in (

let env = (FStar_Parser_Env.push_sigelt env0 bundle)
in (

let data_ops = (FStar_All.pipe_right tps_sigelts (FStar_List.collect (mk_data_projectors quals env)))
in (

let discs = (FStar_All.pipe_right sigelts (FStar_List.collect (fun _64_21 -> (match (_64_21) with
| FStar_Syntax_Syntax.Sig_inductive_typ (tname, _64_2413, tps, k, _64_2417, constrs, quals, _64_2421) when ((FStar_List.length constrs) > 1) -> begin
(

let quals = if (FStar_List.contains FStar_Syntax_Syntax.Abstract quals) then begin
(FStar_Syntax_Syntax.Private)::quals
end else begin
quals
end
in (mk_data_discriminators quals env tname tps k constrs))
end
| _64_2426 -> begin
[]
end))))
in (

let ops = (FStar_List.append discs data_ops)
in (

let env = (FStar_List.fold_left FStar_Parser_Env.push_sigelt env ops)
in ((env), ((FStar_List.append ((bundle)::[]) ops))))))))))))
end)))))
end
| [] -> begin
(FStar_All.failwith "impossible")
end))))))))))


let desugar_binders : FStar_Parser_Env.env  ->  FStar_Parser_AST.binder Prims.list  ->  (FStar_Parser_Env.env * FStar_Syntax_Syntax.binder Prims.list) = (fun env binders -> (

let _64_2450 = (FStar_List.fold_left (fun _64_2435 b -> (match (_64_2435) with
| (env, binders) -> begin
(match ((desugar_binder env b)) with
| (Some (a), k) -> begin
(

let _64_2443 = (FStar_Parser_Env.push_bv env a)
in (match (_64_2443) with
| (env, a) -> begin
(let _156_927 = (let _156_926 = (FStar_Syntax_Syntax.mk_binder (

let _64_2444 = a
in {FStar_Syntax_Syntax.ppname = _64_2444.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _64_2444.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = k}))
in (_156_926)::binders)
in ((env), (_156_927)))
end))
end
| _64_2447 -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Missing name in binder"), (b.FStar_Parser_AST.brange)))))
end)
end)) ((env), ([])) binders)
in (match (_64_2450) with
| (env, binders) -> begin
((env), ((FStar_List.rev binders)))
end)))


let rec desugar_effect : FStar_Parser_Env.env  ->  FStar_Parser_AST.decl  ->  FStar_Parser_AST.qualifiers  ->  FStar_Ident.ident  ->  FStar_Parser_AST.binder Prims.list  ->  FStar_Parser_AST.term  ->  FStar_Parser_AST.decl Prims.list  ->  FStar_Parser_AST.decl Prims.list  ->  Prims.bool  ->  (FStar_Parser_Env.env * FStar_Syntax_Syntax.sigelt Prims.list) = (fun env d quals eff_name eff_binders eff_kind eff_decls actions for_free -> (

let env0 = env
in (

let monad_env = (FStar_Parser_Env.enter_monad_scope env eff_name)
in (

let _64_2464 = (desugar_binders monad_env eff_binders)
in (match (_64_2464) with
| (env, binders) -> begin
(

let eff_k = (let _156_948 = (FStar_Parser_Env.default_total env)
in (desugar_term _156_948 eff_kind))
in (

let _64_2475 = (FStar_All.pipe_right eff_decls (FStar_List.fold_left (fun _64_2468 decl -> (match (_64_2468) with
| (env, out) -> begin
(

let _64_2472 = (desugar_decl env decl)
in (match (_64_2472) with
| (env, ses) -> begin
(let _156_952 = (let _156_951 = (FStar_List.hd ses)
in (_156_951)::out)
in ((env), (_156_952)))
end))
end)) ((env), ([]))))
in (match (_64_2475) with
| (env, decls) -> begin
(

let actions = (FStar_All.pipe_right actions (FStar_List.map (fun d -> (match (d.FStar_Parser_AST.d) with
| FStar_Parser_AST.Tycon (_64_2478, (FStar_Parser_AST.TyconAbbrev (name, _64_2481, _64_2483, {FStar_Parser_AST.tm = FStar_Parser_AST.Construct (_64_2489, ((def, _64_2496))::((cps_type, _64_2492))::[]); FStar_Parser_AST.range = _64_2487; FStar_Parser_AST.level = _64_2485}))::[]) when (not (for_free)) -> begin
(let _156_956 = (FStar_Parser_Env.qualify env name)
in (let _156_955 = (desugar_term env def)
in (let _156_954 = (desugar_typ env cps_type)
in {FStar_Syntax_Syntax.action_name = _156_956; FStar_Syntax_Syntax.action_univs = []; FStar_Syntax_Syntax.action_defn = _156_955; FStar_Syntax_Syntax.action_typ = _156_954})))
end
| FStar_Parser_AST.Tycon (_64_2508, (FStar_Parser_AST.TyconAbbrev (name, _64_2511, _64_2513, defn))::[]) when for_free -> begin
(let _156_958 = (FStar_Parser_Env.qualify env name)
in (let _156_957 = (desugar_term env defn)
in {FStar_Syntax_Syntax.action_name = _156_958; FStar_Syntax_Syntax.action_univs = []; FStar_Syntax_Syntax.action_defn = _156_957; FStar_Syntax_Syntax.action_typ = FStar_Syntax_Syntax.tun}))
end
| _64_2521 -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Malformed action declaration; if this is an \"effect for free\", just provide the direct-style declaration. If this is not an \"effect for free\", please provide a pair of the definition and its cps-type with arrows inserted in the right place (see examples)."), (d.FStar_Parser_AST.drange)))))
end))))
in (

let binders = (FStar_Syntax_Subst.close_binders binders)
in (

let eff_k = (FStar_Syntax_Subst.close binders eff_k)
in (

let lookup = (fun s -> (

let l = (FStar_Parser_Env.qualify env (FStar_Ident.mk_ident ((s), (d.FStar_Parser_AST.drange))))
in (let _156_962 = (let _156_961 = (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_definition env) l)
in (FStar_All.pipe_left (FStar_Syntax_Subst.close binders) _156_961))
in (([]), (_156_962)))))
in (

let mname = (FStar_Parser_Env.qualify env0 eff_name)
in (

let qualifiers = (FStar_List.map (trans_qual d.FStar_Parser_AST.drange) quals)
in (

let se = if for_free then begin
(

let dummy_tscheme = (let _156_963 = (FStar_Syntax_Syntax.mk FStar_Syntax_Syntax.Tm_unknown None FStar_Range.dummyRange)
in (([]), (_156_963)))
in (let _156_969 = (let _156_968 = (let _156_967 = (let _156_964 = (lookup "repr")
in (Prims.snd _156_964))
in (let _156_966 = (lookup "return")
in (let _156_965 = (lookup "bind")
in {FStar_Syntax_Syntax.qualifiers = qualifiers; FStar_Syntax_Syntax.mname = mname; FStar_Syntax_Syntax.univs = []; FStar_Syntax_Syntax.binders = binders; FStar_Syntax_Syntax.signature = eff_k; FStar_Syntax_Syntax.ret_wp = dummy_tscheme; FStar_Syntax_Syntax.bind_wp = dummy_tscheme; FStar_Syntax_Syntax.if_then_else = dummy_tscheme; FStar_Syntax_Syntax.ite_wp = dummy_tscheme; FStar_Syntax_Syntax.stronger = dummy_tscheme; FStar_Syntax_Syntax.close_wp = dummy_tscheme; FStar_Syntax_Syntax.assert_p = dummy_tscheme; FStar_Syntax_Syntax.assume_p = dummy_tscheme; FStar_Syntax_Syntax.null_wp = dummy_tscheme; FStar_Syntax_Syntax.trivial = dummy_tscheme; FStar_Syntax_Syntax.repr = _156_967; FStar_Syntax_Syntax.return_repr = _156_966; FStar_Syntax_Syntax.bind_repr = _156_965; FStar_Syntax_Syntax.actions = actions})))
in ((_156_968), (d.FStar_Parser_AST.drange)))
in FStar_Syntax_Syntax.Sig_new_effect_for_free (_156_969)))
end else begin
(

let rr = ((FStar_All.pipe_right qualifiers (FStar_List.contains FStar_Syntax_Syntax.Reifiable)) || (FStar_All.pipe_right qualifiers (FStar_List.contains FStar_Syntax_Syntax.Reflectable)))
in (

let un_ts = (([]), (FStar_Syntax_Syntax.tun))
in (let _156_985 = (let _156_984 = (let _156_983 = (lookup "return_wp")
in (let _156_982 = (lookup "bind_wp")
in (let _156_981 = (lookup "if_then_else")
in (let _156_980 = (lookup "ite_wp")
in (let _156_979 = (lookup "stronger")
in (let _156_978 = (lookup "close_wp")
in (let _156_977 = (lookup "assert_p")
in (let _156_976 = (lookup "assume_p")
in (let _156_975 = (lookup "null_wp")
in (let _156_974 = (lookup "trivial")
in (let _156_973 = if rr then begin
(let _156_970 = (lookup "repr")
in (FStar_All.pipe_left Prims.snd _156_970))
end else begin
FStar_Syntax_Syntax.tun
end
in (let _156_972 = if rr then begin
(lookup "return")
end else begin
un_ts
end
in (let _156_971 = if rr then begin
(lookup "bind")
end else begin
un_ts
end
in {FStar_Syntax_Syntax.qualifiers = qualifiers; FStar_Syntax_Syntax.mname = mname; FStar_Syntax_Syntax.univs = []; FStar_Syntax_Syntax.binders = binders; FStar_Syntax_Syntax.signature = eff_k; FStar_Syntax_Syntax.ret_wp = _156_983; FStar_Syntax_Syntax.bind_wp = _156_982; FStar_Syntax_Syntax.if_then_else = _156_981; FStar_Syntax_Syntax.ite_wp = _156_980; FStar_Syntax_Syntax.stronger = _156_979; FStar_Syntax_Syntax.close_wp = _156_978; FStar_Syntax_Syntax.assert_p = _156_977; FStar_Syntax_Syntax.assume_p = _156_976; FStar_Syntax_Syntax.null_wp = _156_975; FStar_Syntax_Syntax.trivial = _156_974; FStar_Syntax_Syntax.repr = _156_973; FStar_Syntax_Syntax.return_repr = _156_972; FStar_Syntax_Syntax.bind_repr = _156_971; FStar_Syntax_Syntax.actions = actions})))))))))))))
in ((_156_984), (d.FStar_Parser_AST.drange)))
in FStar_Syntax_Syntax.Sig_new_effect (_156_985))))
end
in (

let env = (FStar_Parser_Env.push_sigelt env0 se)
in (

let env = (FStar_All.pipe_right actions (FStar_List.fold_left (fun env a -> (let _156_988 = (FStar_Syntax_Util.action_as_lb a)
in (FStar_Parser_Env.push_sigelt env _156_988))) env))
in (

let env = if (FStar_All.pipe_right quals (FStar_List.contains FStar_Parser_AST.Reflectable)) then begin
(

let reflect_lid = (FStar_All.pipe_right (FStar_Ident.id_of_text "reflect") (FStar_Parser_Env.qualify monad_env))
in (

let refl_decl = FStar_Syntax_Syntax.Sig_declare_typ (((reflect_lid), ([]), (FStar_Syntax_Syntax.tun), ((FStar_Syntax_Syntax.Assumption)::(FStar_Syntax_Syntax.Reflectable)::[]), (d.FStar_Parser_AST.drange)))
in (FStar_Parser_Env.push_sigelt env refl_decl)))
end else begin
env
end
in ((env), ((se)::[]))))))))))))
end)))
end)))))
and desugar_decl : env_t  ->  FStar_Parser_AST.decl  ->  (env_t * FStar_Syntax_Syntax.sigelts) = (fun env d -> (

let trans_qual = (trans_qual d.FStar_Parser_AST.drange)
in (match (d.FStar_Parser_AST.d) with
| FStar_Parser_AST.Pragma (p) -> begin
(

let se = FStar_Syntax_Syntax.Sig_pragma ((((trans_pragma p)), (d.FStar_Parser_AST.drange)))
in ((env), ((se)::[])))
end
| FStar_Parser_AST.TopLevelModule (_64_2548) -> begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Multiple modules in a file are no longer supported"), (d.FStar_Parser_AST.drange)))))
end
| FStar_Parser_AST.Open (lid) -> begin
(

let env = (FStar_Parser_Env.push_namespace env lid)
in ((env), ([])))
end
| FStar_Parser_AST.ModuleAbbrev (x, l) -> begin
(let _156_992 = (FStar_Parser_Env.push_module_abbrev env x l)
in ((_156_992), ([])))
end
| FStar_Parser_AST.Tycon (qual, tcs) -> begin
(let _156_993 = (FStar_List.map trans_qual qual)
in (desugar_tycon env d.FStar_Parser_AST.drange _156_993 tcs))
end
| FStar_Parser_AST.ToplevelLet (quals, isrec, lets) -> begin
(match ((let _156_995 = (let _156_994 = (desugar_term_maybe_top true env (FStar_Parser_AST.mk_term (FStar_Parser_AST.Let (((isrec), (lets), ((FStar_Parser_AST.mk_term (FStar_Parser_AST.Const (FStar_Const.Const_unit)) d.FStar_Parser_AST.drange FStar_Parser_AST.Expr))))) d.FStar_Parser_AST.drange FStar_Parser_AST.Expr))
in (FStar_All.pipe_left FStar_Syntax_Subst.compress _156_994))
in _156_995.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_let (lbs, _64_2568) -> begin
(

let fvs = (FStar_All.pipe_right (Prims.snd lbs) (FStar_List.map (fun lb -> (FStar_Util.right lb.FStar_Syntax_Syntax.lbname))))
in (

let quals = (match (quals) with
| (_64_2576)::_64_2574 -> begin
(FStar_List.map trans_qual quals)
end
| _64_2579 -> begin
(FStar_All.pipe_right (Prims.snd lbs) (FStar_List.collect (fun _64_22 -> (match (_64_22) with
| {FStar_Syntax_Syntax.lbname = FStar_Util.Inl (_64_2590); FStar_Syntax_Syntax.lbunivs = _64_2588; FStar_Syntax_Syntax.lbtyp = _64_2586; FStar_Syntax_Syntax.lbeff = _64_2584; FStar_Syntax_Syntax.lbdef = _64_2582} -> begin
[]
end
| {FStar_Syntax_Syntax.lbname = FStar_Util.Inr (fv); FStar_Syntax_Syntax.lbunivs = _64_2600; FStar_Syntax_Syntax.lbtyp = _64_2598; FStar_Syntax_Syntax.lbeff = _64_2596; FStar_Syntax_Syntax.lbdef = _64_2594} -> begin
(FStar_Parser_Env.lookup_letbinding_quals env fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
end))))
end)
in (

let quals = if (FStar_All.pipe_right lets (FStar_Util.for_some (fun _64_2608 -> (match (_64_2608) with
| (_64_2606, t) -> begin
(t.FStar_Parser_AST.level = FStar_Parser_AST.Formula)
end)))) then begin
(FStar_Syntax_Syntax.Logic)::quals
end else begin
quals
end
in (

let lbs = if (FStar_All.pipe_right quals (FStar_List.contains FStar_Syntax_Syntax.Abstract)) then begin
(let _156_1000 = (FStar_All.pipe_right (Prims.snd lbs) (FStar_List.map (fun lb -> (

let fv = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (

let _64_2612 = lb
in {FStar_Syntax_Syntax.lbname = FStar_Util.Inr ((

let _64_2614 = fv
in {FStar_Syntax_Syntax.fv_name = _64_2614.FStar_Syntax_Syntax.fv_name; FStar_Syntax_Syntax.fv_delta = FStar_Syntax_Syntax.Delta_abstract (fv.FStar_Syntax_Syntax.fv_delta); FStar_Syntax_Syntax.fv_qual = _64_2614.FStar_Syntax_Syntax.fv_qual})); FStar_Syntax_Syntax.lbunivs = _64_2612.FStar_Syntax_Syntax.lbunivs; FStar_Syntax_Syntax.lbtyp = _64_2612.FStar_Syntax_Syntax.lbtyp; FStar_Syntax_Syntax.lbeff = _64_2612.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = _64_2612.FStar_Syntax_Syntax.lbdef})))))
in (((Prims.fst lbs)), (_156_1000)))
end else begin
lbs
end
in (

let s = (let _156_1003 = (let _156_1002 = (FStar_All.pipe_right fvs (FStar_List.map (fun fv -> fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)))
in ((lbs), (d.FStar_Parser_AST.drange), (_156_1002), (quals)))
in FStar_Syntax_Syntax.Sig_let (_156_1003))
in (

let env = (FStar_Parser_Env.push_sigelt env s)
in ((env), ((s)::[]))))))))
end
| _64_2621 -> begin
(FStar_All.failwith "Desugaring a let did not produce a let")
end)
end
| FStar_Parser_AST.Main (t) -> begin
(

let e = (desugar_term env t)
in (

let se = FStar_Syntax_Syntax.Sig_main (((e), (d.FStar_Parser_AST.drange)))
in ((env), ((se)::[]))))
end
| FStar_Parser_AST.Assume (atag, id, t) -> begin
(

let f = (desugar_formula env t)
in (let _156_1007 = (let _156_1006 = (let _156_1005 = (let _156_1004 = (FStar_Parser_Env.qualify env id)
in ((_156_1004), (f), ((FStar_Syntax_Syntax.Assumption)::[]), (d.FStar_Parser_AST.drange)))
in FStar_Syntax_Syntax.Sig_assume (_156_1005))
in (_156_1006)::[])
in ((env), (_156_1007))))
end
| FStar_Parser_AST.Val (quals, id, t) -> begin
(

let t = (let _156_1008 = (close_fun env t)
in (desugar_term env _156_1008))
in (

let quals = if (env.FStar_Parser_Env.iface && env.FStar_Parser_Env.admitted_iface) then begin
(FStar_Parser_AST.Assumption)::quals
end else begin
quals
end
in (

let se = (let _156_1011 = (let _156_1010 = (FStar_Parser_Env.qualify env id)
in (let _156_1009 = (FStar_List.map trans_qual quals)
in ((_156_1010), ([]), (t), (_156_1009), (d.FStar_Parser_AST.drange))))
in FStar_Syntax_Syntax.Sig_declare_typ (_156_1011))
in (

let env = (FStar_Parser_Env.push_sigelt env se)
in ((env), ((se)::[]))))))
end
| FStar_Parser_AST.Exception (id, None) -> begin
(

let _64_2648 = (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_lid env) FStar_Syntax_Const.exn_lid)
in (match (_64_2648) with
| (t, _64_2647) -> begin
(

let l = (FStar_Parser_Env.qualify env id)
in (

let se = FStar_Syntax_Syntax.Sig_datacon (((l), ([]), (t), (FStar_Syntax_Const.exn_lid), (0), ((FStar_Syntax_Syntax.ExceptionConstructor)::[]), ((FStar_Syntax_Const.exn_lid)::[]), (d.FStar_Parser_AST.drange)))
in (

let se' = FStar_Syntax_Syntax.Sig_bundle ((((se)::[]), ((FStar_Syntax_Syntax.ExceptionConstructor)::[]), ((l)::[]), (d.FStar_Parser_AST.drange)))
in (

let env = (FStar_Parser_Env.push_sigelt env se')
in (

let data_ops = (mk_data_projectors [] env (([]), (se)))
in (

let discs = (mk_data_discriminators [] env FStar_Syntax_Const.exn_lid [] FStar_Syntax_Syntax.tun ((l)::[]))
in (

let env = (FStar_List.fold_left FStar_Parser_Env.push_sigelt env (FStar_List.append discs data_ops))
in ((env), ((FStar_List.append ((se')::discs) data_ops))))))))))
end))
end
| FStar_Parser_AST.Exception (id, Some (term)) -> begin
(

let t = (desugar_term env term)
in (

let t = (let _156_1016 = (let _156_1012 = (FStar_Syntax_Syntax.null_binder t)
in (_156_1012)::[])
in (let _156_1015 = (let _156_1014 = (let _156_1013 = (FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_lid env) FStar_Syntax_Const.exn_lid)
in (Prims.fst _156_1013))
in (FStar_All.pipe_left FStar_Syntax_Syntax.mk_Total _156_1014))
in (FStar_Syntax_Util.arrow _156_1016 _156_1015)))
in (

let l = (FStar_Parser_Env.qualify env id)
in (

let se = FStar_Syntax_Syntax.Sig_datacon (((l), ([]), (t), (FStar_Syntax_Const.exn_lid), (0), ((FStar_Syntax_Syntax.ExceptionConstructor)::[]), ((FStar_Syntax_Const.exn_lid)::[]), (d.FStar_Parser_AST.drange)))
in (

let se' = FStar_Syntax_Syntax.Sig_bundle ((((se)::[]), ((FStar_Syntax_Syntax.ExceptionConstructor)::[]), ((l)::[]), (d.FStar_Parser_AST.drange)))
in (

let env = (FStar_Parser_Env.push_sigelt env se')
in (

let data_ops = (mk_data_projectors [] env (([]), (se)))
in (

let discs = (mk_data_discriminators [] env FStar_Syntax_Const.exn_lid [] FStar_Syntax_Syntax.tun ((l)::[]))
in (

let env = (FStar_List.fold_left FStar_Parser_Env.push_sigelt env (FStar_List.append discs data_ops))
in ((env), ((FStar_List.append ((se')::discs) data_ops))))))))))))
end
| FStar_Parser_AST.KindAbbrev (id, binders, k) -> begin
(

let _64_2677 = (desugar_binders env binders)
in (match (_64_2677) with
| (env_k, binders) -> begin
(

let k = (desugar_term env_k k)
in (

let name = (FStar_Parser_Env.qualify env id)
in (

let se = (mk_typ_abbrev name [] binders FStar_Syntax_Syntax.tun k ((name)::[]) [] d.FStar_Parser_AST.drange)
in (

let env = (FStar_Parser_Env.push_sigelt env se)
in ((env), ((se)::[]))))))
end))
end
| FStar_Parser_AST.NewEffect (quals, FStar_Parser_AST.RedefineEffect (eff_name, eff_binders, defn)) -> begin
(

let env0 = env
in (

let _64_2693 = (desugar_binders env eff_binders)
in (match (_64_2693) with
| (env, binders) -> begin
(

let _64_2704 = (

let _64_2696 = (head_and_args defn)
in (match (_64_2696) with
| (head, args) -> begin
(

let ed = (match (head.FStar_Parser_AST.tm) with
| FStar_Parser_AST.Name (l) -> begin
(FStar_Parser_Env.fail_or env (FStar_Parser_Env.try_lookup_effect_defn env) l)
end
| _64_2700 -> begin
(let _156_1021 = (let _156_1020 = (let _156_1019 = (let _156_1018 = (let _156_1017 = (FStar_Parser_AST.term_to_string head)
in (Prims.strcat _156_1017 " not found"))
in (Prims.strcat "Effect " _156_1018))
in ((_156_1019), (d.FStar_Parser_AST.drange)))
in FStar_Syntax_Syntax.Error (_156_1020))
in (Prims.raise _156_1021))
end)
in (let _156_1022 = (desugar_args env args)
in ((ed), (_156_1022))))
end))
in (match (_64_2704) with
| (ed, args) -> begin
(

let binders = (FStar_Syntax_Subst.close_binders binders)
in (

let sub = (fun _64_2710 -> (match (_64_2710) with
| (_64_2708, x) -> begin
(

let _64_2713 = (FStar_Syntax_Subst.open_term ed.FStar_Syntax_Syntax.binders x)
in (match (_64_2713) with
| (edb, x) -> begin
(

let _64_2714 = if ((FStar_List.length args) <> (FStar_List.length edb)) then begin
(Prims.raise (FStar_Syntax_Syntax.Error ((("Unexpected number of arguments to effect constructor"), (defn.FStar_Parser_AST.range)))))
end else begin
()
end
in (

let s = (FStar_Syntax_Util.subst_of_list edb args)
in (let _156_1026 = (let _156_1025 = (FStar_Syntax_Subst.subst s x)
in (FStar_Syntax_Subst.close binders _156_1025))
in (([]), (_156_1026)))))
end))
end))
in (

let ed = (let _156_1040 = (FStar_List.map trans_qual quals)
in (let _156_1039 = (FStar_Parser_Env.qualify env0 eff_name)
in (let _156_1038 = (let _156_1027 = (sub (([]), (ed.FStar_Syntax_Syntax.signature)))
in (Prims.snd _156_1027))
in (let _156_1037 = (sub ed.FStar_Syntax_Syntax.ret_wp)
in (let _156_1036 = (sub ed.FStar_Syntax_Syntax.bind_wp)
in (let _156_1035 = (sub ed.FStar_Syntax_Syntax.if_then_else)
in (let _156_1034 = (sub ed.FStar_Syntax_Syntax.ite_wp)
in (let _156_1033 = (sub ed.FStar_Syntax_Syntax.stronger)
in (let _156_1032 = (sub ed.FStar_Syntax_Syntax.close_wp)
in (let _156_1031 = (sub ed.FStar_Syntax_Syntax.assert_p)
in (let _156_1030 = (sub ed.FStar_Syntax_Syntax.assume_p)
in (let _156_1029 = (sub ed.FStar_Syntax_Syntax.null_wp)
in (let _156_1028 = (sub ed.FStar_Syntax_Syntax.trivial)
in {FStar_Syntax_Syntax.qualifiers = _156_1040; FStar_Syntax_Syntax.mname = _156_1039; FStar_Syntax_Syntax.univs = []; FStar_Syntax_Syntax.binders = binders; FStar_Syntax_Syntax.signature = _156_1038; FStar_Syntax_Syntax.ret_wp = _156_1037; FStar_Syntax_Syntax.bind_wp = _156_1036; FStar_Syntax_Syntax.if_then_else = _156_1035; FStar_Syntax_Syntax.ite_wp = _156_1034; FStar_Syntax_Syntax.stronger = _156_1033; FStar_Syntax_Syntax.close_wp = _156_1032; FStar_Syntax_Syntax.assert_p = _156_1031; FStar_Syntax_Syntax.assume_p = _156_1030; FStar_Syntax_Syntax.null_wp = _156_1029; FStar_Syntax_Syntax.trivial = _156_1028; FStar_Syntax_Syntax.repr = FStar_Syntax_Syntax.tun; FStar_Syntax_Syntax.return_repr = (([]), (FStar_Syntax_Syntax.tun)); FStar_Syntax_Syntax.bind_repr = (([]), (FStar_Syntax_Syntax.tun)); FStar_Syntax_Syntax.actions = []})))))))))))))
in (

let se = FStar_Syntax_Syntax.Sig_new_effect (((ed), (d.FStar_Parser_AST.drange)))
in (

let env = (FStar_Parser_Env.push_sigelt env0 se)
in ((env), ((se)::[])))))))
end))
end)))
end
| FStar_Parser_AST.NewEffectForFree (_64_2721, FStar_Parser_AST.RedefineEffect (_64_2723)) -> begin
(FStar_All.failwith "impossible")
end
| FStar_Parser_AST.NewEffectForFree (quals, FStar_Parser_AST.DefineEffect (eff_name, eff_binders, eff_kind, eff_decls, actions)) -> begin
(desugar_effect env d quals eff_name eff_binders eff_kind eff_decls actions true)
end
| FStar_Parser_AST.NewEffect (quals, FStar_Parser_AST.DefineEffect (eff_name, eff_binders, eff_kind, eff_decls, actions)) -> begin
(desugar_effect env d quals eff_name eff_binders eff_kind eff_decls actions false)
end
| FStar_Parser_AST.SubEffect (l) -> begin
(

let lookup = (fun l -> (match ((FStar_Parser_Env.try_lookup_effect_name env l)) with
| None -> begin
(let _156_1047 = (let _156_1046 = (let _156_1045 = (let _156_1044 = (let _156_1043 = (FStar_Syntax_Print.lid_to_string l)
in (Prims.strcat _156_1043 " not found"))
in (Prims.strcat "Effect name " _156_1044))
in ((_156_1045), (d.FStar_Parser_AST.drange)))
in FStar_Syntax_Syntax.Error (_156_1046))
in (Prims.raise _156_1047))
end
| Some (l) -> begin
l
end))
in (

let src = (lookup l.FStar_Parser_AST.msource)
in (

let dst = (lookup l.FStar_Parser_AST.mdest)
in (

let _64_2764 = (match (l.FStar_Parser_AST.lift_op) with
| FStar_Parser_AST.NonReifiableLift (t) -> begin
(let _156_1049 = (let _156_1048 = (desugar_term env t)
in (([]), (_156_1048)))
in ((_156_1049), (None)))
end
| FStar_Parser_AST.ReifiableLift (wp, t) -> begin
(let _156_1054 = (let _156_1050 = (desugar_term env wp)
in (([]), (_156_1050)))
in (let _156_1053 = (let _156_1052 = (let _156_1051 = (desugar_term env t)
in (([]), (_156_1051)))
in Some (_156_1052))
in ((_156_1054), (_156_1053))))
end)
in (match (_64_2764) with
| (lift_wp, lift) -> begin
(

let se = FStar_Syntax_Syntax.Sig_sub_effect ((({FStar_Syntax_Syntax.source = src; FStar_Syntax_Syntax.target = dst; FStar_Syntax_Syntax.lift_wp = lift_wp; FStar_Syntax_Syntax.lift = lift}), (d.FStar_Parser_AST.drange)))
in ((env), ((se)::[])))
end)))))
end)))


let desugar_decls : FStar_Parser_Env.env  ->  FStar_Parser_AST.decl Prims.list  ->  (FStar_Parser_Env.env * FStar_Syntax_Syntax.sigelts) = (fun env decls -> (FStar_List.fold_left (fun _64_2770 d -> (match (_64_2770) with
| (env, sigelts) -> begin
(

let _64_2774 = (desugar_decl env d)
in (match (_64_2774) with
| (env, se) -> begin
((env), ((FStar_List.append sigelts se)))
end))
end)) ((env), ([])) decls))


let open_prims_all : FStar_Parser_AST.decl Prims.list = ((FStar_Parser_AST.mk_decl (FStar_Parser_AST.Open (FStar_Syntax_Const.prims_lid)) FStar_Range.dummyRange))::((FStar_Parser_AST.mk_decl (FStar_Parser_AST.Open (FStar_Syntax_Const.all_lid)) FStar_Range.dummyRange))::[]


let desugar_modul_common : FStar_Syntax_Syntax.modul Prims.option  ->  FStar_Parser_Env.env  ->  FStar_Parser_AST.modul  ->  (env_t * FStar_Syntax_Syntax.modul * Prims.bool) = (fun curmod env m -> (

let env = (match (curmod) with
| None -> begin
env
end
| Some (prev_mod) -> begin
(FStar_Parser_Env.finish_module_or_interface env prev_mod)
end)
in (

let _64_2797 = (match (m) with
| FStar_Parser_AST.Interface (mname, decls, admitted) -> begin
(let _156_1067 = (FStar_Parser_Env.prepare_module_or_interface true admitted env mname)
in ((_156_1067), (mname), (decls), (true)))
end
| FStar_Parser_AST.Module (mname, decls) -> begin
(let _156_1068 = (FStar_Parser_Env.prepare_module_or_interface false false env mname)
in ((_156_1068), (mname), (decls), (false)))
end)
in (match (_64_2797) with
| ((env, pop_when_done), mname, decls, intf) -> begin
(

let _64_2800 = (desugar_decls env decls)
in (match (_64_2800) with
| (env, sigelts) -> begin
(

let modul = {FStar_Syntax_Syntax.name = mname; FStar_Syntax_Syntax.declarations = sigelts; FStar_Syntax_Syntax.exports = []; FStar_Syntax_Syntax.is_interface = intf}
in ((env), (modul), (pop_when_done)))
end))
end))))


let desugar_partial_modul : FStar_Syntax_Syntax.modul Prims.option  ->  FStar_Parser_Env.env  ->  FStar_Parser_AST.modul  ->  (FStar_Parser_Env.env * FStar_Syntax_Syntax.modul) = (fun curmod env m -> (

let m = if (FStar_Options.interactive_fsi ()) then begin
(match (m) with
| FStar_Parser_AST.Module (mname, decls) -> begin
FStar_Parser_AST.Interface (((mname), (decls), (true)))
end
| FStar_Parser_AST.Interface (mname, _64_2811, _64_2813) -> begin
(FStar_All.failwith (Prims.strcat "Impossible: " mname.FStar_Ident.ident.FStar_Ident.idText))
end)
end else begin
m
end
in (

let _64_2821 = (desugar_modul_common curmod env m)
in (match (_64_2821) with
| (x, y, _64_2820) -> begin
((x), (y))
end))))


let desugar_modul : FStar_Parser_Env.env  ->  FStar_Parser_AST.modul  ->  (env_t * FStar_Syntax_Syntax.modul) = (fun env m -> (

let _64_2827 = (desugar_modul_common None env m)
in (match (_64_2827) with
| (env, modul, pop_when_done) -> begin
(

let env = (FStar_Parser_Env.finish_module_or_interface env modul)
in (

let _64_2829 = if (FStar_Options.dump_module modul.FStar_Syntax_Syntax.name.FStar_Ident.str) then begin
(let _156_1079 = (FStar_Syntax_Print.modul_to_string modul)
in (FStar_Util.print1 "%s\n" _156_1079))
end else begin
()
end
in (let _156_1080 = if pop_when_done then begin
(FStar_Parser_Env.export_interface modul.FStar_Syntax_Syntax.name env)
end else begin
env
end
in ((_156_1080), (modul)))))
end)))


let desugar_file : FStar_Parser_Env.env  ->  FStar_Parser_AST.file  ->  (FStar_Parser_Env.env * FStar_Syntax_Syntax.modul Prims.list) = (fun env f -> (

let _64_2842 = (FStar_List.fold_left (fun _64_2835 m -> (match (_64_2835) with
| (env, mods) -> begin
(

let _64_2839 = (desugar_modul env m)
in (match (_64_2839) with
| (env, m) -> begin
((env), ((m)::mods))
end))
end)) ((env), ([])) f)
in (match (_64_2842) with
| (env, mods) -> begin
((env), ((FStar_List.rev mods)))
end)))


let add_modul_to_env : FStar_Syntax_Syntax.modul  ->  FStar_Parser_Env.env  ->  FStar_Parser_Env.env = (fun m en -> (

let _64_2847 = (FStar_Parser_Env.prepare_module_or_interface false false en m.FStar_Syntax_Syntax.name)
in (match (_64_2847) with
| (en, pop_when_done) -> begin
(

let en = (FStar_List.fold_left FStar_Parser_Env.push_sigelt (

let _64_2848 = en
in {FStar_Parser_Env.curmodule = Some (m.FStar_Syntax_Syntax.name); FStar_Parser_Env.modules = _64_2848.FStar_Parser_Env.modules; FStar_Parser_Env.open_namespaces = _64_2848.FStar_Parser_Env.open_namespaces; FStar_Parser_Env.modul_abbrevs = _64_2848.FStar_Parser_Env.modul_abbrevs; FStar_Parser_Env.sigaccum = _64_2848.FStar_Parser_Env.sigaccum; FStar_Parser_Env.localbindings = _64_2848.FStar_Parser_Env.localbindings; FStar_Parser_Env.recbindings = _64_2848.FStar_Parser_Env.recbindings; FStar_Parser_Env.sigmap = _64_2848.FStar_Parser_Env.sigmap; FStar_Parser_Env.default_result_effect = _64_2848.FStar_Parser_Env.default_result_effect; FStar_Parser_Env.iface = _64_2848.FStar_Parser_Env.iface; FStar_Parser_Env.admitted_iface = _64_2848.FStar_Parser_Env.admitted_iface; FStar_Parser_Env.expect_typ = _64_2848.FStar_Parser_Env.expect_typ}) m.FStar_Syntax_Syntax.exports)
in (

let env = (FStar_Parser_Env.finish_module_or_interface en m)
in if pop_when_done then begin
(FStar_Parser_Env.export_interface m.FStar_Syntax_Syntax.name env)
end else begin
env
end))
end)))




