
open Prims

let new_uvar : FStar_Range.range  ->  FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.typ  ->  (FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.typ) = (fun r binders k -> (

let uv = (FStar_Unionfind.fresh FStar_Syntax_Syntax.Uvar)
in (match (binders) with
| [] -> begin
(

let uv = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_uvar ((uv, k))) (Some (k.FStar_Syntax_Syntax.n)) r)
in (uv, uv))
end
| _55_38 -> begin
(

let args = (FStar_All.pipe_right binders (FStar_List.map FStar_Syntax_Util.arg_of_non_null_binder))
in (

let k' = (let _144_7 = (FStar_Syntax_Syntax.mk_Total k)
in (FStar_Syntax_Util.arrow binders _144_7))
in (

let uv = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_uvar ((uv, k'))) None r)
in (let _144_8 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((uv, args))) (Some (k.FStar_Syntax_Syntax.n)) r)
in (_144_8, uv)))))
end)))


type uvi =
| TERM of ((FStar_Syntax_Syntax.uvar * FStar_Syntax_Syntax.typ) * FStar_Syntax_Syntax.term)
| UNIV of (FStar_Syntax_Syntax.universe_uvar * FStar_Syntax_Syntax.universe)


let is_TERM = (fun _discr_ -> (match (_discr_) with
| TERM (_) -> begin
true
end
| _ -> begin
false
end))


let is_UNIV = (fun _discr_ -> (match (_discr_) with
| UNIV (_) -> begin
true
end
| _ -> begin
false
end))


let ___TERM____0 = (fun projectee -> (match (projectee) with
| TERM (_55_44) -> begin
_55_44
end))


let ___UNIV____0 = (fun projectee -> (match (projectee) with
| UNIV (_55_47) -> begin
_55_47
end))


type worklist =
{attempting : FStar_TypeChecker_Common.probs; wl_deferred : (Prims.int * Prims.string * FStar_TypeChecker_Common.prob) Prims.list; ctr : Prims.int; defer_ok : Prims.bool; smt_ok : Prims.bool; tcenv : FStar_TypeChecker_Env.env}


let is_Mkworklist : worklist  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkworklist"))))


type solution =
| Success of FStar_TypeChecker_Common.deferred
| Failed of (FStar_TypeChecker_Common.prob * Prims.string)


let is_Success = (fun _discr_ -> (match (_discr_) with
| Success (_) -> begin
true
end
| _ -> begin
false
end))


let is_Failed = (fun _discr_ -> (match (_discr_) with
| Failed (_) -> begin
true
end
| _ -> begin
false
end))


let ___Success____0 = (fun projectee -> (match (projectee) with
| Success (_55_57) -> begin
_55_57
end))


let ___Failed____0 = (fun projectee -> (match (projectee) with
| Failed (_55_60) -> begin
_55_60
end))


type variance =
| COVARIANT
| CONTRAVARIANT
| INVARIANT


let is_COVARIANT = (fun _discr_ -> (match (_discr_) with
| COVARIANT (_) -> begin
true
end
| _ -> begin
false
end))


let is_CONTRAVARIANT = (fun _discr_ -> (match (_discr_) with
| CONTRAVARIANT (_) -> begin
true
end
| _ -> begin
false
end))


let is_INVARIANT = (fun _discr_ -> (match (_discr_) with
| INVARIANT (_) -> begin
true
end
| _ -> begin
false
end))


type tprob =
(FStar_Syntax_Syntax.typ, FStar_Syntax_Syntax.term) FStar_TypeChecker_Common.problem


type cprob =
(FStar_Syntax_Syntax.comp, Prims.unit) FStar_TypeChecker_Common.problem


type ('a, 'b) problem_t =
('a, 'b) FStar_TypeChecker_Common.problem


let rel_to_string : FStar_TypeChecker_Common.rel  ->  Prims.string = (fun _55_1 -> (match (_55_1) with
| FStar_TypeChecker_Common.EQ -> begin
"="
end
| FStar_TypeChecker_Common.SUB -> begin
"<:"
end
| FStar_TypeChecker_Common.SUBINV -> begin
":>"
end))


let term_to_string = (fun env t -> (FStar_Syntax_Print.term_to_string t))


let prob_to_string : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  Prims.string = (fun env _55_2 -> (match (_55_2) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(let _144_107 = (let _144_106 = (term_to_string env p.FStar_TypeChecker_Common.lhs)
in (let _144_105 = (let _144_104 = (FStar_Syntax_Print.tag_of_term p.FStar_TypeChecker_Common.lhs)
in (let _144_103 = (let _144_102 = (let _144_101 = (term_to_string env p.FStar_TypeChecker_Common.rhs)
in (let _144_100 = (let _144_99 = (FStar_Syntax_Print.tag_of_term p.FStar_TypeChecker_Common.rhs)
in (let _144_98 = (let _144_97 = (FStar_TypeChecker_Normalize.term_to_string env (Prims.fst p.FStar_TypeChecker_Common.logical_guard))
in (let _144_96 = (let _144_95 = (FStar_All.pipe_right p.FStar_TypeChecker_Common.reason (FStar_String.concat "\n\t\t\t"))
in (_144_95)::[])
in (_144_97)::_144_96))
in (_144_99)::_144_98))
in (_144_101)::_144_100))
in ((rel_to_string p.FStar_TypeChecker_Common.relation))::_144_102)
in (_144_104)::_144_103))
in (_144_106)::_144_105))
in (FStar_Util.format "\t%s (%s)\n\t\t%s\n\t%s (%s) (guard %s)\n\t\t<Reason>\n\t\t\t%s\n\t\t</Reason>" _144_107))
end
| FStar_TypeChecker_Common.CProb (p) -> begin
(let _144_109 = (FStar_TypeChecker_Normalize.comp_to_string env p.FStar_TypeChecker_Common.lhs)
in (let _144_108 = (FStar_TypeChecker_Normalize.comp_to_string env p.FStar_TypeChecker_Common.rhs)
in (FStar_Util.format3 "\t%s \n\t\t%s\n\t%s" _144_109 (rel_to_string p.FStar_TypeChecker_Common.relation) _144_108)))
end))


let uvi_to_string : FStar_TypeChecker_Env.env  ->  uvi  ->  Prims.string = (fun env _55_3 -> (match (_55_3) with
| UNIV (u, t) -> begin
(

let x = if (FStar_Options.hide_uvar_nums ()) then begin
"?"
end else begin
(let _144_114 = (FStar_Unionfind.uvar_id u)
in (FStar_All.pipe_right _144_114 FStar_Util.string_of_int))
end
in (let _144_115 = (FStar_Syntax_Print.univ_to_string t)
in (FStar_Util.format2 "UNIV %s %s" x _144_115)))
end
| TERM ((u, _55_84), t) -> begin
(

let x = if (FStar_Options.hide_uvar_nums ()) then begin
"?"
end else begin
(let _144_116 = (FStar_Unionfind.uvar_id u)
in (FStar_All.pipe_right _144_116 FStar_Util.string_of_int))
end
in (let _144_117 = (FStar_TypeChecker_Normalize.term_to_string env t)
in (FStar_Util.format2 "TERM %s %s" x _144_117)))
end))


let uvis_to_string : FStar_TypeChecker_Env.env  ->  uvi Prims.list  ->  Prims.string = (fun env uvis -> (let _144_122 = (FStar_List.map (uvi_to_string env) uvis)
in (FStar_All.pipe_right _144_122 (FStar_String.concat ", "))))


let names_to_string : FStar_Syntax_Syntax.bv FStar_Util.set  ->  Prims.string = (fun nms -> (let _144_126 = (let _144_125 = (FStar_Util.set_elements nms)
in (FStar_All.pipe_right _144_125 (FStar_List.map FStar_Syntax_Print.bv_to_string)))
in (FStar_All.pipe_right _144_126 (FStar_String.concat ", "))))


let args_to_string = (fun args -> (let _144_129 = (FStar_All.pipe_right args (FStar_List.map (fun _55_97 -> (match (_55_97) with
| (x, _55_96) -> begin
(FStar_Syntax_Print.term_to_string x)
end))))
in (FStar_All.pipe_right _144_129 (FStar_String.concat " "))))


let empty_worklist : FStar_TypeChecker_Env.env  ->  worklist = (fun env -> {attempting = []; wl_deferred = []; ctr = 0; defer_ok = true; smt_ok = true; tcenv = env})


let singleton : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  worklist = (fun env prob -> (

let _55_101 = (empty_worklist env)
in {attempting = (prob)::[]; wl_deferred = _55_101.wl_deferred; ctr = _55_101.ctr; defer_ok = _55_101.defer_ok; smt_ok = _55_101.smt_ok; tcenv = _55_101.tcenv}))


let wl_of_guard = (fun env g -> (

let _55_105 = (empty_worklist env)
in (let _144_138 = (FStar_List.map Prims.snd g)
in {attempting = _144_138; wl_deferred = _55_105.wl_deferred; ctr = _55_105.ctr; defer_ok = false; smt_ok = _55_105.smt_ok; tcenv = _55_105.tcenv})))


let defer : Prims.string  ->  FStar_TypeChecker_Common.prob  ->  worklist  ->  worklist = (fun reason prob wl -> (

let _55_110 = wl
in {attempting = _55_110.attempting; wl_deferred = ((wl.ctr, reason, prob))::wl.wl_deferred; ctr = _55_110.ctr; defer_ok = _55_110.defer_ok; smt_ok = _55_110.smt_ok; tcenv = _55_110.tcenv}))


let attempt : FStar_TypeChecker_Common.prob Prims.list  ->  worklist  ->  worklist = (fun probs wl -> (

let _55_114 = wl
in {attempting = (FStar_List.append probs wl.attempting); wl_deferred = _55_114.wl_deferred; ctr = _55_114.ctr; defer_ok = _55_114.defer_ok; smt_ok = _55_114.smt_ok; tcenv = _55_114.tcenv}))


let giveup : FStar_TypeChecker_Env.env  ->  Prims.string  ->  FStar_TypeChecker_Common.prob  ->  solution = (fun env reason prob -> (

let _55_119 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_155 = (prob_to_string env prob)
in (FStar_Util.print2 "Failed %s:\n%s\n" reason _144_155))
end else begin
()
end
in Failed ((prob, reason))))


let invert_rel : FStar_TypeChecker_Common.rel  ->  FStar_TypeChecker_Common.rel = (fun _55_4 -> (match (_55_4) with
| FStar_TypeChecker_Common.EQ -> begin
FStar_TypeChecker_Common.EQ
end
| FStar_TypeChecker_Common.SUB -> begin
FStar_TypeChecker_Common.SUBINV
end
| FStar_TypeChecker_Common.SUBINV -> begin
FStar_TypeChecker_Common.SUB
end))


let invert = (fun p -> (

let _55_126 = p
in {FStar_TypeChecker_Common.pid = _55_126.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = p.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.relation = (invert_rel p.FStar_TypeChecker_Common.relation); FStar_TypeChecker_Common.rhs = p.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.element = _55_126.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_126.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_126.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_126.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_126.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_126.FStar_TypeChecker_Common.rank}))


let maybe_invert = (fun p -> if (p.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.SUBINV) then begin
(invert p)
end else begin
p
end)


let maybe_invert_p : FStar_TypeChecker_Common.prob  ->  FStar_TypeChecker_Common.prob = (fun _55_5 -> (match (_55_5) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(FStar_All.pipe_right (maybe_invert p) (fun _144_162 -> FStar_TypeChecker_Common.TProb (_144_162)))
end
| FStar_TypeChecker_Common.CProb (p) -> begin
(FStar_All.pipe_right (maybe_invert p) (fun _144_163 -> FStar_TypeChecker_Common.CProb (_144_163)))
end))


let vary_rel : FStar_TypeChecker_Common.rel  ->  variance  ->  FStar_TypeChecker_Common.rel = (fun rel _55_6 -> (match (_55_6) with
| INVARIANT -> begin
FStar_TypeChecker_Common.EQ
end
| CONTRAVARIANT -> begin
(invert_rel rel)
end
| COVARIANT -> begin
rel
end))


let p_pid : FStar_TypeChecker_Common.prob  ->  Prims.int = (fun _55_7 -> (match (_55_7) with
| FStar_TypeChecker_Common.TProb (p) -> begin
p.FStar_TypeChecker_Common.pid
end
| FStar_TypeChecker_Common.CProb (p) -> begin
p.FStar_TypeChecker_Common.pid
end))


let p_rel : FStar_TypeChecker_Common.prob  ->  FStar_TypeChecker_Common.rel = (fun _55_8 -> (match (_55_8) with
| FStar_TypeChecker_Common.TProb (p) -> begin
p.FStar_TypeChecker_Common.relation
end
| FStar_TypeChecker_Common.CProb (p) -> begin
p.FStar_TypeChecker_Common.relation
end))


let p_reason : FStar_TypeChecker_Common.prob  ->  Prims.string Prims.list = (fun _55_9 -> (match (_55_9) with
| FStar_TypeChecker_Common.TProb (p) -> begin
p.FStar_TypeChecker_Common.reason
end
| FStar_TypeChecker_Common.CProb (p) -> begin
p.FStar_TypeChecker_Common.reason
end))


let p_loc : FStar_TypeChecker_Common.prob  ->  FStar_Range.range = (fun _55_10 -> (match (_55_10) with
| FStar_TypeChecker_Common.TProb (p) -> begin
p.FStar_TypeChecker_Common.loc
end
| FStar_TypeChecker_Common.CProb (p) -> begin
p.FStar_TypeChecker_Common.loc
end))


let p_guard : FStar_TypeChecker_Common.prob  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term) = (fun _55_11 -> (match (_55_11) with
| FStar_TypeChecker_Common.TProb (p) -> begin
p.FStar_TypeChecker_Common.logical_guard
end
| FStar_TypeChecker_Common.CProb (p) -> begin
p.FStar_TypeChecker_Common.logical_guard
end))


let p_scope : FStar_TypeChecker_Common.prob  ->  FStar_Syntax_Syntax.binders = (fun _55_12 -> (match (_55_12) with
| FStar_TypeChecker_Common.TProb (p) -> begin
p.FStar_TypeChecker_Common.scope
end
| FStar_TypeChecker_Common.CProb (p) -> begin
p.FStar_TypeChecker_Common.scope
end))


let p_invert : FStar_TypeChecker_Common.prob  ->  FStar_TypeChecker_Common.prob = (fun _55_13 -> (match (_55_13) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(FStar_All.pipe_left (fun _144_182 -> FStar_TypeChecker_Common.TProb (_144_182)) (invert p))
end
| FStar_TypeChecker_Common.CProb (p) -> begin
(FStar_All.pipe_left (fun _144_183 -> FStar_TypeChecker_Common.CProb (_144_183)) (invert p))
end))


let is_top_level_prob : FStar_TypeChecker_Common.prob  ->  Prims.bool = (fun p -> ((FStar_All.pipe_right (p_reason p) FStar_List.length) = 1))


let next_pid : Prims.unit  ->  Prims.int = (

let ctr = (FStar_ST.alloc 0)
in (fun _55_176 -> (match (()) with
| () -> begin
(

let _55_177 = (FStar_Util.incr ctr)
in (FStar_ST.read ctr))
end)))


let mk_problem = (fun scope orig lhs rel rhs elt reason -> (let _144_196 = (next_pid ())
in (let _144_195 = (new_uvar (p_loc orig) scope FStar_Syntax_Util.ktype0)
in {FStar_TypeChecker_Common.pid = _144_196; FStar_TypeChecker_Common.lhs = lhs; FStar_TypeChecker_Common.relation = rel; FStar_TypeChecker_Common.rhs = rhs; FStar_TypeChecker_Common.element = elt; FStar_TypeChecker_Common.logical_guard = _144_195; FStar_TypeChecker_Common.scope = scope; FStar_TypeChecker_Common.reason = (reason)::(p_reason orig); FStar_TypeChecker_Common.loc = (p_loc orig); FStar_TypeChecker_Common.rank = None})))


let new_problem = (fun env lhs rel rhs elt loc reason -> (

let scope = (FStar_TypeChecker_Env.all_binders env)
in (let _144_206 = (next_pid ())
in (let _144_205 = (let _144_204 = (FStar_TypeChecker_Env.get_range env)
in (new_uvar _144_204 scope FStar_Syntax_Util.ktype0))
in {FStar_TypeChecker_Common.pid = _144_206; FStar_TypeChecker_Common.lhs = lhs; FStar_TypeChecker_Common.relation = rel; FStar_TypeChecker_Common.rhs = rhs; FStar_TypeChecker_Common.element = elt; FStar_TypeChecker_Common.logical_guard = _144_205; FStar_TypeChecker_Common.scope = scope; FStar_TypeChecker_Common.reason = (reason)::[]; FStar_TypeChecker_Common.loc = loc; FStar_TypeChecker_Common.rank = None}))))


let problem_using_guard = (fun orig lhs rel rhs elt reason -> (let _144_213 = (next_pid ())
in {FStar_TypeChecker_Common.pid = _144_213; FStar_TypeChecker_Common.lhs = lhs; FStar_TypeChecker_Common.relation = rel; FStar_TypeChecker_Common.rhs = rhs; FStar_TypeChecker_Common.element = elt; FStar_TypeChecker_Common.logical_guard = (p_guard orig); FStar_TypeChecker_Common.scope = (p_scope orig); FStar_TypeChecker_Common.reason = (reason)::(p_reason orig); FStar_TypeChecker_Common.loc = (p_loc orig); FStar_TypeChecker_Common.rank = None}))


let guard_on_element = (fun problem x phi -> (match (problem.FStar_TypeChecker_Common.element) with
| None -> begin
(FStar_Syntax_Util.mk_forall x phi)
end
| Some (e) -> begin
(FStar_Syntax_Subst.subst ((FStar_Syntax_Syntax.NT ((x, e)))::[]) phi)
end))


let explain : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  Prims.string  ->  Prims.string = (fun env d s -> (let _144_225 = (FStar_All.pipe_left FStar_Range.string_of_range (p_loc d))
in (let _144_224 = (prob_to_string env d)
in (let _144_223 = (FStar_All.pipe_right (p_reason d) (FStar_String.concat "\n\t>"))
in (FStar_Util.format4 "(%s) Failed to solve the sub-problem\n%s\nWhich arose because:\n\t%s\nFailed because:%s\n" _144_225 _144_224 _144_223 s)))))


let commit : uvi Prims.list  ->  Prims.unit = (fun uvis -> (FStar_All.pipe_right uvis (FStar_List.iter (fun _55_14 -> (match (_55_14) with
| UNIV (u, t) -> begin
(match (t) with
| FStar_Syntax_Syntax.U_unif (u') -> begin
(FStar_Unionfind.union u u')
end
| _55_218 -> begin
(FStar_Unionfind.change u (Some (t)))
end)
end
| TERM ((u, _55_221), t) -> begin
(FStar_Syntax_Util.set_uvar u t)
end)))))


let find_term_uvar : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax FStar_Syntax_Syntax.uvar_basis FStar_Unionfind.uvar  ->  uvi Prims.list  ->  FStar_Syntax_Syntax.term Prims.option = (fun uv s -> (FStar_Util.find_map s (fun _55_15 -> (match (_55_15) with
| UNIV (_55_230) -> begin
None
end
| TERM ((u, _55_234), t) -> begin
if (FStar_Unionfind.equivalent uv u) then begin
Some (t)
end else begin
None
end
end))))


let find_univ_uvar : FStar_Syntax_Syntax.universe Prims.option FStar_Unionfind.uvar  ->  uvi Prims.list  ->  FStar_Syntax_Syntax.universe Prims.option = (fun u s -> (FStar_Util.find_map s (fun _55_16 -> (match (_55_16) with
| UNIV (u', t) -> begin
if (FStar_Unionfind.equivalent u u') then begin
Some (t)
end else begin
None
end
end
| _55_247 -> begin
None
end))))


let whnf : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env t -> (let _144_244 = (let _144_243 = (FStar_Syntax_Util.unmeta t)
in (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.WHNF)::[]) env _144_243))
in (FStar_Syntax_Subst.compress _144_244)))


let sn : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env t -> (let _144_249 = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::[]) env t)
in (FStar_Syntax_Subst.compress _144_249)))


let norm_arg = (fun env t -> (let _144_252 = (sn env (Prims.fst t))
in (_144_252, (Prims.snd t))))


let sn_binders : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.binders  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list = (fun env binders -> (FStar_All.pipe_right binders (FStar_List.map (fun _55_258 -> (match (_55_258) with
| (x, imp) -> begin
(let _144_259 = (

let _55_259 = x
in (let _144_258 = (sn env x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _55_259.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _55_259.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _144_258}))
in (_144_259, imp))
end)))))


let norm_univ : worklist  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe = (fun wl u -> (

let rec aux = (fun u -> (

let u = (FStar_Syntax_Subst.compress_univ u)
in (match (u) with
| FStar_Syntax_Syntax.U_succ (u) -> begin
(let _144_266 = (aux u)
in FStar_Syntax_Syntax.U_succ (_144_266))
end
| FStar_Syntax_Syntax.U_max (us) -> begin
(let _144_267 = (FStar_List.map aux us)
in FStar_Syntax_Syntax.U_max (_144_267))
end
| _55_271 -> begin
u
end)))
in (let _144_268 = (aux u)
in (FStar_TypeChecker_Normalize.normalize_universe wl.tcenv _144_268))))


let normalize_refinement = (fun steps env wl t0 -> (FStar_TypeChecker_Normalize.normalize_refinement steps env t0))


