(* Empty Set *)
Inductive Empty_set : Set :=.

Theorem empty_set_eq : forall x y:Empty_set, x=y.
Proof.
  intros x y.
  elim x.
Qed.

Theorem empty_set_neq : forall x y:Empty_set, ~x=y.
Proof.
  intros x y.
  elim x.
Qed.