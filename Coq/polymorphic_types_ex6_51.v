(* Empty Set *)
Inductive Empty_set : Set :=.

Theorem strange_eq : forall x y:Empty_set, x=y.
Proof.
  intros x y.
  elim x.
Qed.

Theorem strange_neq : forall x y:Empty_set, ~x=y.
Proof.
  intros x y.
  elim x.
Qed.