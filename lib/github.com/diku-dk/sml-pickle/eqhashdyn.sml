(** Dynamic types with support for equality and hashing. *)

signature EQ_HASH_DYN =
  sig
    type dyn
    val new  : ('a -> int -> word) -> ('a * 'a -> bool) -> ('a -> dyn) * (dyn -> 'a)
    val eq   : dyn * dyn -> bool
    val hash : int -> dyn -> word
  end

(**

[type dyn] Type dynamic.

[new hash eq] returns a pair of functions (f,g) for embedding (and
extracting) an arbitrary value into (and out of) the type dyn. The
hash and eq arguments are used for defining the module's hash and eq
functions on values of type dyn.

[eq(d1,d2)] returns the result of applying the underlying equality
function provided with new on d1 and d2.

[hash d] returns the result of applying the underlying hash function
provided with new on d.

[Discussion]

See [1].

 [1] Martin Elsman. Type-Specialized Serialization with Sharing. In
     Sixth Symposium on Trends in Functional Programming (TFP
     ‘05). Tallinn, Estonia. September 2005.

*)

(** SigDoc *)
structure EqHashDyn :> EQ_HASH_DYN =
struct

    datatype method = RESET | EQ | SET | HASH of int
    type dyn = method -> bool
    val hash_tmp : word ref = ref 0w0
    fun new h eq =
       let val r = ref NONE
	   fun eq_opt (NONE,NONE) = true
	     | eq_opt (SOME x, SOME y) = eq (x,y)
	     | eq_opt _ = false
       in  ( fn x =>
                let val new = SOME x
                in  fn RESET => (r := NONE; false)
		     | SET => (r := new; false)
		     | EQ => eq_opt(new, !r)
		     | HASH depth => (hash_tmp := h x depth; false)
                end
           , fn f => ( r := NONE
                     ; f SET
                     ; valOf(!r)
                     )
           )
       end

   fun eq (f1, f2) = (f2 RESET; f1 SET; f2 EQ)

   fun hash depth f = (f (HASH depth); !hash_tmp)
end

(* Copyright, Martin Elsman 2003-2014, MIT Licence *)
