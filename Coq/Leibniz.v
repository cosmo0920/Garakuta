Section leibniz.
  Set Implicit Arguments.
  Unset Strict Implicit.
  Variable A : Set.
  Definition leibniz (a b:A) : Prop :=
    forall P:A -> Prop, P a -> P b.

  Require Import Relations.

  Theorem leibniz_sym : symmetric A leibniz.
  Proof.
    unfold symmetric, leibniz.
    intros x y H H1.
    apply H.
    trivial.
  Qed.

  Theorem leibniz_refl : reflexive A leibniz.
  Proof.
    unfold reflexive, leibniz.
    intros x H H1.
    apply H1.
  Qed.

  Theorem leibniz_trans : transitive A leibniz.
  Proof.
    unfold transitive, leibniz.
    intros x y z H H1.
    apply H1.
    assumption.
  Qed.

  Hint Resolve leibniz_trans leibniz_sym leibniz_refl: sets.
  Theorem leibniz_equiv : equiv A leibniz.
  Proof.
    unfold equiv; auto with sets.
  Qed.

  Theorem leibniz_least_reflexive :
    forall R:relation A, reflexive A R -> inclusion A leibniz R.
  Proof.
    unfold inclusion, leibniz.
    intros.
    apply H0.
    apply H.
  Qed.

  Theorem leibniz_eq : forall a b:A, leibniz a b -> a = b.
  Proof.
    unfold leibniz.
    intros a b H.
    apply H.
    trivial.
  Qed.

  Theorem eq_leibniz : forall a b:A, a = b -> leibniz a b.
  Proof.
    unfold leibniz.
    intros a b H.
    rewrite H.
    auto.
  Qed.

  Theorem leibniz_ind :
    forall (x:A)(P:A->Prop), P x -> forall y:A, leibniz x y -> P y.
  Proof.
    unfold leibniz.
    intros.
    apply H0.
    assumption.
  Qed.
  Unset Implicit Arguments.
End leibniz.