let base_and_refinement = (fun env wl t1 -> (

let rec aux = (fun norm t1 -> (match (t1.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_refine (x, phi) -> begin
if norm then begin
(x.FStar_Syntax_Syntax.sort, Some ((x, phi)))
end else begin
(match ((normalize_refinement ((FStar_TypeChecker_Normalize.WHNF)::[]) env wl t1)) with
| {FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_refine (x, phi); FStar_Syntax_Syntax.tk = _55_291; FStar_Syntax_Syntax.pos = _55_289; FStar_Syntax_Syntax.vars = _55_287} -> begin
(x.FStar_Syntax_Syntax.sort, Some ((x, phi)))
end
| tt -> begin
(let _144_282 = (let _144_281 = (FStar_Syntax_Print.term_to_string tt)
in (let _144_280 = (FStar_Syntax_Print.tag_of_term tt)
in (FStar_Util.format2 "impossible: Got %s ... %s\n" _144_281 _144_280)))
in (FStar_All.failwith _144_282))
end)
end
end
| (FStar_Syntax_Syntax.Tm_uinst (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) | (FStar_Syntax_Syntax.Tm_app (_)) -> begin
if norm then begin
(t1, None)
end else begin
(

let t1' = (normalize_refinement ((FStar_TypeChecker_Normalize.WHNF)::[]) env wl t1)
in (match ((let _144_283 = (FStar_Syntax_Subst.compress t1')
in _144_283.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_refine (_55_309) -> begin
(aux true t1')
end
| _55_312 -> begin
(t1, None)
end))
end
end
| (FStar_Syntax_Syntax.Tm_type (_)) | (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_name (_)) | (FStar_Syntax_Syntax.Tm_bvar (_)) | (FStar_Syntax_Syntax.Tm_arrow (_)) | (FStar_Syntax_Syntax.Tm_abs (_)) | (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_let (_)) | (FStar_Syntax_Syntax.Tm_match (_)) -> begin
(t1, None)
end
| (FStar_Syntax_Syntax.Tm_meta (_)) | (FStar_Syntax_Syntax.Tm_ascribed (_)) | (FStar_Syntax_Syntax.Tm_delayed (_)) | (FStar_Syntax_Syntax.Tm_unknown) -> begin
(let _144_286 = (let _144_285 = (FStar_Syntax_Print.term_to_string t1)
in (let _144_284 = (FStar_Syntax_Print.tag_of_term t1)
in (FStar_Util.format2 "impossible (outer): Got %s ... %s\n" _144_285 _144_284)))
in (FStar_All.failwith _144_286))
end))
in (let _144_287 = (whnf env t1)
in (aux false _144_287))))


let unrefine : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ = (fun env t -> (let _144_292 = (base_and_refinement env (empty_worklist env) t)
in (FStar_All.pipe_right _144_292 Prims.fst)))


let trivial_refinement : FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.term) = (fun t -> (let _144_295 = (FStar_Syntax_Syntax.null_bv t)
in (_144_295, FStar_Syntax_Util.t_true)))


let as_refinement = (fun env wl t -> (

let _55_358 = (base_and_refinement env wl t)
in (match (_55_358) with
| (t_base, refinement) -> begin
(match (refinement) with
| None -> begin
(trivial_refinement t_base)
end
| Some (x, phi) -> begin
(x, phi)
end)
end)))


let force_refinement = (fun _55_366 -> (match (_55_366) with
| (t_base, refopt) -> begin
(

let _55_374 = (match (refopt) with
| Some (y, phi) -> begin
(y, phi)
end
| None -> begin
(trivial_refinement t_base)
end)
in (match (_55_374) with
| (y, phi) -> begin
(FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_refine ((y, phi))) None t_base.FStar_Syntax_Syntax.pos)
end))
end))


let wl_prob_to_string : worklist  ->  FStar_TypeChecker_Common.prob  ->  Prims.string = (fun wl _55_17 -> (match (_55_17) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(let _144_308 = (FStar_Util.string_of_int p.FStar_TypeChecker_Common.pid)
in (let _144_307 = (let _144_304 = (whnf wl.tcenv p.FStar_TypeChecker_Common.lhs)
in (FStar_Syntax_Print.term_to_string _144_304))
in (let _144_306 = (let _144_305 = (whnf wl.tcenv p.FStar_TypeChecker_Common.rhs)
in (FStar_Syntax_Print.term_to_string _144_305))
in (FStar_Util.format4 "%s: %s  (%s)  %s" _144_308 _144_307 (rel_to_string p.FStar_TypeChecker_Common.relation) _144_306))))
end
| FStar_TypeChecker_Common.CProb (p) -> begin
(let _144_311 = (FStar_Util.string_of_int p.FStar_TypeChecker_Common.pid)
in (let _144_310 = (FStar_TypeChecker_Normalize.comp_to_string wl.tcenv p.FStar_TypeChecker_Common.lhs)
in (let _144_309 = (FStar_TypeChecker_Normalize.comp_to_string wl.tcenv p.FStar_TypeChecker_Common.rhs)
in (FStar_Util.format4 "%s: %s  (%s)  %s" _144_311 _144_310 (rel_to_string p.FStar_TypeChecker_Common.relation) _144_309))))
end))


let wl_to_string : worklist  ->  Prims.string = (fun wl -> (let _144_317 = (let _144_316 = (let _144_315 = (FStar_All.pipe_right wl.wl_deferred (FStar_List.map (fun _55_387 -> (match (_55_387) with
| (_55_383, _55_385, x) -> begin
x
end))))
in (FStar_List.append wl.attempting _144_315))
in (FStar_List.map (wl_prob_to_string wl) _144_316))
in (FStar_All.pipe_right _144_317 (FStar_String.concat "\n\t"))))


let u_abs : FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun k ys t -> (

let _55_406 = (match ((let _144_324 = (FStar_Syntax_Subst.compress k)
in _144_324.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
if ((FStar_List.length bs) = (FStar_List.length ys)) then begin
(let _144_325 = (FStar_Syntax_Subst.open_comp bs c)
in ((ys, t), _144_325))
end else begin
(

let _55_397 = (FStar_Syntax_Util.abs_formals t)
in (match (_55_397) with
| (ys', t) -> begin
(let _144_326 = (FStar_Syntax_Util.arrow_formals_comp k)
in (((FStar_List.append ys ys'), t), _144_326))
end))
end
end
| _55_399 -> begin
(let _144_328 = (let _144_327 = (FStar_Syntax_Syntax.mk_Total k)
in ([], _144_327))
in ((ys, t), _144_328))
end)
in (match (_55_406) with
| ((ys, t), (xs, c)) -> begin
if ((FStar_List.length xs) <> (FStar_List.length ys)) then begin
(FStar_Syntax_Util.abs ys t (Some (FStar_Util.Inr (FStar_Syntax_Const.effect_Tot_lid))))
end else begin
(

let c = (let _144_329 = (FStar_Syntax_Util.rename_binders xs ys)
in (FStar_Syntax_Subst.subst_comp _144_329 c))
in (let _144_333 = (let _144_332 = (FStar_All.pipe_right (FStar_Syntax_Util.lcomp_of_comp c) (fun _144_330 -> FStar_Util.Inl (_144_330)))
in (FStar_All.pipe_right _144_332 (fun _144_331 -> Some (_144_331))))
in (FStar_Syntax_Util.abs ys t _144_333)))
end
end)))


let solve_prob' : Prims.bool  ->  FStar_TypeChecker_Common.prob  ->  FStar_Syntax_Syntax.term Prims.option  ->  uvi Prims.list  ->  worklist  ->  worklist = (fun resolve_ok prob logical_guard uvis wl -> (

let phi = (match (logical_guard) with
| None -> begin
FStar_Syntax_Util.t_true
end
| Some (phi) -> begin
phi
end)
in (

let _55_420 = (p_guard prob)
in (match (_55_420) with
| (_55_418, uv) -> begin
(

let _55_431 = (match ((let _144_344 = (FStar_Syntax_Subst.compress uv)
in _144_344.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_uvar (uvar, k) -> begin
(

let bs = (p_scope prob)
in (

let phi = (u_abs k bs phi)
in (

let _55_427 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug wl.tcenv) (FStar_Options.Other ("Rel"))) then begin
(let _144_347 = (FStar_Util.string_of_int (p_pid prob))
in (let _144_346 = (FStar_Syntax_Print.term_to_string uv)
in (let _144_345 = (FStar_Syntax_Print.term_to_string phi)
in (FStar_Util.print3 "Solving %s (%s) with formula %s\n" _144_347 _144_346 _144_345))))
end else begin
()
end
in (FStar_Syntax_Util.set_uvar uvar phi))))
end
| _55_430 -> begin
if (not (resolve_ok)) then begin
(FStar_All.failwith "Impossible: this instance has already been assigned a solution")
end else begin
()
end
end)
in (

let _55_433 = (commit uvis)
in (

let _55_435 = wl
in {attempting = _55_435.attempting; wl_deferred = _55_435.wl_deferred; ctr = (wl.ctr + 1); defer_ok = _55_435.defer_ok; smt_ok = _55_435.smt_ok; tcenv = _55_435.tcenv})))
end))))


let extend_solution : Prims.int  ->  uvi Prims.list  ->  worklist  ->  worklist = (fun pid sol wl -> (

let _55_440 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug wl.tcenv) (FStar_Options.Other ("RelCheck"))) then begin
(let _144_356 = (FStar_Util.string_of_int pid)
in (let _144_355 = (let _144_354 = (FStar_List.map (uvi_to_string wl.tcenv) sol)
in (FStar_All.pipe_right _144_354 (FStar_String.concat ", ")))
in (FStar_Util.print2 "Solving %s: with %s\n" _144_356 _144_355)))
end else begin
()
end
in (

let _55_442 = (commit sol)
in (

let _55_444 = wl
in {attempting = _55_444.attempting; wl_deferred = _55_444.wl_deferred; ctr = (wl.ctr + 1); defer_ok = _55_444.defer_ok; smt_ok = _55_444.smt_ok; tcenv = _55_444.tcenv}))))


let solve_prob : FStar_TypeChecker_Common.prob  ->  FStar_Syntax_Syntax.term Prims.option  ->  uvi Prims.list  ->  worklist  ->  worklist = (fun prob logical_guard uvis wl -> (

let conj_guard = (fun t g -> (match ((t, g)) with
| (_55_454, FStar_TypeChecker_Common.Trivial) -> begin
t
end
| (None, FStar_TypeChecker_Common.NonTrivial (f)) -> begin
Some (f)
end
| (Some (t), FStar_TypeChecker_Common.NonTrivial (f)) -> begin
(let _144_369 = (FStar_Syntax_Util.mk_conj t f)
in Some (_144_369))
end))
in (

let _55_466 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug wl.tcenv) (FStar_Options.Other ("RelCheck"))) then begin
(let _144_372 = (FStar_All.pipe_left FStar_Util.string_of_int (p_pid prob))
in (let _144_371 = (let _144_370 = (FStar_List.map (uvi_to_string wl.tcenv) uvis)
in (FStar_All.pipe_right _144_370 (FStar_String.concat ", ")))
in (FStar_Util.print2 "Solving %s: with %s\n" _144_372 _144_371)))
end else begin
()
end
in (solve_prob' false prob logical_guard uvis wl))))


let rec occurs = (fun wl uk t -> (let _144_382 = (let _144_380 = (FStar_Syntax_Free.uvars t)
in (FStar_All.pipe_right _144_380 FStar_Util.set_elements))
in (FStar_All.pipe_right _144_382 (FStar_Util.for_some (fun _55_475 -> (match (_55_475) with
| (uv, _55_474) -> begin
(FStar_Unionfind.equivalent uv (Prims.fst uk))
end))))))


let occurs_check = (fun env wl uk t -> (

let occurs_ok = (not ((occurs wl uk t)))
in (

let msg = if occurs_ok then begin
None
end else begin
(let _144_389 = (let _144_388 = (FStar_Syntax_Print.uvar_to_string (Prims.fst uk))
in (let _144_387 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format2 "occurs-check failed (%s occurs in %s)" _144_388 _144_387)))
in Some (_144_389))
end
in (occurs_ok, msg))))


let occurs_and_freevars_check = (fun env wl uk fvs t -> (

let fvs_t = (FStar_Syntax_Free.names t)
in (

let _55_490 = (occurs_check env wl uk t)
in (match (_55_490) with
| (occurs_ok, msg) -> begin
(let _144_395 = (FStar_Util.set_is_subset_of fvs_t fvs)
in (occurs_ok, _144_395, (msg, fvs, fvs_t)))
end))))


let intersect_vars = (fun v1 v2 -> (

let as_set = (fun v -> (FStar_All.pipe_right v (FStar_List.fold_left (fun out x -> (FStar_Util.set_add (Prims.fst x) out)) FStar_Syntax_Syntax.no_names)))
in (

let v1_set = (as_set v1)
in (

let _55_508 = (FStar_All.pipe_right v2 (FStar_List.fold_left (fun _55_500 _55_503 -> (match ((_55_500, _55_503)) with
| ((isect, isect_set), (x, imp)) -> begin
if (let _144_404 = (FStar_Util.set_mem x v1_set)
in (FStar_All.pipe_left Prims.op_Negation _144_404)) then begin
(isect, isect_set)
end else begin
(

let fvs = (FStar_Syntax_Free.names x.FStar_Syntax_Syntax.sort)
in if (FStar_Util.set_is_subset_of fvs isect_set) then begin
(let _144_405 = (FStar_Util.set_add x isect_set)
in (((x, imp))::isect, _144_405))
end else begin
(isect, isect_set)
end)
end
end)) ([], FStar_Syntax_Syntax.no_names)))
in (match (_55_508) with
| (isect, _55_507) -> begin
(FStar_List.rev isect)
end)))))


let binders_eq = (fun v1 v2 -> (((FStar_List.length v1) = (FStar_List.length v2)) && (FStar_List.forall2 (fun _55_514 _55_518 -> (match ((_55_514, _55_518)) with
| ((a, _55_513), (b, _55_517)) -> begin
(FStar_Syntax_Syntax.bv_eq a b)
end)) v1 v2)))


let pat_var_opt = (fun env seen arg -> (

let hd = (norm_arg env arg)
in (match ((Prims.fst hd).FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_name (a) -> begin
if (FStar_All.pipe_right seen (FStar_Util.for_some (fun _55_528 -> (match (_55_528) with
| (b, _55_527) -> begin
(FStar_Syntax_Syntax.bv_eq a b)
end)))) then begin
None
end else begin
Some ((a, (Prims.snd hd)))
end
end
| _55_530 -> begin
None
end)))


let rec pat_vars : FStar_TypeChecker_Env.env  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list  ->  FStar_Syntax_Syntax.binders Prims.option = (fun env seen args -> (match (args) with
| [] -> begin
Some ((FStar_List.rev seen))
end
| hd::rest -> begin
(match ((pat_var_opt env seen hd)) with
| None -> begin
(

let _55_539 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_420 = (FStar_All.pipe_left FStar_Syntax_Print.term_to_string (Prims.fst hd))
in (FStar_Util.print1 "Not a pattern: %s\n" _144_420))
end else begin
()
end
in None)
end
| Some (x) -> begin
(pat_vars env ((x)::seen) rest)
end)
end))


let destruct_flex_t = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_uvar (uv, k) -> begin
(t, uv, k, [])
end
| FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (uv, k); FStar_Syntax_Syntax.tk = _55_553; FStar_Syntax_Syntax.pos = _55_551; FStar_Syntax_Syntax.vars = _55_549}, args) -> begin
(t, uv, k, args)
end
| _55_563 -> begin
(FStar_All.failwith "Not a flex-uvar")
end))


let destruct_flex_pattern = (fun env t -> (

let _55_570 = (destruct_flex_t t)
in (match (_55_570) with
| (t, uv, k, args) -> begin
(match ((pat_vars env [] args)) with
| Some (vars) -> begin
((t, uv, k, args), Some (vars))
end
| _55_574 -> begin
((t, uv, k, args), None)
end)
end)))


type match_result =
| MisMatch of (FStar_Syntax_Syntax.delta_depth Prims.option * FStar_Syntax_Syntax.delta_depth Prims.option)
| HeadMatch
| FullMatch


let is_MisMatch = (fun _discr_ -> (match (_discr_) with
| MisMatch (_) -> begin
true
end
| _ -> begin
false
end))


let is_HeadMatch = (fun _discr_ -> (match (_discr_) with
| HeadMatch (_) -> begin
true
end
| _ -> begin
false
end))


let is_FullMatch = (fun _discr_ -> (match (_discr_) with
| FullMatch (_) -> begin
true
end
| _ -> begin
false
end))


let ___MisMatch____0 = (fun projectee -> (match (projectee) with
| MisMatch (_55_577) -> begin
_55_577
end))


let head_match : match_result  ->  match_result = (fun _55_18 -> (match (_55_18) with
| MisMatch (i, j) -> begin
MisMatch ((i, j))
end
| _55_584 -> begin
HeadMatch
end))


let fv_delta_depth : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.fv  ->  FStar_Syntax_Syntax.delta_depth = (fun env fv -> (match (fv.FStar_Syntax_Syntax.fv_delta) with
| FStar_Syntax_Syntax.Delta_abstract (d) -> begin
if (env.FStar_TypeChecker_Env.curmodule.FStar_Ident.str = fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v.FStar_Ident.nsstr) then begin
d
end else begin
FStar_Syntax_Syntax.Delta_constant
end
end
| d -> begin
d
end))


let rec delta_depth_of_term : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.delta_depth Prims.option = (fun env t -> (

let t = (FStar_Syntax_Util.unmeta t)
in (match (t.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_meta (_)) | (FStar_Syntax_Syntax.Tm_delayed (_)) -> begin
(FStar_All.failwith "Impossible")
end
| (FStar_Syntax_Syntax.Tm_unknown) | (FStar_Syntax_Syntax.Tm_bvar (_)) | (FStar_Syntax_Syntax.Tm_name (_)) | (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_let (_)) | (FStar_Syntax_Syntax.Tm_match (_)) -> begin
None
end
| (FStar_Syntax_Syntax.Tm_uinst (t, _)) | (FStar_Syntax_Syntax.Tm_ascribed (t, _, _)) | (FStar_Syntax_Syntax.Tm_app (t, _)) | (FStar_Syntax_Syntax.Tm_refine ({FStar_Syntax_Syntax.ppname = _; FStar_Syntax_Syntax.index = _; FStar_Syntax_Syntax.sort = t}, _)) -> begin
(delta_depth_of_term env t)
end
| (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_type (_)) | (FStar_Syntax_Syntax.Tm_arrow (_)) | (FStar_Syntax_Syntax.Tm_abs (_)) -> begin
Some (FStar_Syntax_Syntax.Delta_constant)
end
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
Some ((fv_delta_depth env fv))
end)))


let rec head_matches : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term  ->  match_result = (fun env t1 t2 -> (

let t1 = (FStar_Syntax_Util.unmeta t1)
in (

let t2 = (FStar_Syntax_Util.unmeta t2)
in (match ((t1.FStar_Syntax_Syntax.n, t2.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_name (x), FStar_Syntax_Syntax.Tm_name (y)) -> begin
if (FStar_Syntax_Syntax.bv_eq x y) then begin
FullMatch
end else begin
MisMatch ((None, None))
end
end
| (FStar_Syntax_Syntax.Tm_fvar (f), FStar_Syntax_Syntax.Tm_fvar (g)) -> begin
if (FStar_Syntax_Syntax.fv_eq f g) then begin
FullMatch
end else begin
MisMatch ((Some ((fv_delta_depth env f)), Some ((fv_delta_depth env g))))
end
end
| (FStar_Syntax_Syntax.Tm_uinst (f, _55_670), FStar_Syntax_Syntax.Tm_uinst (g, _55_675)) -> begin
(let _144_456 = (head_matches env f g)
in (FStar_All.pipe_right _144_456 head_match))
end
| (FStar_Syntax_Syntax.Tm_constant (c), FStar_Syntax_Syntax.Tm_constant (d)) -> begin
if (c = d) then begin
FullMatch
end else begin
MisMatch ((None, None))
end
end
| (FStar_Syntax_Syntax.Tm_uvar (uv, _55_686), FStar_Syntax_Syntax.Tm_uvar (uv', _55_691)) -> begin
if (FStar_Unionfind.equivalent uv uv') then begin
FullMatch
end else begin
MisMatch ((None, None))
end
end
| (FStar_Syntax_Syntax.Tm_refine (x, _55_697), FStar_Syntax_Syntax.Tm_refine (y, _55_702)) -> begin
(let _144_457 = (head_matches env x.FStar_Syntax_Syntax.sort y.FStar_Syntax_Syntax.sort)
in (FStar_All.pipe_right _144_457 head_match))
end
| (FStar_Syntax_Syntax.Tm_refine (x, _55_708), _55_712) -> begin
(let _144_458 = (head_matches env x.FStar_Syntax_Syntax.sort t2)
in (FStar_All.pipe_right _144_458 head_match))
end
| (_55_715, FStar_Syntax_Syntax.Tm_refine (x, _55_718)) -> begin
(let _144_459 = (head_matches env t1 x.FStar_Syntax_Syntax.sort)
in (FStar_All.pipe_right _144_459 head_match))
end
| ((FStar_Syntax_Syntax.Tm_type (_), FStar_Syntax_Syntax.Tm_type (_))) | ((FStar_Syntax_Syntax.Tm_arrow (_), FStar_Syntax_Syntax.Tm_arrow (_))) -> begin
HeadMatch
end
| (FStar_Syntax_Syntax.Tm_app (head, _55_738), FStar_Syntax_Syntax.Tm_app (head', _55_743)) -> begin
(let _144_460 = (head_matches env head head')
in (FStar_All.pipe_right _144_460 head_match))
end
| (FStar_Syntax_Syntax.Tm_app (head, _55_749), _55_753) -> begin
(let _144_461 = (head_matches env head t2)
in (FStar_All.pipe_right _144_461 head_match))
end
| (_55_756, FStar_Syntax_Syntax.Tm_app (head, _55_759)) -> begin
(let _144_462 = (head_matches env t1 head)
in (FStar_All.pipe_right _144_462 head_match))
end
| _55_764 -> begin
(let _144_465 = (let _144_464 = (delta_depth_of_term env t1)
in (let _144_463 = (delta_depth_of_term env t2)
in (_144_464, _144_463)))
in MisMatch (_144_465))
end))))


let head_matches_delta = (fun env wl t1 t2 -> (

let success = (fun d r t1 t2 -> (r, if (d > 0) then begin
Some ((t1, t2))
end else begin
None
end))
in (

let fail = (fun r -> (r, None))
in (

let rec aux = (fun n_delta t1 t2 -> (

let r = (head_matches env t1 t2)
in (match (r) with
| MisMatch (Some (d1), Some (d2)) when (d1 = d2) -> begin
(match ((FStar_TypeChecker_Common.decr_delta_depth d1)) with
| None -> begin
(fail r)
end
| Some (d) -> begin
(

let t1 = (normalize_refinement ((FStar_TypeChecker_Normalize.UnfoldUntil (d))::(FStar_TypeChecker_Normalize.WHNF)::[]) env wl t1)
in (

let t2 = (normalize_refinement ((FStar_TypeChecker_Normalize.UnfoldUntil (d))::(FStar_TypeChecker_Normalize.WHNF)::[]) env wl t2)
in (aux (n_delta + 1) t1 t2)))
end)
end
| (MisMatch (Some (FStar_Syntax_Syntax.Delta_equational), _)) | (MisMatch (_, Some (FStar_Syntax_Syntax.Delta_equational))) -> begin
(fail r)
end
| MisMatch (Some (d1), Some (d2)) -> begin
(

let d1_greater_than_d2 = (FStar_TypeChecker_Common.delta_depth_greater_than d1 d2)
in (

let _55_815 = if d1_greater_than_d2 then begin
(

let t1' = (normalize_refinement ((FStar_TypeChecker_Normalize.UnfoldUntil (d2))::(FStar_TypeChecker_Normalize.WHNF)::[]) env wl t1)
in (t1', t2))
end else begin
(

let t2' = (normalize_refinement ((FStar_TypeChecker_Normalize.UnfoldUntil (d1))::(FStar_TypeChecker_Normalize.WHNF)::[]) env wl t2)
in (let _144_486 = (normalize_refinement ((FStar_TypeChecker_Normalize.UnfoldUntil (d1))::(FStar_TypeChecker_Normalize.WHNF)::[]) env wl t2)
in (t1, _144_486)))
end
in (match (_55_815) with
| (t1, t2) -> begin
(aux (n_delta + 1) t1 t2)
end)))
end
| MisMatch (_55_817) -> begin
(fail r)
end
| _55_820 -> begin
(success n_delta r t1 t2)
end)))
in (aux 0 t1 t2)))))


type tc =
| T of FStar_Syntax_Syntax.term
| C of FStar_Syntax_Syntax.comp


let is_T = (fun _discr_ -> (match (_discr_) with
| T (_) -> begin
true
end
| _ -> begin
false
end))


let is_C = (fun _discr_ -> (match (_discr_) with
| C (_) -> begin
true
end
| _ -> begin
false
end))


let ___T____0 = (fun projectee -> (match (projectee) with
| T (_55_823) -> begin
_55_823
end))


let ___C____0 = (fun projectee -> (match (projectee) with
| C (_55_826) -> begin
_55_826
end))


type tcs =
tc Prims.list


let rec decompose : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  ((tc Prims.list  ->  FStar_Syntax_Syntax.term) * (FStar_Syntax_Syntax.term  ->  Prims.bool) * (FStar_Syntax_Syntax.binder Prims.option * variance * tc) Prims.list) = (fun env t -> (

let t = (FStar_Syntax_Util.unmeta t)
in (

let matches = (fun t' -> (match ((head_matches env t t')) with
| MisMatch (_55_833) -> begin
false
end
| _55_836 -> begin
true
end))
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_app (hd, args) -> begin
(

let rebuild = (fun args' -> (

let args = (FStar_List.map2 (fun x y -> (match ((x, y)) with
| ((_55_846, imp), T (t)) -> begin
(t, imp)
end
| _55_853 -> begin
(FStar_All.failwith "Bad reconstruction")
end)) args args')
in (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((hd, args))) None t.FStar_Syntax_Syntax.pos)))
in (

let tcs = (FStar_All.pipe_right args (FStar_List.map (fun _55_858 -> (match (_55_858) with
| (t, _55_857) -> begin
(None, INVARIANT, T (t))
end))))
in (rebuild, matches, tcs)))
end
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(

let fail = (fun _55_865 -> (match (()) with
| () -> begin
(FStar_All.failwith "Bad reconstruction")
end))
in (

let _55_868 = (FStar_Syntax_Subst.open_comp bs c)
in (match (_55_868) with
| (bs, c) -> begin
(

let rebuild = (fun tcs -> (

let rec aux = (fun out bs tcs -> (match ((bs, tcs)) with
| ((x, imp)::bs, T (t)::tcs) -> begin
(aux ((((

let _55_885 = x
in {FStar_Syntax_Syntax.ppname = _55_885.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _55_885.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t}), imp))::out) bs tcs)
end
| ([], C (c)::[]) -> begin
(FStar_Syntax_Util.arrow (FStar_List.rev out) c)
end
| _55_893 -> begin
(FStar_All.failwith "Bad reconstruction")
end))
in (aux [] bs tcs)))
in (

let rec decompose = (fun out _55_19 -> (match (_55_19) with
| [] -> begin
(FStar_List.rev (((None, COVARIANT, C (c)))::out))
end
| hd::rest -> begin
(decompose (((Some (hd), CONTRAVARIANT, T ((Prims.fst hd).FStar_Syntax_Syntax.sort)))::out) rest)
end))
in (let _144_568 = (decompose [] bs)
in (rebuild, matches, _144_568))))
end)))
end
| _55_902 -> begin
(

let rebuild = (fun _55_20 -> (match (_55_20) with
| [] -> begin
t
end
| _55_906 -> begin
(FStar_All.failwith "Bad reconstruction")
end))
in (rebuild, (fun t -> true), []))
end))))


let un_T : tc  ->  FStar_Syntax_Syntax.term = (fun _55_21 -> (match (_55_21) with
| T (t) -> begin
t
end
| _55_913 -> begin
(FStar_All.failwith "Impossible")
end))


let arg_of_tc : tc  ->  FStar_Syntax_Syntax.arg = (fun _55_22 -> (match (_55_22) with
| T (t) -> begin
(FStar_Syntax_Syntax.as_arg t)
end
| _55_918 -> begin
(FStar_All.failwith "Impossible")
end))


let imitation_sub_probs = (fun orig env scope ps qs -> (

let r = (p_loc orig)
in (

let rel = (p_rel orig)
in (

let sub_prob = (fun scope args q -> (match (q) with
| (_55_931, variance, T (ti)) -> begin
(

let k = (

let _55_939 = (FStar_Syntax_Util.type_u ())
in (match (_55_939) with
| (t, _55_938) -> begin
(let _144_590 = (new_uvar r scope t)
in (Prims.fst _144_590))
end))
in (

let _55_943 = (new_uvar r scope k)
in (match (_55_943) with
| (gi_xs, gi) -> begin
(

let gi_ps = (match (args) with
| [] -> begin
gi
end
| _55_946 -> begin
(FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((gi, args))) None r)
end)
in (let _144_593 = (let _144_592 = (mk_problem scope orig gi_ps (vary_rel rel variance) ti None "type subterm")
in (FStar_All.pipe_left (fun _144_591 -> FStar_TypeChecker_Common.TProb (_144_591)) _144_592))
in (T (gi_xs), _144_593)))
end)))
end
| (_55_949, _55_951, C (_55_953)) -> begin
(FStar_All.failwith "impos")
end))
in (

let rec aux = (fun scope args qs -> (match (qs) with
| [] -> begin
([], [], FStar_Syntax_Util.t_true)
end
| q::qs -> begin
(

let _55_1031 = (match (q) with
| (bopt, variance, C ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Total (ti); FStar_Syntax_Syntax.tk = _55_971; FStar_Syntax_Syntax.pos = _55_969; FStar_Syntax_Syntax.vars = _55_967})) -> begin
(match ((sub_prob scope args (bopt, variance, T (ti)))) with
| (T (gi_xs), prob) -> begin
(let _144_602 = (let _144_601 = (FStar_Syntax_Syntax.mk_Total gi_xs)
in (FStar_All.pipe_left (fun _144_600 -> C (_144_600)) _144_601))
in (_144_602, (prob)::[]))
end
| _55_982 -> begin
(FStar_All.failwith "impossible")
end)
end
| (bopt, variance, C ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.GTotal (ti); FStar_Syntax_Syntax.tk = _55_990; FStar_Syntax_Syntax.pos = _55_988; FStar_Syntax_Syntax.vars = _55_986})) -> begin
(match ((sub_prob scope args (bopt, variance, T (ti)))) with
| (T (gi_xs), prob) -> begin
(let _144_605 = (let _144_604 = (FStar_Syntax_Syntax.mk_GTotal gi_xs)
in (FStar_All.pipe_left (fun _144_603 -> C (_144_603)) _144_604))
in (_144_605, (prob)::[]))
end
| _55_1001 -> begin
(FStar_All.failwith "impossible")
end)
end
| (_55_1003, _55_1005, C ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Comp (c); FStar_Syntax_Syntax.tk = _55_1011; FStar_Syntax_Syntax.pos = _55_1009; FStar_Syntax_Syntax.vars = _55_1007})) -> begin
(

let components = (FStar_All.pipe_right c.FStar_Syntax_Syntax.effect_args (FStar_List.map (fun t -> (None, INVARIANT, T ((Prims.fst t))))))
in (

let components = ((None, COVARIANT, T (c.FStar_Syntax_Syntax.result_typ)))::components
in (

let _55_1022 = (let _144_607 = (FStar_List.map (sub_prob scope args) components)
in (FStar_All.pipe_right _144_607 FStar_List.unzip))
in (match (_55_1022) with
| (tcs, sub_probs) -> begin
(

let gi_xs = (let _144_612 = (let _144_611 = (let _144_608 = (FStar_List.hd tcs)
in (FStar_All.pipe_right _144_608 un_T))
in (let _144_610 = (let _144_609 = (FStar_List.tl tcs)
in (FStar_All.pipe_right _144_609 (FStar_List.map arg_of_tc)))
in {FStar_Syntax_Syntax.effect_name = c.FStar_Syntax_Syntax.effect_name; FStar_Syntax_Syntax.result_typ = _144_611; FStar_Syntax_Syntax.effect_args = _144_610; FStar_Syntax_Syntax.flags = c.FStar_Syntax_Syntax.flags}))
in (FStar_All.pipe_left FStar_Syntax_Syntax.mk_Comp _144_612))
in (C (gi_xs), sub_probs))
end))))
end
| _55_1025 -> begin
(

let _55_1028 = (sub_prob scope args q)
in (match (_55_1028) with
| (ktec, prob) -> begin
(ktec, (prob)::[])
end))
end)
in (match (_55_1031) with
| (tc, probs) -> begin
(

let _55_1044 = (match (q) with
| (Some (b), _55_1035, _55_1037) -> begin
(let _144_614 = (let _144_613 = (FStar_Syntax_Util.arg_of_non_null_binder b)
in (_144_613)::args)
in (Some (b), (b)::scope, _144_614))
end
| _55_1040 -> begin
(None, scope, args)
end)
in (match (_55_1044) with
| (bopt, scope, args) -> begin
(

let _55_1048 = (aux scope args qs)
in (match (_55_1048) with
| (sub_probs, tcs, f) -> begin
(

let f = (match (bopt) with
| None -> begin
(let _144_617 = (let _144_616 = (FStar_All.pipe_right probs (FStar_List.map (fun prob -> (FStar_All.pipe_right (p_guard prob) Prims.fst))))
in (f)::_144_616)
in (FStar_Syntax_Util.mk_conj_l _144_617))
end
| Some (b) -> begin
(let _144_621 = (let _144_620 = (FStar_Syntax_Util.mk_forall (Prims.fst b) f)
in (let _144_619 = (FStar_All.pipe_right probs (FStar_List.map (fun prob -> (FStar_All.pipe_right (p_guard prob) Prims.fst))))
in (_144_620)::_144_619))
in (FStar_Syntax_Util.mk_conj_l _144_621))
end)
in ((FStar_List.append probs sub_probs), (tc)::tcs, f))
end))
end))
end))
end))
in (aux scope ps qs))))))


let rec eq_tm : FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  Prims.bool = (fun t1 t2 -> (

let t1 = (FStar_Syntax_Subst.compress t1)
in (

let t2 = (FStar_Syntax_Subst.compress t2)
in (match ((t1.FStar_Syntax_Syntax.n, t2.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_name (a), FStar_Syntax_Syntax.Tm_name (b)) -> begin
(FStar_Syntax_Syntax.bv_eq a b)
end
| (FStar_Syntax_Syntax.Tm_fvar (f), FStar_Syntax_Syntax.Tm_fvar (g)) -> begin
(FStar_Syntax_Syntax.fv_eq f g)
end
| (FStar_Syntax_Syntax.Tm_constant (c), FStar_Syntax_Syntax.Tm_constant (d)) -> begin
(c = d)
end
| (FStar_Syntax_Syntax.Tm_uvar (u1, _55_1076), FStar_Syntax_Syntax.Tm_uvar (u2, _55_1081)) -> begin
(FStar_Unionfind.equivalent u1 u2)
end
| (FStar_Syntax_Syntax.Tm_app (h1, args1), FStar_Syntax_Syntax.Tm_app (h2, args2)) -> begin
((eq_tm h1 h2) && (eq_args args1 args2))
end
| _55_1095 -> begin
false
end))))
and eq_args : FStar_Syntax_Syntax.args  ->  FStar_Syntax_Syntax.args  ->  Prims.bool = (fun a1 a2 -> (((FStar_List.length a1) = (FStar_List.length a2)) && (FStar_List.forall2 (fun _55_1101 _55_1105 -> (match ((_55_1101, _55_1105)) with
| ((a1, _55_1100), (a2, _55_1104)) -> begin
(eq_tm a1 a2)
end)) a1 a2)))


type flex_t =
(FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.uvar * FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.args)


type im_or_proj_t =
(((FStar_Syntax_Syntax.uvar * FStar_Syntax_Syntax.typ) * FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.comp) * FStar_Syntax_Syntax.arg Prims.list * ((tc Prims.list  ->  FStar_Syntax_Syntax.typ) * (FStar_Syntax_Syntax.typ  ->  Prims.bool) * (FStar_Syntax_Syntax.binder Prims.option * variance * tc) Prims.list))


let rigid_rigid : Prims.int = 0


let flex_rigid_eq : Prims.int = 1


let flex_refine_inner : Prims.int = 2


let flex_refine : Prims.int = 3


let flex_rigid : Prims.int = 4


let rigid_flex : Prims.int = 5


let refine_flex : Prims.int = 6


let flex_flex : Prims.int = 7


let compress_tprob = (fun wl p -> (

let _55_1108 = p
in (let _144_643 = (whnf wl.tcenv p.FStar_TypeChecker_Common.lhs)
in (let _144_642 = (whnf wl.tcenv p.FStar_TypeChecker_Common.rhs)
in {FStar_TypeChecker_Common.pid = _55_1108.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _144_643; FStar_TypeChecker_Common.relation = _55_1108.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _144_642; FStar_TypeChecker_Common.element = _55_1108.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_1108.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_1108.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_1108.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_1108.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_1108.FStar_TypeChecker_Common.rank}))))


let compress_prob : worklist  ->  FStar_TypeChecker_Common.prob  ->  FStar_TypeChecker_Common.prob = (fun wl p -> (match (p) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(let _144_649 = (compress_tprob wl p)
in (FStar_All.pipe_right _144_649 (fun _144_648 -> FStar_TypeChecker_Common.TProb (_144_648))))
end
| FStar_TypeChecker_Common.CProb (_55_1115) -> begin
p
end))


let rank : worklist  ->  FStar_TypeChecker_Common.prob  ->  (Prims.int * FStar_TypeChecker_Common.prob) = (fun wl pr -> (

let prob = (let _144_654 = (compress_prob wl pr)
in (FStar_All.pipe_right _144_654 maybe_invert_p))
in (match (prob) with
| FStar_TypeChecker_Common.TProb (tp) -> begin
(

let _55_1125 = (FStar_Syntax_Util.head_and_args tp.FStar_TypeChecker_Common.lhs)
in (match (_55_1125) with
| (lh, _55_1124) -> begin
(

let _55_1129 = (FStar_Syntax_Util.head_and_args tp.FStar_TypeChecker_Common.rhs)
in (match (_55_1129) with
| (rh, _55_1128) -> begin
(

let _55_1185 = (match ((lh.FStar_Syntax_Syntax.n, rh.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_uvar (_55_1131), FStar_Syntax_Syntax.Tm_uvar (_55_1134)) -> begin
(flex_flex, tp)
end
| ((FStar_Syntax_Syntax.Tm_uvar (_), _)) | ((_, FStar_Syntax_Syntax.Tm_uvar (_))) when (tp.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) -> begin
(flex_rigid_eq, tp)
end
| (FStar_Syntax_Syntax.Tm_uvar (_55_1150), _55_1153) -> begin
(

let _55_1157 = (base_and_refinement wl.tcenv wl tp.FStar_TypeChecker_Common.rhs)
in (match (_55_1157) with
| (b, ref_opt) -> begin
(match (ref_opt) with
| None -> begin
(flex_rigid, tp)
end
| _55_1160 -> begin
(

let rank = if (is_top_level_prob prob) then begin
flex_refine
end else begin
flex_refine_inner
end
in (let _144_656 = (

let _55_1162 = tp
in (let _144_655 = (force_refinement (b, ref_opt))
in {FStar_TypeChecker_Common.pid = _55_1162.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _55_1162.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = _55_1162.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _144_655; FStar_TypeChecker_Common.element = _55_1162.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_1162.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_1162.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_1162.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_1162.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_1162.FStar_TypeChecker_Common.rank}))
in (rank, _144_656)))
end)
end))
end
| (_55_1165, FStar_Syntax_Syntax.Tm_uvar (_55_1167)) -> begin
(

let _55_1172 = (base_and_refinement wl.tcenv wl tp.FStar_TypeChecker_Common.lhs)
in (match (_55_1172) with
| (b, ref_opt) -> begin
(match (ref_opt) with
| None -> begin
(rigid_flex, tp)
end
| _55_1175 -> begin
(let _144_658 = (

let _55_1176 = tp
in (let _144_657 = (force_refinement (b, ref_opt))
in {FStar_TypeChecker_Common.pid = _55_1176.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _144_657; FStar_TypeChecker_Common.relation = _55_1176.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _55_1176.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _55_1176.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_1176.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_1176.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_1176.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_1176.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_1176.FStar_TypeChecker_Common.rank}))
in (refine_flex, _144_658))
end)
end))
end
| (_55_1179, _55_1181) -> begin
(rigid_rigid, tp)
end)
in (match (_55_1185) with
| (rank, tp) -> begin
(let _144_660 = (FStar_All.pipe_right (

let _55_1186 = tp
in {FStar_TypeChecker_Common.pid = _55_1186.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _55_1186.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = _55_1186.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _55_1186.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _55_1186.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_1186.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_1186.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_1186.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_1186.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = Some (rank)}) (fun _144_659 -> FStar_TypeChecker_Common.TProb (_144_659)))
in (rank, _144_660))
end))
end))
end))
end
| FStar_TypeChecker_Common.CProb (cp) -> begin
(let _144_662 = (FStar_All.pipe_right (

let _55_1190 = cp
in {FStar_TypeChecker_Common.pid = _55_1190.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _55_1190.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = _55_1190.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _55_1190.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _55_1190.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_1190.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_1190.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_1190.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_1190.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = Some (rigid_rigid)}) (fun _144_661 -> FStar_TypeChecker_Common.CProb (_144_661)))
in (rigid_rigid, _144_662))
end)))


let next_prob : worklist  ->  (FStar_TypeChecker_Common.prob Prims.option * FStar_TypeChecker_Common.prob Prims.list * Prims.int) = (fun wl -> (

let rec aux = (fun _55_1197 probs -> (match (_55_1197) with
| (min_rank, min, out) -> begin
(match (probs) with
| [] -> begin
(min, out, min_rank)
end
| hd::tl -> begin
(

let _55_1205 = (rank wl hd)
in (match (_55_1205) with
| (rank, hd) -> begin
if (rank <= flex_rigid_eq) then begin
(match (min) with
| None -> begin
(Some (hd), (FStar_List.append out tl), rank)
end
| Some (m) -> begin
(Some (hd), (FStar_List.append out ((m)::tl)), rank)
end)
end else begin
if (rank < min_rank) then begin
(match (min) with
| None -> begin
(aux (rank, Some (hd), out) tl)
end
| Some (m) -> begin
(aux (rank, Some (hd), (m)::out) tl)
end)
end else begin
(aux (min_rank, min, (hd)::out) tl)
end
end
end))
end)
end))
in (aux ((flex_flex + 1), None, []) wl.attempting)))


let is_flex_rigid : Prims.int  ->  Prims.bool = (fun rank -> ((flex_refine_inner <= rank) && (rank <= flex_rigid)))


let is_rigid_flex : Prims.int  ->  Prims.bool = (fun rank -> ((rigid_flex <= rank) && (rank <= refine_flex)))


type univ_eq_sol =
| UDeferred of worklist
| USolved of worklist
| UFailed of Prims.string


let is_UDeferred = (fun _discr_ -> (match (_discr_) with
| UDeferred (_) -> begin
true
end
| _ -> begin
false
end))


let is_USolved = (fun _discr_ -> (match (_discr_) with
| USolved (_) -> begin
true
end
| _ -> begin
false
end))


let is_UFailed = (fun _discr_ -> (match (_discr_) with
| UFailed (_) -> begin
true
end
| _ -> begin
false
end))


let ___UDeferred____0 = (fun projectee -> (match (projectee) with
| UDeferred (_55_1216) -> begin
_55_1216
end))


let ___USolved____0 = (fun projectee -> (match (projectee) with
| USolved (_55_1219) -> begin
_55_1219
end))


let ___UFailed____0 = (fun projectee -> (match (projectee) with
| UFailed (_55_1222) -> begin
_55_1222
end))


let rec solve_universe_eq : Prims.int  ->  worklist  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe  ->  univ_eq_sol = (fun orig wl u1 u2 -> (

let u1 = (FStar_TypeChecker_Normalize.normalize_universe wl.tcenv u1)
in (

let u2 = (FStar_TypeChecker_Normalize.normalize_universe wl.tcenv u2)
in (

let rec occurs_univ = (fun v1 u -> (match (u) with
| FStar_Syntax_Syntax.U_max (us) -> begin
(FStar_All.pipe_right us (FStar_Util.for_some (fun u -> (

let _55_1238 = (FStar_Syntax_Util.univ_kernel u)
in (match (_55_1238) with
| (k, _55_1237) -> begin
(match (k) with
| FStar_Syntax_Syntax.U_unif (v2) -> begin
(FStar_Unionfind.equivalent v1 v2)
end
| _55_1242 -> begin
false
end)
end)))))
end
| _55_1244 -> begin
(occurs_univ v1 (FStar_Syntax_Syntax.U_max ((u)::[])))
end))
in (

let try_umax_components = (fun u1 u2 msg -> (match ((u1, u2)) with
| (FStar_Syntax_Syntax.U_max (us1), FStar_Syntax_Syntax.U_max (us2)) -> begin
if ((FStar_List.length us1) = (FStar_List.length us2)) then begin
(

let rec aux = (fun wl us1 us2 -> (match ((us1, us2)) with
| (u1::us1, u2::us2) -> begin
(match ((solve_universe_eq orig wl u1 u2)) with
| USolved (wl) -> begin
(aux wl us1 us2)
end
| failed -> begin
failed
end)
end
| _55_1269 -> begin
USolved (wl)
end))
in (aux wl us1 us2))
end else begin
(let _144_742 = (let _144_741 = (FStar_Syntax_Print.univ_to_string u1)
in (let _144_740 = (FStar_Syntax_Print.univ_to_string u2)
in (FStar_Util.format2 "Unable to unify universes: %s and %s" _144_741 _144_740)))
in UFailed (_144_742))
end
end
| ((FStar_Syntax_Syntax.U_max (us), u')) | ((u', FStar_Syntax_Syntax.U_max (us))) -> begin
(

let rec aux = (fun wl us -> (match (us) with
| [] -> begin
USolved (wl)
end
| u::us -> begin
(match ((solve_universe_eq orig wl u u')) with
| USolved (wl) -> begin
(aux wl us)
end
| failed -> begin
failed
end)
end))
in (aux wl us))
end
| _55_1287 -> begin
(let _144_749 = (let _144_748 = (FStar_Syntax_Print.univ_to_string u1)
in (let _144_747 = (FStar_Syntax_Print.univ_to_string u2)
in (FStar_Util.format3 "Unable to unify universes: %s and %s (%s)" _144_748 _144_747 msg)))
in UFailed (_144_749))
end))
in (match ((u1, u2)) with
| ((FStar_Syntax_Syntax.U_bvar (_), _)) | ((FStar_Syntax_Syntax.U_unknown, _)) | ((_, FStar_Syntax_Syntax.U_bvar (_))) | ((_, FStar_Syntax_Syntax.U_unknown)) -> begin
(FStar_All.failwith "Impossible: locally nameless")
end
| (FStar_Syntax_Syntax.U_name (x), FStar_Syntax_Syntax.U_name (y)) -> begin
if (x.FStar_Ident.idText = y.FStar_Ident.idText) then begin
USolved (wl)
end else begin
UFailed ("Incompatible universes")
end
end
| (FStar_Syntax_Syntax.U_zero, FStar_Syntax_Syntax.U_zero) -> begin
USolved (wl)
end
| (FStar_Syntax_Syntax.U_succ (u1), FStar_Syntax_Syntax.U_succ (u2)) -> begin
(solve_universe_eq orig wl u1 u2)
end
| (FStar_Syntax_Syntax.U_unif (v1), FStar_Syntax_Syntax.U_unif (v2)) -> begin
if (FStar_Unionfind.equivalent v1 v2) then begin
USolved (wl)
end else begin
(

let wl = (extend_solution orig ((UNIV ((v1, u2)))::[]) wl)
in USolved (wl))
end
end
| ((FStar_Syntax_Syntax.U_unif (v1), u)) | ((u, FStar_Syntax_Syntax.U_unif (v1))) -> begin
(

let u = (norm_univ wl u)
in if (occurs_univ v1 u) then begin
(let _144_752 = (let _144_751 = (FStar_Syntax_Print.univ_to_string (FStar_Syntax_Syntax.U_unif (v1)))
in (let _144_750 = (FStar_Syntax_Print.univ_to_string u)
in (FStar_Util.format2 "Failed occurs check: %s occurs in %s" _144_751 _144_750)))
in (try_umax_components u1 u2 _144_752))
end else begin
(let _144_753 = (extend_solution orig ((UNIV ((v1, u)))::[]) wl)
in USolved (_144_753))
end)
end
| ((FStar_Syntax_Syntax.U_max (_), _)) | ((_, FStar_Syntax_Syntax.U_max (_))) -> begin
if wl.defer_ok then begin
UDeferred (wl)
end else begin
(

let u1 = (norm_univ wl u1)
in (

let u2 = (norm_univ wl u2)
in if (FStar_Syntax_Util.eq_univs u1 u2) then begin
USolved (wl)
end else begin
(try_umax_components u1 u2 "")
end))
end
end
| ((FStar_Syntax_Syntax.U_succ (_), FStar_Syntax_Syntax.U_zero)) | ((FStar_Syntax_Syntax.U_succ (_), FStar_Syntax_Syntax.U_name (_))) | ((FStar_Syntax_Syntax.U_zero, FStar_Syntax_Syntax.U_succ (_))) | ((FStar_Syntax_Syntax.U_zero, FStar_Syntax_Syntax.U_name (_))) | ((FStar_Syntax_Syntax.U_name (_), FStar_Syntax_Syntax.U_succ (_))) | ((FStar_Syntax_Syntax.U_name (_), FStar_Syntax_Syntax.U_zero)) -> begin
UFailed ("Incompatible universes")
end))))))


let rec solve : FStar_TypeChecker_Env.env  ->  worklist  ->  solution = (fun env probs -> (

let _55_1384 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(let _144_799 = (wl_to_string probs)
in (FStar_Util.print1 "solve:\n\t%s\n" _144_799))
end else begin
()
end
in (match ((next_prob probs)) with
| (Some (hd), tl, rank) -> begin
(

let probs = (

let _55_1391 = probs
in {attempting = tl; wl_deferred = _55_1391.wl_deferred; ctr = _55_1391.ctr; defer_ok = _55_1391.defer_ok; smt_ok = _55_1391.smt_ok; tcenv = _55_1391.tcenv})
in (match (hd) with
| FStar_TypeChecker_Common.CProb (cp) -> begin
(solve_c env (maybe_invert cp) probs)
end
| FStar_TypeChecker_Common.TProb (tp) -> begin
if (((not (probs.defer_ok)) && (flex_refine_inner <= rank)) && (rank <= flex_rigid)) then begin
(match ((solve_flex_rigid_join env tp probs)) with
| None -> begin
(solve_t' env (maybe_invert tp) probs)
end
| Some (wl) -> begin
(solve env wl)
end)
end else begin
if (((not (probs.defer_ok)) && (rigid_flex <= rank)) && (rank <= refine_flex)) then begin
(match ((solve_rigid_flex_meet env tp probs)) with
| None -> begin
(solve_t' env (maybe_invert tp) probs)
end
| Some (wl) -> begin
(solve env wl)
end)
end else begin
(solve_t' env (maybe_invert tp) probs)
end
end
end))
end
| (None, _55_1406, _55_1408) -> begin
(match (probs.wl_deferred) with
| [] -> begin
Success ([])
end
| _55_1412 -> begin
(

let _55_1421 = (FStar_All.pipe_right probs.wl_deferred (FStar_List.partition (fun _55_1418 -> (match (_55_1418) with
| (c, _55_1415, _55_1417) -> begin
(c < probs.ctr)
end))))
in (match (_55_1421) with
| (attempt, rest) -> begin
(match (attempt) with
| [] -> begin
(let _144_802 = (FStar_List.map (fun _55_1427 -> (match (_55_1427) with
| (_55_1424, x, y) -> begin
(x, y)
end)) probs.wl_deferred)
in Success (_144_802))
end
| _55_1429 -> begin
(let _144_805 = (

let _55_1430 = probs
in (let _144_804 = (FStar_All.pipe_right attempt (FStar_List.map (fun _55_1437 -> (match (_55_1437) with
| (_55_1433, _55_1435, y) -> begin
y
end))))
in {attempting = _144_804; wl_deferred = rest; ctr = _55_1430.ctr; defer_ok = _55_1430.defer_ok; smt_ok = _55_1430.smt_ok; tcenv = _55_1430.tcenv}))
in (solve env _144_805))
end)
end))
end)
end)))
and solve_one_universe_eq : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe  ->  worklist  ->  solution = (fun env orig u1 u2 wl -> (match ((solve_universe_eq (p_pid orig) wl u1 u2)) with
| USolved (wl) -> begin
(let _144_811 = (solve_prob orig None [] wl)
in (solve env _144_811))
end
| UFailed (msg) -> begin
(giveup env msg orig)
end
| UDeferred (wl) -> begin
(solve env (defer "" orig wl))
end))
and solve_maybe_uinsts : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term  ->  worklist  ->  univ_eq_sol = (fun env orig t1 t2 wl -> (

let rec aux = (fun wl us1 us2 -> (match ((us1, us2)) with
| ([], []) -> begin
USolved (wl)
end
| (u1::us1, u2::us2) -> begin
(match ((solve_universe_eq (p_pid orig) wl u1 u2)) with
| USolved (wl) -> begin
(aux wl us1 us2)
end
| failed_or_deferred -> begin
failed_or_deferred
end)
end
| _55_1472 -> begin
UFailed ("Unequal number of universes")
end))
in (

let t1 = (whnf env t1)
in (

let t2 = (whnf env t2)
in (match ((t1.FStar_Syntax_Syntax.n, t2.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_uinst ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (f); FStar_Syntax_Syntax.tk = _55_1480; FStar_Syntax_Syntax.pos = _55_1478; FStar_Syntax_Syntax.vars = _55_1476}, us1), FStar_Syntax_Syntax.Tm_uinst ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (g); FStar_Syntax_Syntax.tk = _55_1492; FStar_Syntax_Syntax.pos = _55_1490; FStar_Syntax_Syntax.vars = _55_1488}, us2)) -> begin
(

let b = (FStar_Syntax_Syntax.fv_eq f g)
in (

let _55_1501 = ()
in (aux wl us1 us2)))
end
| ((FStar_Syntax_Syntax.Tm_uinst (_), _)) | ((_, FStar_Syntax_Syntax.Tm_uinst (_))) -> begin
(FStar_All.failwith "Impossible: expect head symbols to match")
end
| _55_1516 -> begin
USolved (wl)
end)))))
and giveup_or_defer : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  worklist  ->  Prims.string  ->  solution = (fun env orig wl msg -> if wl.defer_ok then begin
(

let _55_1521 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_827 = (prob_to_string env orig)
in (FStar_Util.print2 "\n\t\tDeferring %s\n\t\tBecause %s\n" _144_827 msg))
end else begin
()
end
in (solve env (defer msg orig wl)))
end else begin
(giveup env msg orig)
end)
and solve_rigid_flex_meet : FStar_TypeChecker_Env.env  ->  (FStar_Syntax_Syntax.typ, FStar_Syntax_Syntax.term) FStar_TypeChecker_Common.problem  ->  worklist  ->  worklist Prims.option = (fun env tp wl -> (

let _55_1526 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(let _144_831 = (FStar_Util.string_of_int tp.FStar_TypeChecker_Common.pid)
in (FStar_Util.print1 "Trying to solve by meeting refinements:%s\n" _144_831))
end else begin
()
end
in (

let _55_1530 = (FStar_Syntax_Util.head_and_args tp.FStar_TypeChecker_Common.rhs)
in (match (_55_1530) with
| (u, args) -> begin
(

let rec disjoin = (fun t1 t2 -> (

let _55_1536 = (head_matches_delta env () t1 t2)
in (match (_55_1536) with
| (mr, ts) -> begin
(match (mr) with
| MisMatch (_55_1538) -> begin
None
end
| FullMatch -> begin
(match (ts) with
| None -> begin
Some ((t1, []))
end
| Some (t1, t2) -> begin
Some ((t1, []))
end)
end
| HeadMatch -> begin
(

let _55_1554 = (match (ts) with
| Some (t1, t2) -> begin
(let _144_837 = (FStar_Syntax_Subst.compress t1)
in (let _144_836 = (FStar_Syntax_Subst.compress t2)
in (_144_837, _144_836)))
end
| None -> begin
(let _144_839 = (FStar_Syntax_Subst.compress t1)
in (let _144_838 = (FStar_Syntax_Subst.compress t2)
in (_144_839, _144_838)))
end)
in (match (_55_1554) with
| (t1, t2) -> begin
(

let eq_prob = (fun t1 t2 -> (let _144_845 = (new_problem env t1 FStar_TypeChecker_Common.EQ t2 None t1.FStar_Syntax_Syntax.pos "meeting refinements")
in (FStar_All.pipe_left (fun _144_844 -> FStar_TypeChecker_Common.TProb (_144_844)) _144_845)))
in (match ((t1.FStar_Syntax_Syntax.n, t2.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_refine (x, phi1), FStar_Syntax_Syntax.Tm_refine (y, phi2)) -> begin
(let _144_852 = (let _144_851 = (let _144_848 = (let _144_847 = (let _144_846 = (FStar_Syntax_Util.mk_disj phi1 phi2)
in (x, _144_846))
in FStar_Syntax_Syntax.Tm_refine (_144_847))
in (FStar_Syntax_Syntax.mk _144_848 None t1.FStar_Syntax_Syntax.pos))
in (let _144_850 = (let _144_849 = (eq_prob x.FStar_Syntax_Syntax.sort y.FStar_Syntax_Syntax.sort)
in (_144_849)::[])
in (_144_851, _144_850)))
in Some (_144_852))
end
| (_55_1568, FStar_Syntax_Syntax.Tm_refine (x, _55_1571)) -> begin
(let _144_855 = (let _144_854 = (let _144_853 = (eq_prob x.FStar_Syntax_Syntax.sort t1)
in (_144_853)::[])
in (t1, _144_854))
in Some (_144_855))
end
| (FStar_Syntax_Syntax.Tm_refine (x, _55_1577), _55_1581) -> begin
(let _144_858 = (let _144_857 = (let _144_856 = (eq_prob x.FStar_Syntax_Syntax.sort t2)
in (_144_856)::[])
in (t2, _144_857))
in Some (_144_858))
end
| _55_1584 -> begin
(

let _55_1588 = (FStar_Syntax_Util.head_and_args t1)
in (match (_55_1588) with
| (head1, _55_1587) -> begin
(match ((let _144_859 = (FStar_Syntax_Util.un_uinst head1)
in _144_859.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_fvar ({FStar_Syntax_Syntax.fv_name = _55_1594; FStar_Syntax_Syntax.fv_delta = FStar_Syntax_Syntax.Delta_unfoldable (i); FStar_Syntax_Syntax.fv_qual = _55_1590}) -> begin
(

let prev = if (i > 1) then begin
FStar_Syntax_Syntax.Delta_unfoldable ((i - 1))
end else begin
FStar_Syntax_Syntax.Delta_constant
end
in (

let t1 = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.WHNF)::(FStar_TypeChecker_Normalize.UnfoldUntil (prev))::[]) env t1)
in (

let t2 = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.WHNF)::(FStar_TypeChecker_Normalize.UnfoldUntil (prev))::[]) env t2)
in (disjoin t1 t2))))
end
| _55_1601 -> begin
None
end)
end))
end))
end))
end)
end)))
in (

let tt = u
in (match (tt.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_uvar (uv, _55_1605) -> begin
(

let _55_1630 = (FStar_All.pipe_right wl.attempting (FStar_List.partition (fun _55_23 -> (match (_55_23) with
| FStar_TypeChecker_Common.TProb (tp) -> begin
(match (tp.FStar_TypeChecker_Common.rank) with
| Some (rank) when (is_rigid_flex rank) -> begin
(

let _55_1616 = (FStar_Syntax_Util.head_and_args tp.FStar_TypeChecker_Common.rhs)
in (match (_55_1616) with
| (u', _55_1615) -> begin
(match ((let _144_861 = (whnf env u')
in _144_861.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_uvar (uv', _55_1619) -> begin
(FStar_Unionfind.equivalent uv uv')
end
| _55_1623 -> begin
false
end)
end))
end
| _55_1625 -> begin
false
end)
end
| _55_1627 -> begin
false
end))))
in (match (_55_1630) with
| (lower_bounds, rest) -> begin
(

let rec make_lower_bound = (fun _55_1634 tps -> (match (_55_1634) with
| (bound, sub_probs) -> begin
(match (tps) with
| [] -> begin
Some ((bound, sub_probs))
end
| FStar_TypeChecker_Common.TProb (hd)::tl -> begin
(match ((let _144_866 = (whnf env hd.FStar_TypeChecker_Common.lhs)
in (disjoin bound _144_866))) with
| Some (bound, sub) -> begin
(make_lower_bound (bound, (FStar_List.append sub sub_probs)) tl)
end
| None -> begin
None
end)
end
| _55_1647 -> begin
None
end)
end))
in (match ((let _144_868 = (let _144_867 = (whnf env tp.FStar_TypeChecker_Common.lhs)
in (_144_867, []))
in (make_lower_bound _144_868 lower_bounds))) with
| None -> begin
(

let _55_1649 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(FStar_Util.print_string "No lower bounds\n")
end else begin
()
end
in None)
end
| Some (lhs_bound, sub_probs) -> begin
(

let eq_prob = (new_problem env lhs_bound FStar_TypeChecker_Common.EQ tp.FStar_TypeChecker_Common.rhs None tp.FStar_TypeChecker_Common.loc "meeting refinements")
in (

let _55_1659 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(

let wl' = (

let _55_1656 = wl
in {attempting = (FStar_TypeChecker_Common.TProb (eq_prob))::sub_probs; wl_deferred = _55_1656.wl_deferred; ctr = _55_1656.ctr; defer_ok = _55_1656.defer_ok; smt_ok = _55_1656.smt_ok; tcenv = _55_1656.tcenv})
in (let _144_869 = (wl_to_string wl')
in (FStar_Util.print1 "After meeting refinements: %s\n" _144_869)))
end else begin
()
end
in (match ((solve_t env eq_prob (

let _55_1661 = wl
in {attempting = sub_probs; wl_deferred = _55_1661.wl_deferred; ctr = _55_1661.ctr; defer_ok = _55_1661.defer_ok; smt_ok = _55_1661.smt_ok; tcenv = _55_1661.tcenv}))) with
| Success (_55_1664) -> begin
(

let wl = (

let _55_1666 = wl
in {attempting = rest; wl_deferred = _55_1666.wl_deferred; ctr = _55_1666.ctr; defer_ok = _55_1666.defer_ok; smt_ok = _55_1666.smt_ok; tcenv = _55_1666.tcenv})
in (

let wl = (solve_prob' false (FStar_TypeChecker_Common.TProb (tp)) None [] wl)
in (

let _55_1672 = (FStar_List.fold_left (fun wl p -> (solve_prob' true p None [] wl)) wl lower_bounds)
in Some (wl))))
end
| _55_1675 -> begin
None
end)))
end))
end))
end
| _55_1677 -> begin
(FStar_All.failwith "Impossible: Not a rigid-flex")
end)))
end))))
and solve_flex_rigid_join : FStar_TypeChecker_Env.env  ->  (FStar_Syntax_Syntax.typ, FStar_Syntax_Syntax.term) FStar_TypeChecker_Common.problem  ->  worklist  ->  worklist Prims.option = (fun env tp wl -> (

let _55_1681 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(let _144_875 = (FStar_Util.string_of_int tp.FStar_TypeChecker_Common.pid)
in (FStar_Util.print1 "Trying to solve by joining refinements:%s\n" _144_875))
end else begin
()
end
in (

let _55_1685 = (FStar_Syntax_Util.head_and_args tp.FStar_TypeChecker_Common.lhs)
in (match (_55_1685) with
| (u, args) -> begin
(

let _55_1691 = (0, 1, 2, 3, 4)
in (match (_55_1691) with
| (ok, head_match, partial_match, fallback, failed_match) -> begin
(

let max = (fun i j -> if (i < j) then begin
j
end else begin
i
end)
in (

let base_types_match = (fun t1 t2 -> (

let _55_1700 = (FStar_Syntax_Util.head_and_args t1)
in (match (_55_1700) with
| (h1, args1) -> begin
(

let _55_1704 = (FStar_Syntax_Util.head_and_args t2)
in (match (_55_1704) with
| (h2, _55_1703) -> begin
(match ((h1.FStar_Syntax_Syntax.n, h2.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_fvar (tc1), FStar_Syntax_Syntax.Tm_fvar (tc2)) -> begin
if (FStar_Syntax_Syntax.fv_eq tc1 tc2) then begin
if ((FStar_List.length args1) = 0) then begin
Some ([])
end else begin
(let _144_887 = (let _144_886 = (let _144_885 = (new_problem env t1 FStar_TypeChecker_Common.EQ t2 None t1.FStar_Syntax_Syntax.pos "joining refinements")
in (FStar_All.pipe_left (fun _144_884 -> FStar_TypeChecker_Common.TProb (_144_884)) _144_885))
in (_144_886)::[])
in Some (_144_887))
end
end else begin
None
end
end
| (FStar_Syntax_Syntax.Tm_name (a), FStar_Syntax_Syntax.Tm_name (b)) -> begin
if (FStar_Syntax_Syntax.bv_eq a b) then begin
if ((FStar_List.length args1) = 0) then begin
Some ([])
end else begin
(let _144_891 = (let _144_890 = (let _144_889 = (new_problem env t1 FStar_TypeChecker_Common.EQ t2 None t1.FStar_Syntax_Syntax.pos "joining refinements")
in (FStar_All.pipe_left (fun _144_888 -> FStar_TypeChecker_Common.TProb (_144_888)) _144_889))
in (_144_890)::[])
in Some (_144_891))
end
end else begin
None
end
end
| _55_1716 -> begin
None
end)
end))
end)))
in (

let conjoin = (fun t1 t2 -> (match ((t1.FStar_Syntax_Syntax.n, t2.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_refine (x, phi1), FStar_Syntax_Syntax.Tm_refine (y, phi2)) -> begin
(

let m = (base_types_match x.FStar_Syntax_Syntax.sort y.FStar_Syntax_Syntax.sort)
in (match (m) with
| None -> begin
None
end
| Some (m) -> begin
(

let x = (FStar_Syntax_Syntax.freshen_bv x)
in (

let subst = (FStar_Syntax_Syntax.DB ((0, x)))::[]
in (

let phi1 = (FStar_Syntax_Subst.subst subst phi1)
in (

let phi2 = (FStar_Syntax_Subst.subst subst phi2)
in (let _144_898 = (let _144_897 = (let _144_896 = (FStar_Syntax_Util.mk_conj phi1 phi2)
in (FStar_Syntax_Util.refine x _144_896))
in (_144_897, m))
in Some (_144_898))))))
end))
end
| (_55_1738, FStar_Syntax_Syntax.Tm_refine (y, _55_1741)) -> begin
(

let m = (base_types_match t1 y.FStar_Syntax_Syntax.sort)
in (match (m) with
| None -> begin
None
end
| Some (m) -> begin
Some ((t2, m))
end))
end
| (FStar_Syntax_Syntax.Tm_refine (x, _55_1751), _55_1755) -> begin
(

let m = (base_types_match x.FStar_Syntax_Syntax.sort t2)
in (match (m) with
| None -> begin
None
end
| Some (m) -> begin
Some ((t1, m))
end))
end
| _55_1762 -> begin
(

let m = (base_types_match t1 t2)
in (match (m) with
| None -> begin
None
end
| Some (m) -> begin
Some ((t1, m))
end))
end))
in (

let tt = u
in (match (tt.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_uvar (uv, _55_1770) -> begin
(

let _55_1795 = (FStar_All.pipe_right wl.attempting (FStar_List.partition (fun _55_24 -> (match (_55_24) with
| FStar_TypeChecker_Common.TProb (tp) -> begin
(match (tp.FStar_TypeChecker_Common.rank) with
| Some (rank) when (is_flex_rigid rank) -> begin
(

let _55_1781 = (FStar_Syntax_Util.head_and_args tp.FStar_TypeChecker_Common.lhs)
in (match (_55_1781) with
| (u', _55_1780) -> begin
(match ((let _144_900 = (whnf env u')
in _144_900.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_uvar (uv', _55_1784) -> begin
(FStar_Unionfind.equivalent uv uv')
end
| _55_1788 -> begin
false
end)
end))
end
| _55_1790 -> begin
false
end)
end
| _55_1792 -> begin
false
end))))
in (match (_55_1795) with
| (upper_bounds, rest) -> begin
(

let rec make_upper_bound = (fun _55_1799 tps -> (match (_55_1799) with
| (bound, sub_probs) -> begin
(match (tps) with
| [] -> begin
Some ((bound, sub_probs))
end
| FStar_TypeChecker_Common.TProb (hd)::tl -> begin
(match ((let _144_905 = (whnf env hd.FStar_TypeChecker_Common.rhs)
in (conjoin bound _144_905))) with
| Some (bound, sub) -> begin
(make_upper_bound (bound, (FStar_List.append sub sub_probs)) tl)
end
| None -> begin
None
end)
end
| _55_1812 -> begin
None
end)
end))
in (match ((let _144_907 = (let _144_906 = (whnf env tp.FStar_TypeChecker_Common.rhs)
in (_144_906, []))
in (make_upper_bound _144_907 upper_bounds))) with
| None -> begin
(

let _55_1814 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(FStar_Util.print_string "No upper bounds\n")
end else begin
()
end
in None)
end
| Some (rhs_bound, sub_probs) -> begin
(

let eq_prob = (new_problem env tp.FStar_TypeChecker_Common.lhs FStar_TypeChecker_Common.EQ rhs_bound None tp.FStar_TypeChecker_Common.loc "joining refinements")
in (

let _55_1824 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(

let wl' = (

let _55_1821 = wl
in {attempting = (FStar_TypeChecker_Common.TProb (eq_prob))::sub_probs; wl_deferred = _55_1821.wl_deferred; ctr = _55_1821.ctr; defer_ok = _55_1821.defer_ok; smt_ok = _55_1821.smt_ok; tcenv = _55_1821.tcenv})
in (let _144_908 = (wl_to_string wl')
in (FStar_Util.print1 "After joining refinements: %s\n" _144_908)))
end else begin
()
end
in (match ((solve_t env eq_prob (

let _55_1826 = wl
in {attempting = sub_probs; wl_deferred = _55_1826.wl_deferred; ctr = _55_1826.ctr; defer_ok = _55_1826.defer_ok; smt_ok = _55_1826.smt_ok; tcenv = _55_1826.tcenv}))) with
| Success (_55_1829) -> begin
(

let wl = (

let _55_1831 = wl
in {attempting = rest; wl_deferred = _55_1831.wl_deferred; ctr = _55_1831.ctr; defer_ok = _55_1831.defer_ok; smt_ok = _55_1831.smt_ok; tcenv = _55_1831.tcenv})
in (

let wl = (solve_prob' false (FStar_TypeChecker_Common.TProb (tp)) None [] wl)
in (

let _55_1837 = (FStar_List.fold_left (fun wl p -> (solve_prob' true p None [] wl)) wl upper_bounds)
in Some (wl))))
end
| _55_1840 -> begin
None
end)))
end))
end))
end
| _55_1842 -> begin
(FStar_All.failwith "Impossible: Not a flex-rigid")
end)))))
end))
end))))
and solve_binders : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.binders  ->  FStar_TypeChecker_Common.prob  ->  worklist  ->  (FStar_Syntax_Syntax.binders  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.subst_elt Prims.list  ->  FStar_TypeChecker_Common.prob)  ->  solution = (fun env bs1 bs2 orig wl rhs -> (

let rec aux = (fun scope env subst xs ys -> (match ((xs, ys)) with
| ([], []) -> begin
(

let rhs_prob = (rhs (FStar_List.rev scope) env subst)
in (

let _55_1859 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_936 = (prob_to_string env rhs_prob)
in (FStar_Util.print1 "rhs_prob = %s\n" _144_936))
end else begin
()
end
in (

let formula = (FStar_All.pipe_right (p_guard rhs_prob) Prims.fst)
in FStar_Util.Inl (((rhs_prob)::[], formula)))))
end
| ((hd1, imp)::xs, (hd2, imp')::ys) when (imp = imp') -> begin
(

let hd1 = (

let _55_1873 = hd1
in (let _144_937 = (FStar_Syntax_Subst.subst subst hd1.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _55_1873.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _55_1873.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _144_937}))
in (

let hd2 = (

let _55_1876 = hd2
in (let _144_938 = (FStar_Syntax_Subst.subst subst hd2.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _55_1876.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _55_1876.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _144_938}))
in (

let prob = (let _144_941 = (let _144_940 = (FStar_All.pipe_left invert_rel (p_rel orig))
in (mk_problem scope orig hd1.FStar_Syntax_Syntax.sort _144_940 hd2.FStar_Syntax_Syntax.sort None "Formal parameter"))
in (FStar_All.pipe_left (fun _144_939 -> FStar_TypeChecker_Common.TProb (_144_939)) _144_941))
in (

let hd1 = (FStar_Syntax_Syntax.freshen_bv hd1)
in (

let subst = (let _144_942 = (FStar_Syntax_Subst.shift_subst 1 subst)
in (FStar_Syntax_Syntax.DB ((0, hd1)))::_144_942)
in (

let env = (FStar_TypeChecker_Env.push_bv env hd1)
in (match ((aux (((hd1, imp))::scope) env subst xs ys)) with
| FStar_Util.Inl (sub_probs, phi) -> begin
(

let phi = (let _144_944 = (FStar_All.pipe_right (p_guard prob) Prims.fst)
in (let _144_943 = (FStar_Syntax_Util.close_forall (((hd1, imp))::[]) phi)
in (FStar_Syntax_Util.mk_conj _144_944 _144_943)))
in (

let _55_1888 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_946 = (FStar_Syntax_Print.term_to_string phi)
in (let _144_945 = (FStar_Syntax_Print.bv_to_string hd1)
in (FStar_Util.print2 "Formula is %s\n\thd1=%s\n" _144_946 _144_945)))
end else begin
()
end
in FStar_Util.Inl (((prob)::sub_probs, phi))))
end
| fail -> begin
fail
end)))))))
end
| _55_1892 -> begin
FStar_Util.Inr ("arity or argument-qualifier mismatch")
end))
in (

let scope = (p_scope orig)
in (match ((aux scope env [] bs1 bs2)) with
| FStar_Util.Inr (msg) -> begin
(giveup env msg orig)
end
| FStar_Util.Inl (sub_probs, phi) -> begin
(

let wl = (solve_prob orig (Some (phi)) [] wl)
in (solve env (attempt sub_probs wl)))
end))))
and solve_t : FStar_TypeChecker_Env.env  ->  tprob  ->  worklist  ->  solution = (fun env problem wl -> (let _144_950 = (compress_tprob wl problem)
in (solve_t' env _144_950 wl)))
and solve_t' : FStar_TypeChecker_Env.env  ->  tprob  ->  worklist  ->  solution = (fun env problem wl -> (

let giveup_or_defer = (fun orig msg -> (giveup_or_defer env orig wl msg))
in (

let rigid_rigid_delta = (fun env orig wl head1 head2 t1 t2 -> (

let _55_1920 = (head_matches_delta env wl t1 t2)
in (match (_55_1920) with
| (m, o) -> begin
(match ((m, o)) with
| (MisMatch (_55_1922), _55_1925) -> begin
(

let may_relate = (fun head -> (match (head.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_name (_)) | (FStar_Syntax_Syntax.Tm_match (_)) -> begin
true
end
| FStar_Syntax_Syntax.Tm_fvar (tc) -> begin
(tc.FStar_Syntax_Syntax.fv_delta = FStar_Syntax_Syntax.Delta_equational)
end
| _55_1938 -> begin
false
end))
in if (((may_relate head1) || (may_relate head2)) && wl.smt_ok) then begin
(

let guard = if (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) then begin
(FStar_Syntax_Util.mk_eq FStar_Syntax_Syntax.tun FStar_Syntax_Syntax.tun t1 t2)
end else begin
(

let has_type_guard = (fun t1 t2 -> (match (problem.FStar_TypeChecker_Common.element) with
| Some (t) -> begin
(FStar_Syntax_Util.mk_has_type t1 t t2)
end
| None -> begin
(

let x = (FStar_Syntax_Syntax.new_bv None t1)
in (let _144_979 = (let _144_978 = (FStar_Syntax_Syntax.bv_to_name x)
in (FStar_Syntax_Util.mk_has_type t1 _144_978 t2))
in (FStar_Syntax_Util.mk_forall x _144_979)))
end))
in if (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.SUB) then begin
(has_type_guard t1 t2)
end else begin
(has_type_guard t2 t1)
end)
end
in (let _144_980 = (solve_prob orig (Some (guard)) [] wl)
in (solve env _144_980)))
end else begin
(giveup env "head mismatch" orig)
end)
end
| (_55_1948, Some (t1, t2)) -> begin
(solve_t env (

let _55_1954 = problem
in {FStar_TypeChecker_Common.pid = _55_1954.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = t1; FStar_TypeChecker_Common.relation = _55_1954.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = t2; FStar_TypeChecker_Common.element = _55_1954.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_1954.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_1954.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_1954.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_1954.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_1954.FStar_TypeChecker_Common.rank}) wl)
end
| (_55_1957, None) -> begin
(

let _55_1960 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_984 = (FStar_Syntax_Print.term_to_string t1)
in (let _144_983 = (FStar_Syntax_Print.tag_of_term t1)
in (let _144_982 = (FStar_Syntax_Print.term_to_string t2)
in (let _144_981 = (FStar_Syntax_Print.tag_of_term t2)
in (FStar_Util.print4 "Head matches: %s (%s) and %s (%s)\n" _144_984 _144_983 _144_982 _144_981)))))
end else begin
()
end
in (

let _55_1964 = (FStar_Syntax_Util.head_and_args t1)
in (match (_55_1964) with
| (head1, args1) -> begin
(

let _55_1967 = (FStar_Syntax_Util.head_and_args t2)
in (match (_55_1967) with
| (head2, args2) -> begin
(

let nargs = (FStar_List.length args1)
in if (nargs <> (FStar_List.length args2)) then begin
(let _144_989 = (let _144_988 = (FStar_Syntax_Print.term_to_string head1)
in (let _144_987 = (args_to_string args1)
in (let _144_986 = (FStar_Syntax_Print.term_to_string head2)
in (let _144_985 = (args_to_string args2)
in (FStar_Util.format4 "unequal number of arguments: %s[%s] and %s[%s]" _144_988 _144_987 _144_986 _144_985)))))
in (giveup env _144_989 orig))
end else begin
if ((nargs = 0) || (eq_args args1 args2)) then begin
(match ((solve_maybe_uinsts env orig head1 head2 wl)) with
| USolved (wl) -> begin
(let _144_990 = (solve_prob orig None [] wl)
in (solve env _144_990))
end
| UFailed (msg) -> begin
(giveup env msg orig)
end
| UDeferred (wl) -> begin
(solve env (defer "universe constraints" orig wl))
end)
end else begin
(

let _55_1977 = (base_and_refinement env wl t1)
in (match (_55_1977) with
| (base1, refinement1) -> begin
(

let _55_1980 = (base_and_refinement env wl t2)
in (match (_55_1980) with
| (base2, refinement2) -> begin
(match ((refinement1, refinement2)) with
| (None, None) -> begin
(match ((solve_maybe_uinsts env orig head1 head2 wl)) with
| UFailed (msg) -> begin
(giveup env msg orig)
end
| UDeferred (wl) -> begin
(solve env (defer "universe constraints" orig wl))
end
| USolved (wl) -> begin
(

let subprobs = (FStar_List.map2 (fun _55_1993 _55_1997 -> (match ((_55_1993, _55_1997)) with
| ((a, _55_1992), (a', _55_1996)) -> begin
(let _144_994 = (mk_problem (p_scope orig) orig a FStar_TypeChecker_Common.EQ a' None "index")
in (FStar_All.pipe_left (fun _144_993 -> FStar_TypeChecker_Common.TProb (_144_993)) _144_994))
end)) args1 args2)
in (

let formula = (let _144_996 = (FStar_List.map (fun p -> (Prims.fst (p_guard p))) subprobs)
in (FStar_Syntax_Util.mk_conj_l _144_996))
in (

let wl = (solve_prob orig (Some (formula)) [] wl)
in (solve env (attempt subprobs wl)))))
end)
end
| _55_2003 -> begin
(

let lhs = (force_refinement (base1, refinement1))
in (

let rhs = (force_refinement (base2, refinement2))
in (solve_t env (

let _55_2006 = problem
in {FStar_TypeChecker_Common.pid = _55_2006.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = lhs; FStar_TypeChecker_Common.relation = _55_2006.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = rhs; FStar_TypeChecker_Common.element = _55_2006.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_2006.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_2006.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_2006.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_2006.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_2006.FStar_TypeChecker_Common.rank}) wl)))
end)
end))
end))
end
end)
end))
end)))
end)
end)))
in (

let imitate = (fun orig env wl p -> (

let _55_2025 = p
in (match (_55_2025) with
| (((u, k), xs, c), ps, (h, _55_2022, qs)) -> begin
(

let xs = (sn_binders env xs)
in (

let r = (FStar_TypeChecker_Env.get_range env)
in (

let _55_2031 = (imitation_sub_probs orig env xs ps qs)
in (match (_55_2031) with
| (sub_probs, gs_xs, formula) -> begin
(

let im = (let _144_1011 = (h gs_xs)
in (let _144_1010 = (let _144_1009 = (FStar_All.pipe_right (FStar_Syntax_Util.lcomp_of_comp c) (fun _144_1007 -> FStar_Util.Inl (_144_1007)))
in (FStar_All.pipe_right _144_1009 (fun _144_1008 -> Some (_144_1008))))
in (FStar_Syntax_Util.abs xs _144_1011 _144_1010)))
in (

let _55_2033 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1018 = (FStar_Syntax_Print.binders_to_string ", " xs)
in (let _144_1017 = (FStar_Syntax_Print.comp_to_string c)
in (let _144_1016 = (FStar_Syntax_Print.term_to_string im)
in (let _144_1015 = (FStar_Syntax_Print.tag_of_term im)
in (let _144_1014 = (let _144_1012 = (FStar_List.map (prob_to_string env) sub_probs)
in (FStar_All.pipe_right _144_1012 (FStar_String.concat ", ")))
in (let _144_1013 = (FStar_TypeChecker_Normalize.term_to_string env formula)
in (FStar_Util.print6 "Imitating  binders are %s, comp=%s\n\t%s (%s)\nsub_probs = %s\nformula=%s\n" _144_1018 _144_1017 _144_1016 _144_1015 _144_1014 _144_1013)))))))
end else begin
()
end
in (

let wl = (solve_prob orig (Some (formula)) ((TERM (((u, k), im)))::[]) wl)
in (solve env (attempt sub_probs wl)))))
end))))
end)))
in (

let imitate' = (fun orig env wl _55_25 -> (match (_55_25) with
| None -> begin
(giveup env "unable to compute subterms" orig)
end
| Some (p) -> begin
(imitate orig env wl p)
end))
in (

let project = (fun orig env wl i p -> (

let _55_2059 = p
in (match (_55_2059) with
| ((u, xs, c), ps, (h, matches, qs)) -> begin
(

let r = (FStar_TypeChecker_Env.get_range env)
in (

let _55_2064 = (FStar_List.nth ps i)
in (match (_55_2064) with
| (pi, _55_2063) -> begin
(

let _55_2068 = (FStar_List.nth xs i)
in (match (_55_2068) with
| (xi, _55_2067) -> begin
(

let rec gs = (fun k -> (

let _55_2073 = (FStar_Syntax_Util.arrow_formals k)
in (match (_55_2073) with
| (bs, k) -> begin
(

let rec aux = (fun subst bs -> (match (bs) with
| [] -> begin
([], [])
end
| (a, _55_2081)::tl -> begin
(

let k_a = (FStar_Syntax_Subst.subst subst a.FStar_Syntax_Syntax.sort)
in (

let _55_2087 = (new_uvar r xs k_a)
in (match (_55_2087) with
| (gi_xs, gi) -> begin
(

let gi_xs = (FStar_TypeChecker_Normalize.eta_expand env gi_xs)
in (

let gi_ps = (FStar_Syntax_Syntax.mk_Tm_app gi ps (Some (k_a.FStar_Syntax_Syntax.n)) r)
in (

let subst = (FStar_Syntax_Syntax.NT ((a, gi_xs)))::subst
in (

let _55_2093 = (aux subst tl)
in (match (_55_2093) with
| (gi_xs', gi_ps') -> begin
(let _144_1048 = (let _144_1045 = (FStar_Syntax_Syntax.as_arg gi_xs)
in (_144_1045)::gi_xs')
in (let _144_1047 = (let _144_1046 = (FStar_Syntax_Syntax.as_arg gi_ps)
in (_144_1046)::gi_ps')
in (_144_1048, _144_1047)))
end)))))
end)))
end))
in (aux [] bs))
end)))
in if (let _144_1049 = (matches pi)
in (FStar_All.pipe_left Prims.op_Negation _144_1049)) then begin
None
end else begin
(

let _55_2097 = (gs xi.FStar_Syntax_Syntax.sort)
in (match (_55_2097) with
| (g_xs, _55_2096) -> begin
(

let xi = (FStar_Syntax_Syntax.bv_to_name xi)
in (

let proj = (let _144_1054 = (FStar_Syntax_Syntax.mk_Tm_app xi g_xs None r)
in (let _144_1053 = (let _144_1052 = (FStar_All.pipe_right (FStar_Syntax_Util.lcomp_of_comp c) (fun _144_1050 -> FStar_Util.Inl (_144_1050)))
in (FStar_All.pipe_right _144_1052 (fun _144_1051 -> Some (_144_1051))))
in (FStar_Syntax_Util.abs xs _144_1054 _144_1053)))
in (

let sub = (let _144_1060 = (let _144_1059 = (FStar_Syntax_Syntax.mk_Tm_app proj ps None r)
in (let _144_1058 = (let _144_1057 = (FStar_List.map (fun _55_2105 -> (match (_55_2105) with
| (_55_2101, _55_2103, y) -> begin
y
end)) qs)
in (FStar_All.pipe_left h _144_1057))
in (mk_problem (p_scope orig) orig _144_1059 (p_rel orig) _144_1058 None "projection")))
in (FStar_All.pipe_left (fun _144_1055 -> FStar_TypeChecker_Common.TProb (_144_1055)) _144_1060))
in (

let _55_2107 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1062 = (FStar_Syntax_Print.term_to_string proj)
in (let _144_1061 = (prob_to_string env sub)
in (FStar_Util.print2 "Projecting %s\n\tsubprob=%s\n" _144_1062 _144_1061)))
end else begin
()
end
in (

let wl = (let _144_1064 = (let _144_1063 = (FStar_All.pipe_left Prims.fst (p_guard sub))
in Some (_144_1063))
in (solve_prob orig _144_1064 ((TERM ((u, proj)))::[]) wl))
in (let _144_1066 = (solve env (attempt ((sub)::[]) wl))
in (FStar_All.pipe_left (fun _144_1065 -> Some (_144_1065)) _144_1066)))))))
end))
end)
end))
end)))
end)))
in (

let solve_t_flex_rigid = (fun orig lhs t2 wl -> (

let _55_2121 = lhs
in (match (_55_2121) with
| ((t1, uv, k_uv, args_lhs), maybe_pat_vars) -> begin
(

let subterms = (fun ps -> (

let _55_2126 = (FStar_Syntax_Util.arrow_formals_comp k_uv)
in (match (_55_2126) with
| (xs, c) -> begin
if ((FStar_List.length xs) = (FStar_List.length ps)) then begin
(let _144_1088 = (let _144_1087 = (decompose env t2)
in (((uv, k_uv), xs, c), ps, _144_1087))
in Some (_144_1088))
end else begin
(

let k_uv = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::[]) env k_uv)
in (

let rec elim = (fun k args -> (match ((let _144_1094 = (let _144_1093 = (FStar_Syntax_Subst.compress k)
in _144_1093.FStar_Syntax_Syntax.n)
in (_144_1094, args))) with
| (_55_2132, []) -> begin
(let _144_1096 = (let _144_1095 = (FStar_Syntax_Syntax.mk_Total k)
in ([], _144_1095))
in Some (_144_1096))
end
| ((FStar_Syntax_Syntax.Tm_uvar (_), _)) | ((FStar_Syntax_Syntax.Tm_app (_), _)) -> begin
(

let _55_2149 = (FStar_Syntax_Util.head_and_args k)
in (match (_55_2149) with
| (uv, uv_args) -> begin
(match ((let _144_1097 = (FStar_Syntax_Subst.compress uv)
in _144_1097.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_uvar (uvar, _55_2152) -> begin
(match ((pat_vars env [] uv_args)) with
| None -> begin
None
end
| Some (scope) -> begin
(

let xs = (FStar_All.pipe_right args (FStar_List.map (fun _55_2158 -> (let _144_1103 = (let _144_1102 = (let _144_1101 = (let _144_1100 = (let _144_1099 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _144_1099 Prims.fst))
in (new_uvar k.FStar_Syntax_Syntax.pos scope _144_1100))
in (Prims.fst _144_1101))
in (FStar_Syntax_Syntax.new_bv (Some (k.FStar_Syntax_Syntax.pos)) _144_1102))
in (FStar_All.pipe_left FStar_Syntax_Syntax.mk_binder _144_1103)))))
in (

let c = (let _144_1107 = (let _144_1106 = (let _144_1105 = (let _144_1104 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _144_1104 Prims.fst))
in (new_uvar k.FStar_Syntax_Syntax.pos scope _144_1105))
in (Prims.fst _144_1106))
in (FStar_Syntax_Syntax.mk_Total _144_1107))
in (

let k' = (FStar_Syntax_Util.arrow xs c)
in (

let uv_sol = (let _144_1113 = (let _144_1112 = (let _144_1111 = (let _144_1110 = (let _144_1109 = (let _144_1108 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _144_1108 Prims.fst))
in (FStar_Syntax_Syntax.mk_Total _144_1109))
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _144_1110))
in FStar_Util.Inl (_144_1111))
in Some (_144_1112))
in (FStar_Syntax_Util.abs scope k' _144_1113))
in (

let _55_2164 = (FStar_Unionfind.change uvar (FStar_Syntax_Syntax.Fixed (uv_sol)))
in Some ((xs, c)))))))
end)
end
| _55_2167 -> begin
None
end)
end))
end
| (FStar_Syntax_Syntax.Tm_arrow (xs, c), _55_2173) -> begin
(

let n_args = (FStar_List.length args)
in (

let n_xs = (FStar_List.length xs)
in if (n_xs = n_args) then begin
(let _144_1115 = (FStar_Syntax_Subst.open_comp xs c)
in (FStar_All.pipe_right _144_1115 (fun _144_1114 -> Some (_144_1114))))
end else begin
if (n_xs < n_args) then begin
(

let _55_2179 = (FStar_Util.first_N n_xs args)
in (match (_55_2179) with
| (args, rest) -> begin
(

let _55_2182 = (FStar_Syntax_Subst.open_comp xs c)
in (match (_55_2182) with
| (xs, c) -> begin
(let _144_1117 = (elim (FStar_Syntax_Util.comp_result c) rest)
in (FStar_Util.bind_opt _144_1117 (fun _55_2185 -> (match (_55_2185) with
| (xs', c) -> begin
Some (((FStar_List.append xs xs'), c))
end))))
end))
end))
end else begin
(

let _55_2188 = (FStar_Util.first_N n_args xs)
in (match (_55_2188) with
| (xs, rest) -> begin
(

let t = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow ((rest, c))) None k.FStar_Syntax_Syntax.pos)
in (let _144_1120 = (let _144_1118 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_Syntax_Subst.open_comp xs _144_1118))
in (FStar_All.pipe_right _144_1120 (fun _144_1119 -> Some (_144_1119)))))
end))
end
end))
end
| _55_2191 -> begin
(let _144_1124 = (let _144_1123 = (FStar_Syntax_Print.uvar_to_string uv)
in (let _144_1122 = (FStar_Syntax_Print.term_to_string k)
in (let _144_1121 = (FStar_Syntax_Print.term_to_string k_uv)
in (FStar_Util.format3 "Impossible: ill-typed application %s : %s\n\t%s" _144_1123 _144_1122 _144_1121))))
in (FStar_All.failwith _144_1124))
end))
in (let _144_1162 = (elim k_uv ps)
in (FStar_Util.bind_opt _144_1162 (fun _55_2194 -> (match (_55_2194) with
| (xs, c) -> begin
(let _144_1161 = (let _144_1160 = (decompose env t2)
in (((uv, k_uv), xs, c), ps, _144_1160))
in Some (_144_1161))
end))))))
end
end)))
in (

let rec imitate_or_project = (fun n stopt i -> if ((i >= n) || (FStar_Option.isNone stopt)) then begin
(giveup env "flex-rigid case failed all backtracking attempts" orig)
end else begin
(

let st = (FStar_Option.get stopt)
in (

let tx = (FStar_Unionfind.new_transaction ())
in if (i = (- (1))) then begin
(match ((imitate orig env wl st)) with
| Failed (_55_2202) -> begin
(

let _55_2204 = (FStar_Unionfind.rollback tx)
in (imitate_or_project n stopt (i + 1)))
end
| sol -> begin
sol
end)
end else begin
(match ((project orig env wl i st)) with
| (None) | (Some (Failed (_))) -> begin
(

let _55_2212 = (FStar_Unionfind.rollback tx)
in (imitate_or_project n stopt (i + 1)))
end
| Some (sol) -> begin
sol
end)
end))
end)
in (

let check_head = (fun fvs1 t2 -> (

let _55_2222 = (FStar_Syntax_Util.head_and_args t2)
in (match (_55_2222) with
| (hd, _55_2221) -> begin
(match (hd.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_arrow (_)) | (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_abs (_)) -> begin
true
end
| _55_2233 -> begin
(

let fvs_hd = (FStar_Syntax_Free.names hd)
in if (FStar_Util.set_is_subset_of fvs_hd fvs1) then begin
true
end else begin
(

let _55_2235 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1173 = (names_to_string fvs_hd)
in (FStar_Util.print1 "Free variables are %s" _144_1173))
end else begin
()
end
in false)
end)
end)
end)))
in (

let imitate_ok = (fun t2 -> (

let fvs_hd = (let _144_1177 = (let _144_1176 = (FStar_Syntax_Util.head_and_args t2)
in (FStar_All.pipe_right _144_1176 Prims.fst))
in (FStar_All.pipe_right _144_1177 FStar_Syntax_Free.names))
in if (FStar_Util.set_is_empty fvs_hd) then begin
(- (1))
end else begin
0
end))
in (match (maybe_pat_vars) with
| Some (vars) -> begin
(

let t1 = (sn env t1)
in (

let t2 = (sn env t2)
in (

let fvs1 = (FStar_Syntax_Free.names t1)
in (

let fvs2 = (FStar_Syntax_Free.names t2)
in (

let _55_2248 = (occurs_check env wl (uv, k_uv) t2)
in (match (_55_2248) with
| (occurs_ok, msg) -> begin
if (not (occurs_ok)) then begin
(let _144_1179 = (let _144_1178 = (FStar_Option.get msg)
in (Prims.strcat "occurs-check failed: " _144_1178))
in (giveup_or_defer orig _144_1179))
end else begin
if (FStar_Util.set_is_subset_of fvs2 fvs1) then begin
if ((FStar_Syntax_Util.is_function_typ t2) && ((p_rel orig) <> FStar_TypeChecker_Common.EQ)) then begin
(let _144_1180 = (subterms args_lhs)
in (imitate' orig env wl _144_1180))
end else begin
(

let _55_2249 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1183 = (FStar_Syntax_Print.term_to_string t1)
in (let _144_1182 = (names_to_string fvs1)
in (let _144_1181 = (names_to_string fvs2)
in (FStar_Util.print3 "Pattern %s with fvars=%s succeeded fvar check: %s\n" _144_1183 _144_1182 _144_1181))))
end else begin
()
end
in (

let sol = (match (vars) with
| [] -> begin
t2
end
| _55_2253 -> begin
(let _144_1184 = (sn_binders env vars)
in (u_abs k_uv _144_1184 t2))
end)
in (

let wl = (solve_prob orig None ((TERM (((uv, k_uv), sol)))::[]) wl)
in (solve env wl))))
end
end else begin
if wl.defer_ok then begin
(solve env (defer "flex pattern/rigid: occurs or freevar check" orig wl))
end else begin
if (check_head fvs1 t2) then begin
(

let _55_2256 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1187 = (FStar_Syntax_Print.term_to_string t1)
in (let _144_1186 = (names_to_string fvs1)
in (let _144_1185 = (names_to_string fvs2)
in (FStar_Util.print3 "Pattern %s with fvars=%s failed fvar check: %s ... imitating\n" _144_1187 _144_1186 _144_1185))))
end else begin
()
end
in (let _144_1188 = (subterms args_lhs)
in (imitate_or_project (FStar_List.length args_lhs) _144_1188 (- (1)))))
end else begin
(giveup env "free-variable check failed on a non-redex" orig)
end
end
end
end
end))))))
end
| None -> begin
if wl.defer_ok then begin
(solve env (defer "not a pattern" orig wl))
end else begin
if (let _144_1189 = (FStar_Syntax_Free.names t1)
in (check_head _144_1189 t2)) then begin
(

let im_ok = (imitate_ok t2)
in (

let _55_2260 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1190 = (FStar_Syntax_Print.term_to_string t1)
in (FStar_Util.print2 "Not a pattern (%s) ... %s\n" _144_1190 (if (im_ok < 0) then begin
"imitating"
end else begin
"projecting"
end)))
end else begin
()
end
in (let _144_1191 = (subterms args_lhs)
in (imitate_or_project (FStar_List.length args_lhs) _144_1191 im_ok))))
end else begin
(giveup env "head-symbol is free" orig)
end
end
end)))))
end)))
in (

let flex_flex = (fun orig lhs rhs -> if (wl.defer_ok && ((p_rel orig) <> FStar_TypeChecker_Common.EQ)) then begin
(solve env (defer "flex-flex deferred" orig wl))
end else begin
(

let force_quasi_pattern = (fun xs_opt _55_2272 -> (match (_55_2272) with
| (t, u, k, args) -> begin
(

let _55_2276 = (FStar_Syntax_Util.arrow_formals k)
in (match (_55_2276) with
| (all_formals, _55_2275) -> begin
(

let _55_2277 = ()
in (

let rec aux = (fun pat_args pattern_vars pattern_var_set formals args -> (match ((formals, args)) with
| ([], []) -> begin
(

let pat_args = (FStar_All.pipe_right (FStar_List.rev pat_args) (FStar_List.map (fun _55_2290 -> (match (_55_2290) with
| (x, imp) -> begin
(let _144_1213 = (FStar_Syntax_Syntax.bv_to_name x)
in (_144_1213, imp))
end))))
in (

let pattern_vars = (FStar_List.rev pattern_vars)
in (

let kk = (

let _55_2296 = (FStar_Syntax_Util.type_u ())
in (match (_55_2296) with
| (t, _55_2295) -> begin
(let _144_1214 = (new_uvar t.FStar_Syntax_Syntax.pos pattern_vars t)
in (Prims.fst _144_1214))
end))
in (

let _55_2300 = (new_uvar t.FStar_Syntax_Syntax.pos pattern_vars kk)
in (match (_55_2300) with
| (t', tm_u1) -> begin
(

let _55_2307 = (destruct_flex_t t')
in (match (_55_2307) with
| (_55_2302, u1, k1, _55_2306) -> begin
(

let sol = (let _144_1216 = (let _144_1215 = (u_abs k all_formals t')
in ((u, k), _144_1215))
in TERM (_144_1216))
in (

let t_app = (FStar_Syntax_Syntax.mk_Tm_app tm_u1 pat_args None t.FStar_Syntax_Syntax.pos)
in (sol, (t_app, u1, k1, pat_args))))
end))
end)))))
end
| (formal::formals, hd::tl) -> begin
(match ((pat_var_opt env pat_args hd)) with
| None -> begin
(aux pat_args pattern_vars pattern_var_set formals tl)
end
| Some (y) -> begin
(

let maybe_pat = (match (xs_opt) with
| None -> begin
true
end
| Some (xs) -> begin
(FStar_All.pipe_right xs (FStar_Util.for_some (fun _55_2326 -> (match (_55_2326) with
| (x, _55_2325) -> begin
(FStar_Syntax_Syntax.bv_eq x (Prims.fst y))
end))))
end)
in if (not (maybe_pat)) then begin
(aux pat_args pattern_vars pattern_var_set formals tl)
end else begin
(

let fvs = (FStar_Syntax_Free.names (Prims.fst y).FStar_Syntax_Syntax.sort)
in if (not ((FStar_Util.set_is_subset_of fvs pattern_var_set))) then begin
(aux pat_args pattern_vars pattern_var_set formals tl)
end else begin
(let _144_1218 = (FStar_Util.set_add (Prims.fst formal) pattern_var_set)
in (aux ((y)::pat_args) ((formal)::pattern_vars) _144_1218 formals tl))
end)
end)
end)
end
| _55_2330 -> begin
(FStar_All.failwith "Impossible")
end))
in (let _144_1219 = (FStar_Syntax_Syntax.new_bv_set ())
in (aux [] [] _144_1219 all_formals args))))
end))
end))
in (

let solve_both_pats = (fun wl _55_2337 _55_2342 r -> (match ((_55_2337, _55_2342)) with
| ((u1, k1, xs, args1), (u2, k2, ys, args2)) -> begin
if ((FStar_Unionfind.equivalent u1 u2) && (binders_eq xs ys)) then begin
(let _144_1228 = (solve_prob orig None [] wl)
in (solve env _144_1228))
end else begin
(

let xs = (sn_binders env xs)
in (

let ys = (sn_binders env ys)
in (

let zs = (intersect_vars xs ys)
in (

let _55_2347 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1233 = (FStar_Syntax_Print.binders_to_string ", " xs)
in (let _144_1232 = (FStar_Syntax_Print.binders_to_string ", " ys)
in (let _144_1231 = (FStar_Syntax_Print.binders_to_string ", " zs)
in (let _144_1230 = (FStar_Syntax_Print.term_to_string k1)
in (let _144_1229 = (FStar_Syntax_Print.term_to_string k2)
in (FStar_Util.print5 "Flex-flex patterns: intersected %s and %s; got %s\n\tk1=%s\n\tk2=%s\n" _144_1233 _144_1232 _144_1231 _144_1230 _144_1229))))))
end else begin
()
end
in (

let _55_2360 = (

let _55_2352 = (FStar_Syntax_Util.type_u ())
in (match (_55_2352) with
| (t, _55_2351) -> begin
(

let _55_2356 = (new_uvar r zs t)
in (match (_55_2356) with
| (k, _55_2355) -> begin
(let _144_1239 = (let _144_1234 = (new_uvar r zs k)
in (FStar_All.pipe_left Prims.fst _144_1234))
in (let _144_1238 = (let _144_1235 = (FStar_Syntax_Syntax.mk_Total k)
in (FStar_Syntax_Util.arrow xs _144_1235))
in (let _144_1237 = (let _144_1236 = (FStar_Syntax_Syntax.mk_Total k)
in (FStar_Syntax_Util.arrow ys _144_1236))
in (_144_1239, _144_1238, _144_1237))))
end))
end))
in (match (_55_2360) with
| (u_zs, knew1, knew2) -> begin
(

let sub1 = (u_abs knew1 xs u_zs)
in (

let _55_2364 = (occurs_check env wl (u1, k1) sub1)
in (match (_55_2364) with
| (occurs_ok, msg) -> begin
if (not (occurs_ok)) then begin
(giveup_or_defer orig "flex-flex: failed occcurs check")
end else begin
(

let sol1 = TERM (((u1, k1), sub1))
in if (FStar_Unionfind.equivalent u1 u2) then begin
(

let wl = (solve_prob orig None ((sol1)::[]) wl)
in (solve env wl))
end else begin
(

let sub2 = (u_abs knew2 ys u_zs)
in (

let _55_2370 = (occurs_check env wl (u2, k2) sub2)
in (match (_55_2370) with
| (occurs_ok, msg) -> begin
if (not (occurs_ok)) then begin
(giveup_or_defer orig "flex-flex: failed occurs check")
end else begin
(

let sol2 = TERM (((u2, k2), sub2))
in (

let wl = (solve_prob orig None ((sol1)::(sol2)::[]) wl)
in (solve env wl)))
end
end)))
end)
end
end)))
end))))))
end
end))
in (

let solve_one_pat = (fun _55_2378 _55_2383 -> (match ((_55_2378, _55_2383)) with
| ((t1, u1, k1, xs), (t2, u2, k2, args2)) -> begin
(

let _55_2384 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1245 = (FStar_Syntax_Print.term_to_string t1)
in (let _144_1244 = (FStar_Syntax_Print.term_to_string t2)
in (FStar_Util.print2 "Trying flex-flex one pattern (%s) with %s\n" _144_1245 _144_1244)))
end else begin
()
end
in if (FStar_Unionfind.equivalent u1 u2) then begin
(

let sub_probs = (FStar_List.map2 (fun _55_2389 _55_2393 -> (match ((_55_2389, _55_2393)) with
| ((a, _55_2388), (t2, _55_2392)) -> begin
(let _144_1250 = (let _144_1248 = (FStar_Syntax_Syntax.bv_to_name a)
in (mk_problem (p_scope orig) orig _144_1248 FStar_TypeChecker_Common.EQ t2 None "flex-flex index"))
in (FStar_All.pipe_right _144_1250 (fun _144_1249 -> FStar_TypeChecker_Common.TProb (_144_1249))))
end)) xs args2)
in (

let guard = (let _144_1252 = (FStar_List.map (fun p -> (FStar_All.pipe_right (p_guard p) Prims.fst)) sub_probs)
in (FStar_Syntax_Util.mk_conj_l _144_1252))
in (

let wl = (solve_prob orig (Some (guard)) [] wl)
in (solve env (attempt sub_probs wl)))))
end else begin
(

let t2 = (sn env t2)
in (

let rhs_vars = (FStar_Syntax_Free.names t2)
in (

let _55_2403 = (occurs_check env wl (u1, k1) t2)
in (match (_55_2403) with
| (occurs_ok, _55_2402) -> begin
(

let lhs_vars = (FStar_Syntax_Free.names_of_binders xs)
in if (occurs_ok && (FStar_Util.set_is_subset_of rhs_vars lhs_vars)) then begin
(

let sol = (let _144_1254 = (let _144_1253 = (u_abs k1 xs t2)
in ((u1, k1), _144_1253))
in TERM (_144_1254))
in (

let wl = (solve_prob orig None ((sol)::[]) wl)
in (solve env wl)))
end else begin
if (occurs_ok && (FStar_All.pipe_left Prims.op_Negation wl.defer_ok)) then begin
(

let _55_2414 = (force_quasi_pattern (Some (xs)) (t2, u2, k2, args2))
in (match (_55_2414) with
| (sol, (_55_2409, u2, k2, ys)) -> begin
(

let wl = (extend_solution (p_pid orig) ((sol)::[]) wl)
in (

let _55_2416 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("QuasiPattern"))) then begin
(let _144_1255 = (uvi_to_string env sol)
in (FStar_Util.print1 "flex-flex quasi pattern (2): %s\n" _144_1255))
end else begin
()
end
in (match (orig) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(solve_t env p wl)
end
| _55_2421 -> begin
(giveup env "impossible" orig)
end)))
end))
end else begin
(giveup_or_defer orig "flex-flex constraint")
end
end)
end))))
end)
end))
in (

let _55_2426 = lhs
in (match (_55_2426) with
| (t1, u1, k1, args1) -> begin
(

let _55_2431 = rhs
in (match (_55_2431) with
| (t2, u2, k2, args2) -> begin
(

let maybe_pat_vars1 = (pat_vars env [] args1)
in (

let maybe_pat_vars2 = (pat_vars env [] args2)
in (

let r = t2.FStar_Syntax_Syntax.pos
in (match ((maybe_pat_vars1, maybe_pat_vars2)) with
| (Some (xs), Some (ys)) -> begin
(solve_both_pats wl (u1, k1, xs, args1) (u2, k2, ys, args2) t2.FStar_Syntax_Syntax.pos)
end
| (Some (xs), None) -> begin
(solve_one_pat (t1, u1, k1, xs) rhs)
end
| (None, Some (ys)) -> begin
(solve_one_pat (t2, u2, k2, ys) lhs)
end
| _55_2449 -> begin
if wl.defer_ok then begin
(giveup_or_defer orig "flex-flex: neither side is a pattern")
end else begin
(

let _55_2453 = (force_quasi_pattern None (t1, u1, k1, args1))
in (match (_55_2453) with
| (sol, _55_2452) -> begin
(

let wl = (extend_solution (p_pid orig) ((sol)::[]) wl)
in (

let _55_2455 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("QuasiPattern"))) then begin
(let _144_1256 = (uvi_to_string env sol)
in (FStar_Util.print1 "flex-flex quasi pattern (1): %s\n" _144_1256))
end else begin
()
end
in (match (orig) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(solve_t env p wl)
end
| _55_2460 -> begin
(giveup env "impossible" orig)
end)))
end))
end
end))))
end))
end)))))
end)
in (

let orig = FStar_TypeChecker_Common.TProb (problem)
in if (FStar_Util.physical_equality problem.FStar_TypeChecker_Common.lhs problem.FStar_TypeChecker_Common.rhs) then begin
(let _144_1257 = (solve_prob orig None [] wl)
in (solve env _144_1257))
end else begin
(

let t1 = problem.FStar_TypeChecker_Common.lhs
in (

let t2 = problem.FStar_TypeChecker_Common.rhs
in if (FStar_Util.physical_equality t1 t2) then begin
(let _144_1258 = (solve_prob orig None [] wl)
in (solve env _144_1258))
end else begin
(

let _55_2464 = if (FStar_TypeChecker_Env.debug env (FStar_Options.Other ("RelCheck"))) then begin
(let _144_1259 = (FStar_Util.string_of_int problem.FStar_TypeChecker_Common.pid)
in (FStar_Util.print1 "Attempting %s\n" _144_1259))
end else begin
()
end
in (

let r = (FStar_TypeChecker_Env.get_range env)
in (

let match_num_binders = (fun _55_2469 _55_2472 -> (match ((_55_2469, _55_2472)) with
| ((bs1, mk_cod1), (bs2, mk_cod2)) -> begin
(

let curry = (fun n bs mk_cod -> (

let _55_2479 = (FStar_Util.first_N n bs)
in (match (_55_2479) with
| (bs, rest) -> begin
(let _144_1289 = (mk_cod rest)
in (bs, _144_1289))
end)))
in (

let l1 = (FStar_List.length bs1)
in (

let l2 = (FStar_List.length bs2)
in if (l1 = l2) then begin
(let _144_1293 = (let _144_1290 = (mk_cod1 [])
in (bs1, _144_1290))
in (let _144_1292 = (let _144_1291 = (mk_cod2 [])
in (bs2, _144_1291))
in (_144_1293, _144_1292)))
end else begin
if (l1 > l2) then begin
(let _144_1296 = (curry l2 bs1 mk_cod1)
in (let _144_1295 = (let _144_1294 = (mk_cod2 [])
in (bs2, _144_1294))
in (_144_1296, _144_1295)))
end else begin
(let _144_1299 = (let _144_1297 = (mk_cod1 [])
in (bs1, _144_1297))
in (let _144_1298 = (curry l1 bs2 mk_cod2)
in (_144_1299, _144_1298)))
end
end)))
end))
in (match ((t1.FStar_Syntax_Syntax.n, t2.FStar_Syntax_Syntax.n)) with
| ((FStar_Syntax_Syntax.Tm_bvar (_), _)) | ((_, FStar_Syntax_Syntax.Tm_bvar (_))) -> begin
(FStar_All.failwith "Only locally nameless! We should never see a de Bruijn variable")
end
| (FStar_Syntax_Syntax.Tm_type (u1), FStar_Syntax_Syntax.Tm_type (u2)) -> begin
(solve_one_universe_eq env orig u1 u2 wl)
end
| (FStar_Syntax_Syntax.Tm_arrow (bs1, c1), FStar_Syntax_Syntax.Tm_arrow (bs2, c2)) -> begin
(

let mk_c = (fun c _55_26 -> (match (_55_26) with
| [] -> begin
c
end
| bs -> begin
(let _144_1304 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow ((bs, c))) None c.FStar_Syntax_Syntax.pos)
in (FStar_Syntax_Syntax.mk_Total _144_1304))
end))
in (

let _55_2522 = (match_num_binders (bs1, (mk_c c1)) (bs2, (mk_c c2)))
in (match (_55_2522) with
| ((bs1, c1), (bs2, c2)) -> begin
(solve_binders env bs1 bs2 orig wl (fun scope env subst -> (

let c1 = (FStar_Syntax_Subst.subst_comp subst c1)
in (

let c2 = (FStar_Syntax_Subst.subst_comp subst c2)
in (

let rel = if (FStar_Options.use_eq_at_higher_order ()) then begin
FStar_TypeChecker_Common.EQ
end else begin
problem.FStar_TypeChecker_Common.relation
end
in (let _144_1311 = (mk_problem scope orig c1 rel c2 None "function co-domain")
in (FStar_All.pipe_left (fun _144_1310 -> FStar_TypeChecker_Common.CProb (_144_1310)) _144_1311)))))))
end)))
end
| (FStar_Syntax_Syntax.Tm_abs (bs1, tbody1, lopt1), FStar_Syntax_Syntax.Tm_abs (bs2, tbody2, lopt2)) -> begin
(

let mk_t = (fun t l _55_27 -> (match (_55_27) with
| [] -> begin
t
end
| bs -> begin
(FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_abs ((bs, t, l))) None t.FStar_Syntax_Syntax.pos)
end))
in (

let _55_2552 = (match_num_binders (bs1, (mk_t tbody1 lopt1)) (bs2, (mk_t tbody2 lopt2)))
in (match (_55_2552) with
| ((bs1, tbody1), (bs2, tbody2)) -> begin
(solve_binders env bs1 bs2 orig wl (fun scope env subst -> (let _144_1326 = (let _144_1325 = (FStar_Syntax_Subst.subst subst tbody1)
in (let _144_1324 = (FStar_Syntax_Subst.subst subst tbody2)
in (mk_problem scope orig _144_1325 problem.FStar_TypeChecker_Common.relation _144_1324 None "lambda co-domain")))
in (FStar_All.pipe_left (fun _144_1323 -> FStar_TypeChecker_Common.TProb (_144_1323)) _144_1326))))
end)))
end
| (FStar_Syntax_Syntax.Tm_refine (_55_2557), FStar_Syntax_Syntax.Tm_refine (_55_2560)) -> begin
(

let _55_2565 = (as_refinement env wl t1)
in (match (_55_2565) with
| (x1, phi1) -> begin
(

let _55_2568 = (as_refinement env wl t2)
in (match (_55_2568) with
| (x2, phi2) -> begin
(

let base_prob = (let _144_1328 = (mk_problem (p_scope orig) orig x1.FStar_Syntax_Syntax.sort problem.FStar_TypeChecker_Common.relation x2.FStar_Syntax_Syntax.sort problem.FStar_TypeChecker_Common.element "refinement base type")
in (FStar_All.pipe_left (fun _144_1327 -> FStar_TypeChecker_Common.TProb (_144_1327)) _144_1328))
in (

let x1 = (FStar_Syntax_Syntax.freshen_bv x1)
in (

let subst = (FStar_Syntax_Syntax.DB ((0, x1)))::[]
in (

let phi1 = (FStar_Syntax_Subst.subst subst phi1)
in (

let phi2 = (FStar_Syntax_Subst.subst subst phi2)
in (

let env = (FStar_TypeChecker_Env.push_bv env x1)
in (

let mk_imp = (fun imp phi1 phi2 -> (let _144_1345 = (imp phi1 phi2)
in (FStar_All.pipe_right _144_1345 (guard_on_element problem x1))))
in (

let fallback = (fun _55_2580 -> (match (()) with
| () -> begin
(

let impl = if (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) then begin
(mk_imp FStar_Syntax_Util.mk_iff phi1 phi2)
end else begin
(mk_imp FStar_Syntax_Util.mk_imp phi1 phi2)
end
in (

let guard = (let _144_1348 = (FStar_All.pipe_right (p_guard base_prob) Prims.fst)
in (FStar_Syntax_Util.mk_conj _144_1348 impl))
in (

let wl = (solve_prob orig (Some (guard)) [] wl)
in (solve env (attempt ((base_prob)::[]) wl)))))
end))
in if (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) then begin
(

let ref_prob = (let _144_1352 = (let _144_1351 = (let _144_1350 = (FStar_Syntax_Syntax.mk_binder x1)
in (_144_1350)::(p_scope orig))
in (mk_problem _144_1351 orig phi1 FStar_TypeChecker_Common.EQ phi2 None "refinement formula"))
in (FStar_All.pipe_left (fun _144_1349 -> FStar_TypeChecker_Common.TProb (_144_1349)) _144_1352))
in (match ((solve env (

let _55_2585 = wl
in {attempting = (ref_prob)::[]; wl_deferred = []; ctr = _55_2585.ctr; defer_ok = false; smt_ok = _55_2585.smt_ok; tcenv = _55_2585.tcenv}))) with
| Failed (_55_2588) -> begin
(fallback ())
end
| Success (_55_2591) -> begin
(

let guard = (let _144_1355 = (FStar_All.pipe_right (p_guard base_prob) Prims.fst)
in (let _144_1354 = (let _144_1353 = (FStar_All.pipe_right (p_guard ref_prob) Prims.fst)
in (FStar_All.pipe_right _144_1353 (guard_on_element problem x1)))
in (FStar_Syntax_Util.mk_conj _144_1355 _144_1354)))
in (

let wl = (solve_prob orig (Some (guard)) [] wl)
in (

let wl = (

let _55_2595 = wl
in {attempting = _55_2595.attempting; wl_deferred = _55_2595.wl_deferred; ctr = (wl.ctr + 1); defer_ok = _55_2595.defer_ok; smt_ok = _55_2595.smt_ok; tcenv = _55_2595.tcenv})
in (solve env (attempt ((base_prob)::[]) wl)))))
end))
end else begin
(fallback ())
end))))))))
end))
end))
end
| ((FStar_Syntax_Syntax.Tm_uvar (_), FStar_Syntax_Syntax.Tm_uvar (_))) | ((FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _), FStar_Syntax_Syntax.Tm_uvar (_))) | ((FStar_Syntax_Syntax.Tm_uvar (_), FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _))) | ((FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _), FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _))) -> begin
(let _144_1357 = (destruct_flex_t t1)
in (let _144_1356 = (destruct_flex_t t2)
in (flex_flex orig _144_1357 _144_1356)))
end
| ((FStar_Syntax_Syntax.Tm_uvar (_), _)) | ((FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _), _)) when (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) -> begin
(let _144_1358 = (destruct_flex_pattern env t1)
in (solve_t_flex_rigid orig _144_1358 t2 wl))
end
| ((_, FStar_Syntax_Syntax.Tm_uvar (_))) | ((_, FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _))) when (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) -> begin
(solve_t env (invert problem) wl)
end
| ((FStar_Syntax_Syntax.Tm_uvar (_), _)) | ((FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _), _)) -> begin
if wl.defer_ok then begin
(solve env (defer "flex-rigid subtyping deferred" orig wl))
end else begin
(

let new_rel = problem.FStar_TypeChecker_Common.relation
in if (let _144_1359 = (is_top_level_prob orig)
in (FStar_All.pipe_left Prims.op_Negation _144_1359)) then begin
(let _144_1362 = (FStar_All.pipe_left (fun _144_1360 -> FStar_TypeChecker_Common.TProb (_144_1360)) (

let _55_2740 = problem
in {FStar_TypeChecker_Common.pid = _55_2740.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _55_2740.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = new_rel; FStar_TypeChecker_Common.rhs = _55_2740.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _55_2740.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_2740.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_2740.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_2740.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_2740.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_2740.FStar_TypeChecker_Common.rank}))
in (let _144_1361 = (destruct_flex_pattern env t1)
in (solve_t_flex_rigid _144_1362 _144_1361 t2 wl)))
end else begin
(

let _55_2744 = (base_and_refinement env wl t2)
in (match (_55_2744) with
| (t_base, ref_opt) -> begin
(match (ref_opt) with
| None -> begin
(let _144_1365 = (FStar_All.pipe_left (fun _144_1363 -> FStar_TypeChecker_Common.TProb (_144_1363)) (

let _55_2746 = problem
in {FStar_TypeChecker_Common.pid = _55_2746.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _55_2746.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = new_rel; FStar_TypeChecker_Common.rhs = _55_2746.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _55_2746.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_2746.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_2746.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_2746.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_2746.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_2746.FStar_TypeChecker_Common.rank}))
in (let _144_1364 = (destruct_flex_pattern env t1)
in (solve_t_flex_rigid _144_1365 _144_1364 t_base wl)))
end
| Some (y, phi) -> begin
(

let y' = (

let _55_2752 = y
in {FStar_Syntax_Syntax.ppname = _55_2752.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _55_2752.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t1})
in (

let impl = (guard_on_element problem y' phi)
in (

let base_prob = (let _144_1367 = (mk_problem problem.FStar_TypeChecker_Common.scope orig t1 new_rel y.FStar_Syntax_Syntax.sort problem.FStar_TypeChecker_Common.element "flex-rigid: base type")
in (FStar_All.pipe_left (fun _144_1366 -> FStar_TypeChecker_Common.TProb (_144_1366)) _144_1367))
in (

let guard = (let _144_1368 = (FStar_All.pipe_right (p_guard base_prob) Prims.fst)
in (FStar_Syntax_Util.mk_conj _144_1368 impl))
in (

let wl = (solve_prob orig (Some (guard)) [] wl)
in (solve env (attempt ((base_prob)::[]) wl)))))))
end)
end))
end)
end
end
| ((_, FStar_Syntax_Syntax.Tm_uvar (_))) | ((_, FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _))) -> begin
if wl.defer_ok then begin
(solve env (defer "rigid-flex subtyping deferred" orig wl))
end else begin
(

let _55_2785 = (base_and_refinement env wl t1)
in (match (_55_2785) with
| (t_base, _55_2784) -> begin
(solve_t env (

let _55_2786 = problem
in {FStar_TypeChecker_Common.pid = _55_2786.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = t_base; FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ; FStar_TypeChecker_Common.rhs = _55_2786.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _55_2786.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_2786.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_2786.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_2786.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_2786.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_2786.FStar_TypeChecker_Common.rank}) wl)
end))
end
end
| (FStar_Syntax_Syntax.Tm_refine (_55_2789), _55_2792) -> begin
(

let t2 = (let _144_1369 = (base_and_refinement env wl t2)
in (FStar_All.pipe_left force_refinement _144_1369))
in (solve_t env (

let _55_2795 = problem
in {FStar_TypeChecker_Common.pid = _55_2795.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _55_2795.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = _55_2795.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = t2; FStar_TypeChecker_Common.element = _55_2795.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_2795.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_2795.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_2795.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_2795.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_2795.FStar_TypeChecker_Common.rank}) wl))
end
| (_55_2798, FStar_Syntax_Syntax.Tm_refine (_55_2800)) -> begin
(

let t1 = (let _144_1370 = (base_and_refinement env wl t1)
in (FStar_All.pipe_left force_refinement _144_1370))
in (solve_t env (

let _55_2804 = problem
in {FStar_TypeChecker_Common.pid = _55_2804.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = t1; FStar_TypeChecker_Common.relation = _55_2804.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _55_2804.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _55_2804.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_2804.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_2804.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_2804.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_2804.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_2804.FStar_TypeChecker_Common.rank}) wl))
end
| ((FStar_Syntax_Syntax.Tm_abs (_), _)) | ((_, FStar_Syntax_Syntax.Tm_abs (_))) -> begin
(

let maybe_eta = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_abs (_55_2821) -> begin
t
end
| _55_2824 -> begin
(FStar_TypeChecker_Normalize.eta_expand wl.tcenv t)
end))
in (let _144_1375 = (

let _55_2825 = problem
in (let _144_1374 = (maybe_eta t1)
in (let _144_1373 = (maybe_eta t2)
in {FStar_TypeChecker_Common.pid = _55_2825.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _144_1374; FStar_TypeChecker_Common.relation = _55_2825.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _144_1373; FStar_TypeChecker_Common.element = _55_2825.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_2825.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_2825.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_2825.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_2825.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_2825.FStar_TypeChecker_Common.rank})))
in (solve_t env _144_1375 wl)))
end
| ((FStar_Syntax_Syntax.Tm_match (_), _)) | ((FStar_Syntax_Syntax.Tm_uinst (_), _)) | ((FStar_Syntax_Syntax.Tm_name (_), _)) | ((FStar_Syntax_Syntax.Tm_constant (_), _)) | ((FStar_Syntax_Syntax.Tm_fvar (_), _)) | ((FStar_Syntax_Syntax.Tm_app (_), _)) | ((_, FStar_Syntax_Syntax.Tm_match (_))) | ((_, FStar_Syntax_Syntax.Tm_uinst (_))) | ((_, FStar_Syntax_Syntax.Tm_name (_))) | ((_, FStar_Syntax_Syntax.Tm_constant (_))) | ((_, FStar_Syntax_Syntax.Tm_fvar (_))) | ((_, FStar_Syntax_Syntax.Tm_app (_))) -> begin
(

let head1 = (let _144_1376 = (FStar_Syntax_Util.head_and_args t1)
in (FStar_All.pipe_right _144_1376 Prims.fst))
in (

let head2 = (let _144_1377 = (FStar_Syntax_Util.head_and_args t2)
in (FStar_All.pipe_right _144_1377 Prims.fst))
in if ((((FStar_TypeChecker_Env.is_interpreted env head1) || (FStar_TypeChecker_Env.is_interpreted env head2)) && wl.smt_ok) && (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ)) then begin
(

let uv1 = (FStar_Syntax_Free.uvars t1)
in (

let uv2 = (FStar_Syntax_Free.uvars t2)
in if ((FStar_Util.set_is_empty uv1) && (FStar_Util.set_is_empty uv2)) then begin
(

let guard = if (eq_tm t1 t2) then begin
None
end else begin
(let _144_1379 = (FStar_Syntax_Util.mk_eq FStar_Syntax_Syntax.tun FStar_Syntax_Syntax.tun t1 t2)
in (FStar_All.pipe_left (fun _144_1378 -> Some (_144_1378)) _144_1379))
end
in (let _144_1380 = (solve_prob orig guard [] wl)
in (solve env _144_1380)))
end else begin
(rigid_rigid_delta env orig wl head1 head2 t1 t2)
end))
end else begin
(rigid_rigid_delta env orig wl head1 head2 t1 t2)
end))
end
| (FStar_Syntax_Syntax.Tm_ascribed (t1, _55_2906, _55_2908), _55_2912) -> begin
(solve_t' env (

let _55_2914 = problem
in {FStar_TypeChecker_Common.pid = _55_2914.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = t1; FStar_TypeChecker_Common.relation = _55_2914.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _55_2914.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _55_2914.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_2914.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_2914.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_2914.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_2914.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_2914.FStar_TypeChecker_Common.rank}) wl)
end
| (_55_2917, FStar_Syntax_Syntax.Tm_ascribed (t2, _55_2920, _55_2922)) -> begin
(solve_t' env (

let _55_2926 = problem
in {FStar_TypeChecker_Common.pid = _55_2926.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _55_2926.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = _55_2926.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = t2; FStar_TypeChecker_Common.element = _55_2926.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_2926.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_2926.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_2926.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_2926.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_2926.FStar_TypeChecker_Common.rank}) wl)
end
| ((FStar_Syntax_Syntax.Tm_let (_), _)) | ((FStar_Syntax_Syntax.Tm_meta (_), _)) | ((FStar_Syntax_Syntax.Tm_delayed (_), _)) | ((_, FStar_Syntax_Syntax.Tm_meta (_))) | ((_, FStar_Syntax_Syntax.Tm_delayed (_))) | ((_, FStar_Syntax_Syntax.Tm_let (_))) -> begin
(let _144_1383 = (let _144_1382 = (FStar_Syntax_Print.tag_of_term t1)
in (let _144_1381 = (FStar_Syntax_Print.tag_of_term t2)
in (FStar_Util.format2 "Impossible: %s and %s" _144_1382 _144_1381)))
in (FStar_All.failwith _144_1383))
end
| _55_2965 -> begin
(giveup env "head tag mismatch" orig)
end))))
end))
end)))))))))
and solve_c : FStar_TypeChecker_Env.env  ->  (FStar_Syntax_Syntax.comp, Prims.unit) FStar_TypeChecker_Common.problem  ->  worklist  ->  solution = (fun env problem wl -> (

let c1 = problem.FStar_TypeChecker_Common.lhs
in (

let c2 = problem.FStar_TypeChecker_Common.rhs
in (

let orig = FStar_TypeChecker_Common.CProb (problem)
in (

let sub_prob = (fun t1 rel t2 reason -> (mk_problem (p_scope orig) orig t1 rel t2 None reason))
in (

let solve_eq = (fun c1_comp c2_comp -> (

let _55_2982 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("EQ"))) then begin
(FStar_Util.print_string "solve_c is using an equality constraint\n")
end else begin
()
end
in (

let sub_probs = (FStar_List.map2 (fun _55_2987 _55_2991 -> (match ((_55_2987, _55_2991)) with
| ((a1, _55_2986), (a2, _55_2990)) -> begin
(let _144_1398 = (sub_prob a1 FStar_TypeChecker_Common.EQ a2 "effect arg")
in (FStar_All.pipe_left (fun _144_1397 -> FStar_TypeChecker_Common.TProb (_144_1397)) _144_1398))
end)) c1_comp.FStar_Syntax_Syntax.effect_args c2_comp.FStar_Syntax_Syntax.effect_args)
in (

let guard = (let _144_1400 = (FStar_List.map (fun p -> (FStar_All.pipe_right (p_guard p) Prims.fst)) sub_probs)
in (FStar_Syntax_Util.mk_conj_l _144_1400))
in (

let wl = (solve_prob orig (Some (guard)) [] wl)
in (solve env (attempt sub_probs wl)))))))
in (

let solve_sub = (fun c1 edge c2 -> (

let r = (FStar_TypeChecker_Env.get_range env)
in if (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) then begin
(

let wp = (match (c1.FStar_Syntax_Syntax.effect_args) with
| (wp1, _55_3003)::[] -> begin
wp1
end
| _55_3007 -> begin
(let _144_1408 = (let _144_1407 = (FStar_Range.string_of_range (FStar_Ident.range_of_lid c1.FStar_Syntax_Syntax.effect_name))
in (FStar_Util.format1 "Unexpected number of indices on a normalized effect (%s)" _144_1407))
in (FStar_All.failwith _144_1408))
end)
in (

let c1 = (let _144_1411 = (let _144_1410 = (let _144_1409 = (edge.FStar_TypeChecker_Env.mlift c1.FStar_Syntax_Syntax.result_typ wp)
in (FStar_Syntax_Syntax.as_arg _144_1409))
in (_144_1410)::[])
in {FStar_Syntax_Syntax.effect_name = c2.FStar_Syntax_Syntax.effect_name; FStar_Syntax_Syntax.result_typ = c1.FStar_Syntax_Syntax.result_typ; FStar_Syntax_Syntax.effect_args = _144_1411; FStar_Syntax_Syntax.flags = c1.FStar_Syntax_Syntax.flags})
in (solve_eq c1 c2)))
end else begin
(

let is_null_wp_2 = (FStar_All.pipe_right c2.FStar_Syntax_Syntax.flags (FStar_Util.for_some (fun _55_28 -> (match (_55_28) with
| (FStar_Syntax_Syntax.TOTAL) | (FStar_Syntax_Syntax.MLEFFECT) | (FStar_Syntax_Syntax.SOMETRIVIAL) -> begin
true
end
| _55_3015 -> begin
false
end))))
in (

let _55_3036 = (match ((c1.FStar_Syntax_Syntax.effect_args, c2.FStar_Syntax_Syntax.effect_args)) with
| ((wp1, _55_3021)::_55_3018, (wp2, _55_3028)::_55_3025) -> begin
(wp1, wp2)
end
| _55_3033 -> begin
(let _144_1415 = (let _144_1414 = (FStar_Syntax_Print.lid_to_string c1.FStar_Syntax_Syntax.effect_name)
in (let _144_1413 = (FStar_Syntax_Print.lid_to_string c2.FStar_Syntax_Syntax.effect_name)
in (FStar_Util.format2 "Got effects %s and %s, expected normalized effects" _144_1414 _144_1413)))
in (FStar_All.failwith _144_1415))
end)
in (match (_55_3036) with
| (wpc1, wpc2) -> begin
if (FStar_Util.physical_equality wpc1 wpc2) then begin
(let _144_1416 = (problem_using_guard orig c1.FStar_Syntax_Syntax.result_typ problem.FStar_TypeChecker_Common.relation c2.FStar_Syntax_Syntax.result_typ None "result type")
in (solve_t env _144_1416 wl))
end else begin
(

let c2_decl = (FStar_TypeChecker_Env.get_effect_decl env c2.FStar_Syntax_Syntax.effect_name)
in (

let g = if is_null_wp_2 then begin
(

let _55_3038 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(FStar_Util.print_string "Using trivial wp ... \n")
end else begin
()
end
in (let _144_1426 = (let _144_1425 = (let _144_1424 = (let _144_1418 = (let _144_1417 = (env.FStar_TypeChecker_Env.universe_of env c1.FStar_Syntax_Syntax.result_typ)
in (_144_1417)::[])
in (FStar_TypeChecker_Env.inst_effect_fun_with _144_1418 env c2_decl c2_decl.FStar_Syntax_Syntax.trivial))
in (let _144_1423 = (let _144_1422 = (FStar_Syntax_Syntax.as_arg c1.FStar_Syntax_Syntax.result_typ)
in (let _144_1421 = (let _144_1420 = (let _144_1419 = (edge.FStar_TypeChecker_Env.mlift c1.FStar_Syntax_Syntax.result_typ wpc1)
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _144_1419))
in (_144_1420)::[])
in (_144_1422)::_144_1421))
in (_144_1424, _144_1423)))
in FStar_Syntax_Syntax.Tm_app (_144_1425))
in (FStar_Syntax_Syntax.mk _144_1426 (Some (FStar_Syntax_Util.ktype0.FStar_Syntax_Syntax.n)) r)))
end else begin
(

let wp2_imp_wp1 = (let _144_1442 = (let _144_1441 = (let _144_1440 = (let _144_1428 = (let _144_1427 = (env.FStar_TypeChecker_Env.universe_of env c2.FStar_Syntax_Syntax.result_typ)
in (_144_1427)::[])
in (FStar_TypeChecker_Env.inst_effect_fun_with _144_1428 env c2_decl c2_decl.FStar_Syntax_Syntax.wp_binop))
in (let _144_1439 = (let _144_1438 = (FStar_Syntax_Syntax.as_arg c2.FStar_Syntax_Syntax.result_typ)
in (let _144_1437 = (let _144_1436 = (FStar_Syntax_Syntax.as_arg wpc2)
in (let _144_1435 = (let _144_1434 = (let _144_1430 = (let _144_1429 = (FStar_Ident.set_lid_range FStar_Syntax_Const.imp_lid r)
in (FStar_Syntax_Syntax.fvar _144_1429 (FStar_Syntax_Syntax.Delta_unfoldable (1)) None))
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _144_1430))
in (let _144_1433 = (let _144_1432 = (let _144_1431 = (edge.FStar_TypeChecker_Env.mlift c1.FStar_Syntax_Syntax.result_typ wpc1)
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _144_1431))
in (_144_1432)::[])
in (_144_1434)::_144_1433))
in (_144_1436)::_144_1435))
in (_144_1438)::_144_1437))
in (_144_1440, _144_1439)))
in FStar_Syntax_Syntax.Tm_app (_144_1441))
in (FStar_Syntax_Syntax.mk _144_1442 None r))
in (let _144_1451 = (let _144_1450 = (let _144_1449 = (let _144_1444 = (let _144_1443 = (env.FStar_TypeChecker_Env.universe_of env c2.FStar_Syntax_Syntax.result_typ)
in (_144_1443)::[])
in (FStar_TypeChecker_Env.inst_effect_fun_with _144_1444 env c2_decl c2_decl.FStar_Syntax_Syntax.wp_as_type))
in (let _144_1448 = (let _144_1447 = (FStar_Syntax_Syntax.as_arg c2.FStar_Syntax_Syntax.result_typ)
in (let _144_1446 = (let _144_1445 = (FStar_Syntax_Syntax.as_arg wp2_imp_wp1)
in (_144_1445)::[])
in (_144_1447)::_144_1446))
in (_144_1449, _144_1448)))
in FStar_Syntax_Syntax.Tm_app (_144_1450))
in (FStar_Syntax_Syntax.mk _144_1451 (Some (FStar_Syntax_Util.ktype0.FStar_Syntax_Syntax.n)) r)))
end
in (

let base_prob = (let _144_1453 = (sub_prob c1.FStar_Syntax_Syntax.result_typ problem.FStar_TypeChecker_Common.relation c2.FStar_Syntax_Syntax.result_typ "result type")
in (FStar_All.pipe_left (fun _144_1452 -> FStar_TypeChecker_Common.TProb (_144_1452)) _144_1453))
in (

let wl = (let _144_1457 = (let _144_1456 = (let _144_1455 = (FStar_All.pipe_right (p_guard base_prob) Prims.fst)
in (FStar_Syntax_Util.mk_conj _144_1455 g))
in (FStar_All.pipe_left (fun _144_1454 -> Some (_144_1454)) _144_1456))
in (solve_prob orig _144_1457 [] wl))
in (solve env (attempt ((base_prob)::[]) wl))))))
end
end)))
end))
in if (FStar_Util.physical_equality c1 c2) then begin
(let _144_1458 = (solve_prob orig None [] wl)
in (solve env _144_1458))
end else begin
(

let _55_3044 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1460 = (FStar_Syntax_Print.comp_to_string c1)
in (let _144_1459 = (FStar_Syntax_Print.comp_to_string c2)
in (FStar_Util.print3 "solve_c %s %s %s\n" _144_1460 (rel_to_string problem.FStar_TypeChecker_Common.relation) _144_1459)))
end else begin
()
end
in (

let _55_3048 = (let _144_1462 = (FStar_TypeChecker_Normalize.ghost_to_pure env c1)
in (let _144_1461 = (FStar_TypeChecker_Normalize.ghost_to_pure env c2)
in (_144_1462, _144_1461)))
in (match (_55_3048) with
| (c1, c2) -> begin
(match ((c1.FStar_Syntax_Syntax.n, c2.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.GTotal (t1), FStar_Syntax_Syntax.Total (t2)) when (FStar_Syntax_Util.non_informative t2) -> begin
(let _144_1463 = (problem_using_guard orig t1 problem.FStar_TypeChecker_Common.relation t2 None "result type")
in (solve_t env _144_1463 wl))
end
| (FStar_Syntax_Syntax.GTotal (_55_3055), FStar_Syntax_Syntax.Total (_55_3058)) -> begin
(giveup env "incompatible monad ordering: GTot </: Tot" orig)
end
| ((FStar_Syntax_Syntax.Total (t1), FStar_Syntax_Syntax.Total (t2))) | ((FStar_Syntax_Syntax.GTotal (t1), FStar_Syntax_Syntax.GTotal (t2))) | ((FStar_Syntax_Syntax.Total (t1), FStar_Syntax_Syntax.GTotal (t2))) -> begin
(let _144_1464 = (problem_using_guard orig t1 problem.FStar_TypeChecker_Common.relation t2 None "result type")
in (solve_t env _144_1464 wl))
end
| ((FStar_Syntax_Syntax.GTotal (_), FStar_Syntax_Syntax.Comp (_))) | ((FStar_Syntax_Syntax.Total (_), FStar_Syntax_Syntax.Comp (_))) -> begin
(let _144_1466 = (

let _55_3086 = problem
in (let _144_1465 = (FStar_All.pipe_left FStar_Syntax_Syntax.mk_Comp (FStar_Syntax_Util.comp_to_comp_typ c1))
in {FStar_TypeChecker_Common.pid = _55_3086.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _144_1465; FStar_TypeChecker_Common.relation = _55_3086.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _55_3086.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _55_3086.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_3086.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_3086.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_3086.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_3086.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_3086.FStar_TypeChecker_Common.rank}))
in (solve_c env _144_1466 wl))
end
| ((FStar_Syntax_Syntax.Comp (_), FStar_Syntax_Syntax.GTotal (_))) | ((FStar_Syntax_Syntax.Comp (_), FStar_Syntax_Syntax.Total (_))) -> begin
(let _144_1468 = (

let _55_3102 = problem
in (let _144_1467 = (FStar_All.pipe_left FStar_Syntax_Syntax.mk_Comp (FStar_Syntax_Util.comp_to_comp_typ c2))
in {FStar_TypeChecker_Common.pid = _55_3102.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _55_3102.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = _55_3102.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _144_1467; FStar_TypeChecker_Common.element = _55_3102.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _55_3102.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _55_3102.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _55_3102.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _55_3102.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _55_3102.FStar_TypeChecker_Common.rank}))
in (solve_c env _144_1468 wl))
end
| (FStar_Syntax_Syntax.Comp (_55_3105), FStar_Syntax_Syntax.Comp (_55_3108)) -> begin
if (((FStar_Syntax_Util.is_ml_comp c1) && (FStar_Syntax_Util.is_ml_comp c2)) || ((FStar_Syntax_Util.is_total_comp c1) && ((FStar_Syntax_Util.is_total_comp c2) || (FStar_Syntax_Util.is_ml_comp c2)))) then begin
(let _144_1469 = (problem_using_guard orig (FStar_Syntax_Util.comp_result c1) problem.FStar_TypeChecker_Common.relation (FStar_Syntax_Util.comp_result c2) None "result type")
in (solve_t env _144_1469 wl))
end else begin
(

let c1_comp = (FStar_Syntax_Util.comp_to_comp_typ c1)
in (

let c2_comp = (FStar_Syntax_Util.comp_to_comp_typ c2)
in if ((problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) && (FStar_Ident.lid_equals c1_comp.FStar_Syntax_Syntax.effect_name c2_comp.FStar_Syntax_Syntax.effect_name)) then begin
(solve_eq c1_comp c2_comp)
end else begin
(

let c1 = (FStar_TypeChecker_Normalize.unfold_effect_abbrev env c1)
in (

let c2 = (FStar_TypeChecker_Normalize.unfold_effect_abbrev env c2)
in (

let _55_3115 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(FStar_Util.print2 "solve_c for %s and %s\n" c1.FStar_Syntax_Syntax.effect_name.FStar_Ident.str c2.FStar_Syntax_Syntax.effect_name.FStar_Ident.str)
end else begin
()
end
in (match ((FStar_TypeChecker_Env.monad_leq env c1.FStar_Syntax_Syntax.effect_name c2.FStar_Syntax_Syntax.effect_name)) with
| None -> begin
if (((FStar_Syntax_Util.is_ghost_effect c1.FStar_Syntax_Syntax.effect_name) && (FStar_Syntax_Util.is_pure_effect c2.FStar_Syntax_Syntax.effect_name)) && (let _144_1470 = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Inline)::(FStar_TypeChecker_Normalize.UnfoldUntil (FStar_Syntax_Syntax.Delta_constant))::[]) env c2.FStar_Syntax_Syntax.result_typ)
in (FStar_Syntax_Util.non_informative _144_1470))) then begin
(

let edge = {FStar_TypeChecker_Env.msource = c1.FStar_Syntax_Syntax.effect_name; FStar_TypeChecker_Env.mtarget = c2.FStar_Syntax_Syntax.effect_name; FStar_TypeChecker_Env.mlift = (fun r t -> t)}
in (solve_sub c1 edge c2))
end else begin
(let _144_1475 = (let _144_1474 = (FStar_Syntax_Print.lid_to_string c1.FStar_Syntax_Syntax.effect_name)
in (let _144_1473 = (FStar_Syntax_Print.lid_to_string c2.FStar_Syntax_Syntax.effect_name)
in (FStar_Util.format2 "incompatible monad ordering: %s </: %s" _144_1474 _144_1473)))
in (giveup env _144_1475 orig))
end
end
| Some (edge) -> begin
(solve_sub c1 edge c2)
end))))
end))
end
end)
end)))
end)))))))


let print_pending_implicits : FStar_TypeChecker_Env.guard_t  ->  Prims.string = (fun g -> (let _144_1479 = (FStar_All.pipe_right g.FStar_TypeChecker_Env.implicits (FStar_List.map (fun _55_3135 -> (match (_55_3135) with
| (_55_3125, _55_3127, u, _55_3130, _55_3132, _55_3134) -> begin
(FStar_Syntax_Print.uvar_to_string u)
end))))
in (FStar_All.pipe_right _144_1479 (FStar_String.concat ", "))))


let guard_to_string : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.guard_t  ->  Prims.string = (fun env g -> (match ((g.FStar_TypeChecker_Env.guard_f, g.FStar_TypeChecker_Env.deferred)) with
| (FStar_TypeChecker_Common.Trivial, []) -> begin
"{}"
end
| _55_3142 -> begin
(

let form = (match (g.FStar_TypeChecker_Env.guard_f) with
| FStar_TypeChecker_Common.Trivial -> begin
"trivial"
end
| FStar_TypeChecker_Common.NonTrivial (f) -> begin
if ((FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) || (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Implicits")))) then begin
(FStar_TypeChecker_Normalize.term_to_string env f)
end else begin
"non-trivial"
end
end)
in (

let carry = (let _144_1485 = (FStar_List.map (fun _55_3150 -> (match (_55_3150) with
| (_55_3148, x) -> begin
(prob_to_string env x)
end)) g.FStar_TypeChecker_Env.deferred)
in (FStar_All.pipe_right _144_1485 (FStar_String.concat ",\n")))
in (

let imps = (print_pending_implicits g)
in (FStar_Util.format3 "\n\t{guard_f=%s;\n\t deferred={\n%s};\n\t implicits={%s}}\n" form carry imps))))
end))


let guard_of_guard_formula : FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Env.guard_t = (fun g -> {FStar_TypeChecker_Env.guard_f = g; FStar_TypeChecker_Env.deferred = []; FStar_TypeChecker_Env.univ_ineqs = []; FStar_TypeChecker_Env.implicits = []})


let guard_form : FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Common.guard_formula = (fun g -> g.FStar_TypeChecker_Env.guard_f)


let is_trivial : FStar_TypeChecker_Env.guard_t  ->  Prims.bool = (fun g -> (match (g) with
| {FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = []; FStar_TypeChecker_Env.univ_ineqs = _55_3159; FStar_TypeChecker_Env.implicits = _55_3157} -> begin
true
end
| _55_3164 -> begin
false
end))


let trivial_guard : FStar_TypeChecker_Env.guard_t = {FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = []; FStar_TypeChecker_Env.univ_ineqs = []; FStar_TypeChecker_Env.implicits = []}


let abstract_guard : FStar_Syntax_Syntax.bv  ->  FStar_TypeChecker_Env.guard_t Prims.option  ->  FStar_TypeChecker_Env.guard_t Prims.option = (fun x g -> (match (g) with
| (None) | (Some ({FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = _; FStar_TypeChecker_Env.univ_ineqs = _; FStar_TypeChecker_Env.implicits = _})) -> begin
g
end
| Some (g) -> begin
(

let f = (match (g.FStar_TypeChecker_Env.guard_f) with
| FStar_TypeChecker_Common.NonTrivial (f) -> begin
f
end
| _55_3182 -> begin
(FStar_All.failwith "impossible")
end)
in (let _144_1506 = (

let _55_3184 = g
in (let _144_1505 = (let _144_1504 = (let _144_1503 = (let _144_1497 = (FStar_Syntax_Syntax.mk_binder x)
in (_144_1497)::[])
in (let _144_1502 = (let _144_1501 = (let _144_1500 = (let _144_1498 = (FStar_Syntax_Syntax.mk_Total FStar_Syntax_Util.ktype0)
in (FStar_All.pipe_right _144_1498 FStar_Syntax_Util.lcomp_of_comp))
in (FStar_All.pipe_right _144_1500 (fun _144_1499 -> FStar_Util.Inl (_144_1499))))
in Some (_144_1501))
in (FStar_Syntax_Util.abs _144_1503 f _144_1502)))
in (FStar_All.pipe_left (fun _144_1496 -> FStar_TypeChecker_Common.NonTrivial (_144_1496)) _144_1504))
in {FStar_TypeChecker_Env.guard_f = _144_1505; FStar_TypeChecker_Env.deferred = _55_3184.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _55_3184.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _55_3184.FStar_TypeChecker_Env.implicits}))
in Some (_144_1506)))
end))


let apply_guard : FStar_TypeChecker_Env.guard_t  ->  FStar_Syntax_Syntax.term  ->  FStar_TypeChecker_Env.guard_t = (fun g e -> (match (g.FStar_TypeChecker_Env.guard_f) with
| FStar_TypeChecker_Common.Trivial -> begin
g
end
| FStar_TypeChecker_Common.NonTrivial (f) -> begin
(

let _55_3191 = g
in (let _144_1517 = (let _144_1516 = (let _144_1515 = (let _144_1514 = (let _144_1513 = (let _144_1512 = (FStar_Syntax_Syntax.as_arg e)
in (_144_1512)::[])
in (f, _144_1513))
in FStar_Syntax_Syntax.Tm_app (_144_1514))
in (FStar_Syntax_Syntax.mk _144_1515 (Some (FStar_Syntax_Util.ktype0.FStar_Syntax_Syntax.n)) f.FStar_Syntax_Syntax.pos))
in (FStar_All.pipe_left (fun _144_1511 -> FStar_TypeChecker_Common.NonTrivial (_144_1511)) _144_1516))
in {FStar_TypeChecker_Env.guard_f = _144_1517; FStar_TypeChecker_Env.deferred = _55_3191.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _55_3191.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _55_3191.FStar_TypeChecker_Env.implicits}))
end))


let trivial : FStar_TypeChecker_Common.guard_formula  ->  Prims.unit = (fun t -> (match (t) with
| FStar_TypeChecker_Common.Trivial -> begin
()
end
| FStar_TypeChecker_Common.NonTrivial (_55_3196) -> begin
(FStar_All.failwith "impossible")
end))


let conj_guard_f : FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Common.guard_formula = (fun g1 g2 -> (match ((g1, g2)) with
| ((FStar_TypeChecker_Common.Trivial, g)) | ((g, FStar_TypeChecker_Common.Trivial)) -> begin
g
end
| (FStar_TypeChecker_Common.NonTrivial (f1), FStar_TypeChecker_Common.NonTrivial (f2)) -> begin
(let _144_1524 = (FStar_Syntax_Util.mk_conj f1 f2)
in FStar_TypeChecker_Common.NonTrivial (_144_1524))
end))


let check_trivial : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  FStar_TypeChecker_Common.guard_formula = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (tc) when (FStar_Syntax_Syntax.fv_eq_lid tc FStar_Syntax_Const.true_lid) -> begin
FStar_TypeChecker_Common.Trivial
end
| _55_3214 -> begin
FStar_TypeChecker_Common.NonTrivial (t)
end))


let imp_guard_f : FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Common.guard_formula = (fun g1 g2 -> (match ((g1, g2)) with
| (FStar_TypeChecker_Common.Trivial, g) -> begin
g
end
| (g, FStar_TypeChecker_Common.Trivial) -> begin
FStar_TypeChecker_Common.Trivial
end
| (FStar_TypeChecker_Common.NonTrivial (f1), FStar_TypeChecker_Common.NonTrivial (f2)) -> begin
(

let imp = (FStar_Syntax_Util.mk_imp f1 f2)
in (check_trivial imp))
end))


let binop_guard : (FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Common.guard_formula)  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun f g1 g2 -> (let _144_1547 = (f g1.FStar_TypeChecker_Env.guard_f g2.FStar_TypeChecker_Env.guard_f)
in {FStar_TypeChecker_Env.guard_f = _144_1547; FStar_TypeChecker_Env.deferred = (FStar_List.append g1.FStar_TypeChecker_Env.deferred g2.FStar_TypeChecker_Env.deferred); FStar_TypeChecker_Env.univ_ineqs = (FStar_List.append g1.FStar_TypeChecker_Env.univ_ineqs g2.FStar_TypeChecker_Env.univ_ineqs); FStar_TypeChecker_Env.implicits = (FStar_List.append g1.FStar_TypeChecker_Env.implicits g2.FStar_TypeChecker_Env.implicits)}))


let conj_guard : FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun g1 g2 -> (binop_guard conj_guard_f g1 g2))


let imp_guard : FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun g1 g2 -> (binop_guard imp_guard_f g1 g2))


let close_guard : FStar_Syntax_Syntax.binders  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun binders g -> (match (g.FStar_TypeChecker_Env.guard_f) with
| FStar_TypeChecker_Common.Trivial -> begin
g
end
| FStar_TypeChecker_Common.NonTrivial (f) -> begin
(

let _55_3241 = g
in (let _144_1562 = (let _144_1561 = (FStar_Syntax_Util.close_forall binders f)
in (FStar_All.pipe_right _144_1561 (fun _144_1560 -> FStar_TypeChecker_Common.NonTrivial (_144_1560))))
in {FStar_TypeChecker_Env.guard_f = _144_1562; FStar_TypeChecker_Env.deferred = _55_3241.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _55_3241.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _55_3241.FStar_TypeChecker_Env.implicits}))
end))


let new_t_problem = (fun env lhs rel rhs elt loc -> (

let reason = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("ExplainRel"))) then begin
(let _144_1570 = (FStar_TypeChecker_Normalize.term_to_string env lhs)
in (let _144_1569 = (FStar_TypeChecker_Normalize.term_to_string env rhs)
in (FStar_Util.format3 "Top-level:\n%s\n\t%s\n%s" _144_1570 (rel_to_string rel) _144_1569)))
end else begin
"TOP"
end
in (

let p = (new_problem env lhs rel rhs elt loc reason)
in p)))


let new_t_prob : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.typ  ->  FStar_TypeChecker_Common.rel  ->  FStar_Syntax_Syntax.term  ->  (FStar_TypeChecker_Common.prob * FStar_Syntax_Syntax.bv) = (fun env t1 rel t2 -> (

let x = (let _144_1581 = (let _144_1580 = (FStar_TypeChecker_Env.get_range env)
in (FStar_All.pipe_left (fun _144_1579 -> Some (_144_1579)) _144_1580))
in (FStar_Syntax_Syntax.new_bv _144_1581 t1))
in (

let env = (FStar_TypeChecker_Env.push_bv env x)
in (

let p = (let _144_1585 = (let _144_1583 = (FStar_Syntax_Syntax.bv_to_name x)
in (FStar_All.pipe_left (fun _144_1582 -> Some (_144_1582)) _144_1583))
in (let _144_1584 = (FStar_TypeChecker_Env.get_range env)
in (new_t_problem env t1 rel t2 _144_1585 _144_1584)))
in (FStar_TypeChecker_Common.TProb (p), x)))))


let solve_and_commit : FStar_TypeChecker_Env.env  ->  worklist  ->  ((FStar_TypeChecker_Common.prob * Prims.string)  ->  FStar_TypeChecker_Common.deferred Prims.option)  ->  FStar_TypeChecker_Common.deferred Prims.option = (fun env probs err -> (

let probs = if (FStar_Options.eager_inference ()) then begin
(

let _55_3261 = probs
in {attempting = _55_3261.attempting; wl_deferred = _55_3261.wl_deferred; ctr = _55_3261.ctr; defer_ok = false; smt_ok = _55_3261.smt_ok; tcenv = _55_3261.tcenv})
end else begin
probs
end
in (

let tx = (FStar_Unionfind.new_transaction ())
in (

let sol = (solve env probs)
in (match (sol) with
| Success (deferred) -> begin
(

let _55_3268 = (FStar_Unionfind.commit tx)
in Some (deferred))
end
| Failed (d, s) -> begin
(

let _55_3274 = (FStar_Unionfind.rollback tx)
in (

let _55_3276 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("ExplainRel"))) then begin
(let _144_1597 = (explain env d s)
in (FStar_All.pipe_left FStar_Util.print_string _144_1597))
end else begin
()
end
in (err (d, s))))
end)))))


let simplify_guard : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun env g -> (match (g.FStar_TypeChecker_Env.guard_f) with
| FStar_TypeChecker_Common.Trivial -> begin
g
end
| FStar_TypeChecker_Common.NonTrivial (f) -> begin
(

let _55_3283 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Simplification"))) then begin
(let _144_1602 = (FStar_Syntax_Print.term_to_string f)
in (FStar_Util.print1 "Simplifying guard %s\n" _144_1602))
end else begin
()
end
in (

let f = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Inline)::(FStar_TypeChecker_Normalize.Simplify)::[]) env f)
in (

let _55_3286 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Simplification"))) then begin
(let _144_1603 = (FStar_Syntax_Print.term_to_string f)
in (FStar_Util.print1 "Simplified guard to %s\n" _144_1603))
end else begin
()
end
in (

let f = (match ((let _144_1604 = (FStar_Syntax_Util.unmeta f)
in _144_1604.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_fvar (fv) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.true_lid) -> begin
FStar_TypeChecker_Common.Trivial
end
| _55_3291 -> begin
FStar_TypeChecker_Common.NonTrivial (f)
end)
in (

let _55_3293 = g
in {FStar_TypeChecker_Env.guard_f = f; FStar_TypeChecker_Env.deferred = _55_3293.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _55_3293.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _55_3293.FStar_TypeChecker_Env.implicits})))))
end))


let with_guard : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  FStar_TypeChecker_Common.deferred Prims.option  ->  FStar_TypeChecker_Env.guard_t Prims.option = (fun env prob dopt -> (match (dopt) with
| None -> begin
None
end
| Some (d) -> begin
(let _144_1616 = (let _144_1615 = (let _144_1614 = (let _144_1613 = (FStar_All.pipe_right (p_guard prob) Prims.fst)
in (FStar_All.pipe_right _144_1613 (fun _144_1612 -> FStar_TypeChecker_Common.NonTrivial (_144_1612))))
in {FStar_TypeChecker_Env.guard_f = _144_1614; FStar_TypeChecker_Env.deferred = d; FStar_TypeChecker_Env.univ_ineqs = []; FStar_TypeChecker_Env.implicits = []})
in (simplify_guard env _144_1615))
in (FStar_All.pipe_left (fun _144_1611 -> Some (_144_1611)) _144_1616))
end))


let try_teq : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_TypeChecker_Env.guard_t Prims.option = (fun env t1 t2 -> (

let _55_3304 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1624 = (FStar_Syntax_Print.term_to_string t1)
in (let _144_1623 = (FStar_Syntax_Print.term_to_string t2)
in (FStar_Util.print2 "try_teq of %s and %s\n" _144_1624 _144_1623)))
end else begin
()
end
in (

let prob = (let _144_1627 = (let _144_1626 = (FStar_TypeChecker_Env.get_range env)
in (new_t_problem env t1 FStar_TypeChecker_Common.EQ t2 None _144_1626))
in (FStar_All.pipe_left (fun _144_1625 -> FStar_TypeChecker_Common.TProb (_144_1625)) _144_1627))
in (

let g = (let _144_1629 = (solve_and_commit env (singleton env prob) (fun _55_3307 -> None))
in (FStar_All.pipe_left (with_guard env prob) _144_1629))
in g))))


let teq : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_TypeChecker_Env.guard_t = (fun env t1 t2 -> (match ((try_teq env t1 t2)) with
| None -> begin
(let _144_1639 = (let _144_1638 = (let _144_1637 = (FStar_TypeChecker_Errors.basic_type_error env None t2 t1)
in (let _144_1636 = (FStar_TypeChecker_Env.get_range env)
in (_144_1637, _144_1636)))
in FStar_Syntax_Syntax.Error (_144_1638))
in (Prims.raise _144_1639))
end
| Some (g) -> begin
(

let _55_3316 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1642 = (FStar_Syntax_Print.term_to_string t1)
in (let _144_1641 = (FStar_Syntax_Print.term_to_string t2)
in (let _144_1640 = (guard_to_string env g)
in (FStar_Util.print3 "teq of %s and %s succeeded with guard %s\n" _144_1642 _144_1641 _144_1640))))
end else begin
()
end
in g)
end))


let try_subtype : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_TypeChecker_Env.guard_t Prims.option = (fun env t1 t2 -> (

let _55_3321 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1650 = (FStar_TypeChecker_Normalize.term_to_string env t1)
in (let _144_1649 = (FStar_TypeChecker_Normalize.term_to_string env t2)
in (FStar_Util.print2 "try_subtype of %s and %s\n" _144_1650 _144_1649)))
end else begin
()
end
in (

let _55_3325 = (new_t_prob env t1 FStar_TypeChecker_Common.SUB t2)
in (match (_55_3325) with
| (prob, x) -> begin
(

let g = (let _144_1652 = (solve_and_commit env (singleton env prob) (fun _55_3326 -> None))
in (FStar_All.pipe_left (with_guard env prob) _144_1652))
in (

let _55_3329 = if ((FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) && (FStar_Util.is_some g)) then begin
(let _144_1656 = (FStar_TypeChecker_Normalize.term_to_string env t1)
in (let _144_1655 = (FStar_TypeChecker_Normalize.term_to_string env t2)
in (let _144_1654 = (let _144_1653 = (FStar_Util.must g)
in (guard_to_string env _144_1653))
in (FStar_Util.print3 "try_subtype succeeded: %s <: %s\n\tguard is %s\n" _144_1656 _144_1655 _144_1654))))
end else begin
()
end
in (abstract_guard x g)))
end))))


let subtype_fail = (fun env t1 t2 -> (let _144_1663 = (let _144_1662 = (let _144_1661 = (FStar_TypeChecker_Errors.basic_type_error env None t2 t1)
in (let _144_1660 = (FStar_TypeChecker_Env.get_range env)
in (_144_1661, _144_1660)))
in FStar_Syntax_Syntax.Error (_144_1662))
in (Prims.raise _144_1663)))


let sub_comp : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.comp  ->  FStar_TypeChecker_Env.guard_t Prims.option = (fun env c1 c2 -> (

let _55_3337 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1671 = (FStar_Syntax_Print.comp_to_string c1)
in (let _144_1670 = (FStar_Syntax_Print.comp_to_string c2)
in (FStar_Util.print2 "sub_comp of %s and %s\n" _144_1671 _144_1670)))
end else begin
()
end
in (

let rel = if env.FStar_TypeChecker_Env.use_eq then begin
FStar_TypeChecker_Common.EQ
end else begin
FStar_TypeChecker_Common.SUB
end
in (

let prob = (let _144_1674 = (let _144_1673 = (FStar_TypeChecker_Env.get_range env)
in (new_problem env c1 rel c2 None _144_1673 "sub_comp"))
in (FStar_All.pipe_left (fun _144_1672 -> FStar_TypeChecker_Common.CProb (_144_1672)) _144_1674))
in (let _144_1676 = (solve_and_commit env (singleton env prob) (fun _55_3341 -> None))
in (FStar_All.pipe_left (with_guard env prob) _144_1676))))))


let solve_universe_inequalities' : FStar_Unionfind.tx  ->  FStar_TypeChecker_Env.env  ->  (FStar_Syntax_Syntax.universe * FStar_Syntax_Syntax.universe) Prims.list  ->  Prims.unit = (fun tx env ineqs -> (

let fail = (fun msg u1 u2 -> (

let _55_3350 = (FStar_Unionfind.rollback tx)
in (

let msg = (match (msg) with
| None -> begin
""
end
| Some (s) -> begin
(Prims.strcat ": " s)
end)
in (let _144_1694 = (let _144_1693 = (let _144_1692 = (let _144_1690 = (FStar_Syntax_Print.univ_to_string u1)
in (let _144_1689 = (FStar_Syntax_Print.univ_to_string u2)
in (FStar_Util.format3 "Universe %s and %s are incompatible%s" _144_1690 _144_1689 msg)))
in (let _144_1691 = (FStar_TypeChecker_Env.get_range env)
in (_144_1692, _144_1691)))
in FStar_Syntax_Syntax.Error (_144_1693))
in (Prims.raise _144_1694)))))
in (

let rec insert = (fun uv u1 groups -> (match (groups) with
| [] -> begin
((uv, (u1)::[]))::[]
end
| hd::tl -> begin
(

let _55_3366 = hd
in (match (_55_3366) with
| (uv', lower_bounds) -> begin
if (FStar_Unionfind.equivalent uv uv') then begin
((uv', (u1)::lower_bounds))::tl
end else begin
(let _144_1701 = (insert uv u1 tl)
in (hd)::_144_1701)
end
end))
end))
in (

let rec group_by = (fun out ineqs -> (match (ineqs) with
| [] -> begin
Some (out)
end
| (u1, u2)::rest -> begin
(

let u2 = (FStar_TypeChecker_Normalize.normalize_universe env u2)
in (match (u2) with
| FStar_Syntax_Syntax.U_unif (uv) -> begin
(

let u1 = (FStar_TypeChecker_Normalize.normalize_universe env u1)
in if (FStar_Syntax_Util.eq_univs u1 u2) then begin
(group_by out rest)
end else begin
(let _144_1706 = (insert uv u1 out)
in (group_by _144_1706 rest))
end)
end
| _55_3381 -> begin
None
end))
end))
in (

let ad_hoc_fallback = (fun _55_3383 -> (match (()) with
| () -> begin
(match (ineqs) with
| [] -> begin
()
end
| _55_3386 -> begin
(

let wl = (

let _55_3387 = (empty_worklist env)
in {attempting = _55_3387.attempting; wl_deferred = _55_3387.wl_deferred; ctr = _55_3387.ctr; defer_ok = true; smt_ok = _55_3387.smt_ok; tcenv = _55_3387.tcenv})
in (FStar_All.pipe_right ineqs (FStar_List.iter (fun _55_3392 -> (match (_55_3392) with
| (u1, u2) -> begin
(

let u1 = (FStar_TypeChecker_Normalize.normalize_universe env u1)
in (

let u2 = (FStar_TypeChecker_Normalize.normalize_universe env u2)
in (match (u1) with
| FStar_Syntax_Syntax.U_zero -> begin
()
end
| _55_3397 -> begin
(match ((solve_universe_eq (- (1)) wl u1 u2)) with
| (UDeferred (_)) | (UFailed (_)) -> begin
(

let us1 = (match (u1) with
| FStar_Syntax_Syntax.U_max (us1) -> begin
us1
end
| _55_3407 -> begin
(u1)::[]
end)
in (

let us2 = (match (u2) with
| FStar_Syntax_Syntax.U_max (us2) -> begin
us2
end
| _55_3412 -> begin
(u2)::[]
end)
in if (FStar_All.pipe_right us1 (FStar_Util.for_all (fun _55_29 -> (match (_55_29) with
| FStar_Syntax_Syntax.U_zero -> begin
true
end
| u -> begin
(

let _55_3419 = (FStar_Syntax_Util.univ_kernel u)
in (match (_55_3419) with
| (k_u, n) -> begin
(FStar_All.pipe_right us2 (FStar_Util.for_some (fun u' -> (

let _55_3423 = (FStar_Syntax_Util.univ_kernel u')
in (match (_55_3423) with
| (k_u', n') -> begin
((FStar_Syntax_Util.eq_univs k_u k_u') && (n <= n'))
end)))))
end))
end)))) then begin
()
end else begin
(fail None u1 u2)
end))
end
| USolved (_55_3425) -> begin
()
end)
end)))
end)))))
end)
end))
in (match ((group_by [] ineqs)) with
| Some (groups) -> begin
(

let wl = (

let _55_3429 = (empty_worklist env)
in {attempting = _55_3429.attempting; wl_deferred = _55_3429.wl_deferred; ctr = _55_3429.ctr; defer_ok = false; smt_ok = _55_3429.smt_ok; tcenv = _55_3429.tcenv})
in (

let rec solve_all_groups = (fun wl groups -> (match (groups) with
| [] -> begin
()
end
| (u, lower_bounds)::groups -> begin
(match ((solve_universe_eq (- (1)) wl (FStar_Syntax_Syntax.U_max (lower_bounds)) (FStar_Syntax_Syntax.U_unif (u)))) with
| USolved (wl) -> begin
(solve_all_groups wl groups)
end
| _55_3444 -> begin
(ad_hoc_fallback ())
end)
end))
in (solve_all_groups wl groups)))
end
| None -> begin
(ad_hoc_fallback ())
end))))))


let solve_universe_inequalities : FStar_TypeChecker_Env.env  ->  (FStar_Syntax_Syntax.universe * FStar_Syntax_Syntax.universe) Prims.list  ->  Prims.unit = (fun env ineqs -> (

let tx = (FStar_Unionfind.new_transaction ())
in (

let _55_3449 = (solve_universe_inequalities' tx env ineqs)
in (FStar_Unionfind.commit tx))))


let rec solve_deferred_constraints : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun env g -> (

let fail = (fun _55_3456 -> (match (_55_3456) with
| (d, s) -> begin
(

let msg = (explain env d s)
in (Prims.raise (FStar_Syntax_Syntax.Error ((msg, (p_loc d))))))
end))
in (

let wl = (wl_of_guard env g.FStar_TypeChecker_Env.deferred)
in (

let _55_3459 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(let _144_1727 = (wl_to_string wl)
in (let _144_1726 = (FStar_Util.string_of_int (FStar_List.length g.FStar_TypeChecker_Env.implicits))
in (FStar_Util.print2 "Trying to solve carried problems: begin\n\t%s\nend\n and %s implicits\n" _144_1727 _144_1726)))
end else begin
()
end
in (

let g = (match ((solve_and_commit env wl fail)) with
| Some ([]) -> begin
(

let _55_3463 = g
in {FStar_TypeChecker_Env.guard_f = _55_3463.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = []; FStar_TypeChecker_Env.univ_ineqs = _55_3463.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _55_3463.FStar_TypeChecker_Env.implicits})
end
| _55_3466 -> begin
(FStar_All.failwith "impossible: Unexpected deferred constraints remain")
end)
in (

let _55_3468 = (solve_universe_inequalities env g.FStar_TypeChecker_Env.univ_ineqs)
in (

let _55_3470 = g
in {FStar_TypeChecker_Env.guard_f = _55_3470.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = _55_3470.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = []; FStar_TypeChecker_Env.implicits = _55_3470.FStar_TypeChecker_Env.implicits})))))))


let discharge_guard' : (Prims.unit  ->  Prims.string) Prims.option  ->  FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun use_env_range_msg env g -> (

let g = (solve_deferred_constraints env g)
in (

let _55_3485 = if (not ((FStar_Options.should_verify env.FStar_TypeChecker_Env.curmodule.FStar_Ident.str))) then begin
()
end else begin
(match (g.FStar_TypeChecker_Env.guard_f) with
| FStar_TypeChecker_Common.Trivial -> begin
()
end
| FStar_TypeChecker_Common.NonTrivial (vc) -> begin
(

let vc = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Inline)::(FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Eta)::(FStar_TypeChecker_Normalize.Simplify)::[]) env vc)
in (match ((check_trivial vc)) with
| FStar_TypeChecker_Common.Trivial -> begin
()
end
| FStar_TypeChecker_Common.NonTrivial (vc) -> begin
(

let _55_3483 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _144_1744 = (FStar_TypeChecker_Env.get_range env)
in (let _144_1743 = (let _144_1742 = (FStar_Syntax_Print.term_to_string vc)
in (FStar_Util.format1 "Checking VC=\n%s\n" _144_1742))
in (FStar_TypeChecker_Errors.diag _144_1744 _144_1743)))
end else begin
()
end
in (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.solve use_env_range_msg env vc))
end))
end)
end
in (

let _55_3487 = g
in {FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = _55_3487.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _55_3487.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _55_3487.FStar_TypeChecker_Env.implicits}))))


let discharge_guard : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun env g -> (discharge_guard' None env g))


let resolve_implicits : FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun g -> (

let unresolved = (fun u -> (match ((FStar_Unionfind.find u)) with
| FStar_Syntax_Syntax.Uvar -> begin
true
end
| _55_3496 -> begin
false
end))
in (

let rec until_fixpoint = (fun _55_3500 implicits -> (match (_55_3500) with
| (out, changed) -> begin
(match (implicits) with
| [] -> begin
if (not (changed)) then begin
out
end else begin
(until_fixpoint ([], false) out)
end
end
| hd::tl -> begin
(

let _55_3513 = hd
in (match (_55_3513) with
| (_55_3507, env, u, tm, k, r) -> begin
if (unresolved u) then begin
(until_fixpoint ((hd)::out, changed) tl)
end else begin
(

let env = (FStar_TypeChecker_Env.set_expected_typ env k)
in (

let tm = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::[]) env tm)
in (

let _55_3516 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(let _144_1760 = (FStar_Syntax_Print.uvar_to_string u)
in (let _144_1759 = (FStar_Syntax_Print.term_to_string tm)
in (let _144_1758 = (FStar_Syntax_Print.term_to_string k)
in (FStar_Util.print3 "Checking uvar %s resolved to %s at type %s\n" _144_1760 _144_1759 _144_1758))))
end else begin
()
end
in (

let _55_3525 = (env.FStar_TypeChecker_Env.type_of (

let _55_3518 = env
in {FStar_TypeChecker_Env.solver = _55_3518.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _55_3518.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _55_3518.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _55_3518.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _55_3518.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _55_3518.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _55_3518.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _55_3518.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _55_3518.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _55_3518.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _55_3518.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _55_3518.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _55_3518.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _55_3518.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _55_3518.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _55_3518.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _55_3518.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _55_3518.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.type_of = _55_3518.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = _55_3518.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = true}) tm)
in (match (_55_3525) with
| (_55_3521, _55_3523, g) -> begin
(

let g = if env.FStar_TypeChecker_Env.is_pattern then begin
(

let _55_3526 = g
in {FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = _55_3526.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _55_3526.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _55_3526.FStar_TypeChecker_Env.implicits})
end else begin
g
end
in (

let g' = (discharge_guard' (Some ((fun _55_3529 -> (match (()) with
| () -> begin
(FStar_Syntax_Print.term_to_string tm)
end)))) env g)
in (until_fixpoint ((FStar_List.append g'.FStar_TypeChecker_Env.implicits out), true) tl)))
end)))))
end
end))
end)
end))
in (

let _55_3531 = g
in (let _144_1764 = (until_fixpoint ([], false) g.FStar_TypeChecker_Env.implicits)
in {FStar_TypeChecker_Env.guard_f = _55_3531.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = _55_3531.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _55_3531.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _144_1764})))))


let force_trivial_guard : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.guard_t  ->  Prims.unit = (fun env g -> (

let g = (let _144_1769 = (solve_deferred_constraints env g)
in (FStar_All.pipe_right _144_1769 resolve_implicits))
in (match (g.FStar_TypeChecker_Env.implicits) with
| [] -> begin
(let _144_1770 = (discharge_guard env g)
in (FStar_All.pipe_left Prims.ignore _144_1770))
end
| (reason, _55_3541, _55_3543, e, t, r)::_55_3538 -> begin
(let _144_1775 = (let _144_1774 = (let _144_1773 = (let _144_1772 = (FStar_Syntax_Print.term_to_string t)
in (let _144_1771 = (FStar_Syntax_Print.term_to_string e)
in (FStar_Util.format3 "Failed to resolve implicit argument of type \'%s\' introduced in %s because %s" _144_1772 _144_1771 reason)))
in (_144_1773, r))
in FStar_Syntax_Syntax.Error (_144_1774))
in (Prims.raise _144_1775))
end)))


let universe_inequality : FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe  ->  FStar_TypeChecker_Env.guard_t = (fun u1 u2 -> (

let _55_3551 = trivial_guard
in {FStar_TypeChecker_Env.guard_f = _55_3551.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = _55_3551.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = ((u1, u2))::[]; FStar_TypeChecker_Env.implicits = _55_3551.FStar_TypeChecker_Env.implicits}))




