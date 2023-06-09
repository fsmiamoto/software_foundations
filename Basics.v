Inductive day : Type := 
    | monday
    | tuesday
    | wednesday
    | thursday
    | friday
    | saturday
    | sunday.

Definition next_weekday (d:day) : day :=
    match d with
    | monday => tuesday
    | tuesday => wednesday
    | wednesday => thursday
    | thursday  => friday
    | friday => monday
    | saturday => monday
    | sunday => monday
    end.

Compute (next_weekday friday).

Compute (next_weekday (next_weekday saturday)).

Example test_next_weekday :
    (next_weekday (next_weekday saturday)) = tuesday.

Proof. simpl. reflexivity. Qed.

Inductive bool : Type :=
  | true
  | false.

Definition negb (b:bool) : bool :=
  match b with
  | true => false
  | false => true
  end.

Definition andb (b1 b2: bool) : bool :=
  match b1 with
  | true => b2
  | false => false 
  end.

Definition orb (b1 b2: bool) : bool :=
  match b1 with
  | true => true
  | false => b2
  end.

Example test_orb1: (orb true false) = true.
Proof. simpl. reflexivity. Qed.

Notation "x && y" := (andb x y).
Notation "x || y" := (orb x y).

Definition negb' (b: bool) : bool :=
  if b then false
  else true.

Definition nandb (b1:bool) (b2:bool) : bool :=
  negb (andb b1 b2).

Example test_nandb1: (nandb true false) = true.
  Proof. reflexivity. Qed.
Example test_nandb2: (nandb false false) = true.
  Proof. reflexivity. Qed.
Example test_nandb3: (nandb false true) = true.
  Proof. reflexivity. Qed.
Example test_nandb4: (nandb true true) = false.
  Proof. reflexivity. Qed.

Definition andb3 (b1:bool) (b2:bool) (b3:bool) : bool :=
  (andb b1 (andb b2 b3)).

Example test_andb31: (andb3 true true true) = true.
  Proof. reflexivity. Qed.
Example test_andb32: (andb3 false true true) = false.
  Proof. reflexivity. Qed.
Example test_andb33: (andb3 true false true) = false.
  Proof. reflexivity. Qed.
Example test_andb34: (andb3 true true false) = false.
  Proof. reflexivity. Qed.

Inductive rgb : Type :=
  | red
  | green
  | blue.

Inductive color : Type :=
  | black
  | white
  | primary (p :rgb).

Definition monochrome (c: color) : bool :=
  match c with
    | black => true
    | white => true
    | primary p => false
  end.

Definition isred (c: color) : bool :=
  match c with
  | black => false
  | white => false
  | primary red => true
  | primary _ => false
  end.

  Module NatPlayground.
   Inductive nat : Type :=
   | O 
   | S (n : nat).

   Definition pred(n: nat) : nat :=
    match n with
    | O => O
    | S n' => n'
    end.

  Compute (pred (S (S (S (S O))))).
End NatPlayground.

Fixpoint even (n: nat) : bool :=
  match n with
  | O => true
  | S O => false
  | S (S n') => even n'
  end.

Compute (even 3).

Definition odd (n: nat) : bool :=
  negb (even n).

Example test_odd1: odd 1 = true.
Proof. simpl. reflexivity. Qed.

Example test_odd2: odd 2 = false.
Proof. reflexivity. Qed.


Module NatPlayground2.
Fixpoint plus (n : nat) (m: nat) : nat :=
  match n with
  | O => m
  | S n' => S (plus n' m)
end.

Compute (plus 3 2).

Fixpoint mult (n m : nat) : nat :=
  match n with
  | O => O
  | S n' => plus m (mult n' m)
  end.

Example test_mult1: (mult 3 3) = 9.
Proof. simpl. reflexivity. Qed.

Fixpoint minus (n m : nat) : nat :=
  match n, m with
  | O, _ => O
  | S _ , O => n
  | S n', S m' => minus n' m' 
  end.

End NatPlayground2.


Fixpoint factorial (n:nat) : nat :=
  match n with
  | O => S O
  | S n' => mult n (factorial n')
  end.

Example test_factorial1: (factorial 3) = 6.
Proof. reflexivity. Qed.

Example test_factorial2: (factorial 5) = (mult 10 12).
Proof. reflexivity. Qed.

Notation "x + y" := (plus x y)
                       (at level 50, left associativity)
                       : nat_scope.
Notation "x - y" := (minus x y)
                       (at level 50, left associativity)
                       : nat_scope.
Notation "x * y" := (mult x y)
                       (at level 40, left associativity)
                       : nat_scope.
Check ((0 + 1) + 1) : nat.

Fixpoint eqb (n m : nat) : bool :=
  match n with
  | O => match m with
         | O => true
         | S m' => false
         end
  | S n' => match m with
            | O => false
            | S m' => eqb n' m'
            end
  end.


Fixpoint leb (n m : nat) : bool :=
match n with
| O => true
| S n' =>
    match m with
    | O => false
    | S m' => leb n' m'
    end
end.
Example test_leb1: leb 2 2 = true.
Proof. simpl. reflexivity. Qed.
Example test_leb2: leb 2 4 = true.
Proof. simpl. reflexivity. Qed.
Example test_leb3: leb 4 2 = false.
Proof. simpl. reflexivity. Qed.


Notation "x =? y" := (eqb x y) (at level 70) : nat_scope.
Notation "x <=? y" := (leb x y) (at level 70) : nat_scope.

Example test_leb3': (4 <=? 2) = false.
Proof. simpl. reflexivity. Qed.

Compute (4 <=? 2).

Definition ltb (n m : nat) : bool :=
  andb (n <=? m) (negb (n =? m)).

Notation "x <? y" := (ltb x y) (at level 70) : nat_scope.

Example test_ltb1: (ltb 2 2) = false.
Proof. reflexivity. Qed.

Example test_ltb2: (ltb 2 4) = true.
Proof. reflexivity. Qed.

Example test_ltb3: (ltb 4 2) = false.
Proof. reflexivity. Qed.

Theorem plus_O_n:
  forall n : nat, 0 + n = n.
Proof.
  intros n. simpl. reflexivity.
Qed.

Theorem plus_1_l: forall n:nat, 1+n = S n.
Proof.
 intros n. reflexivity. Qed. 

Theorem mult_0_l: forall n:nat, 0 * n = 0.
Proof.
  intros n. reflexivity. Qed.

Theorem  plus_id_example: forall n m: nat,
  n = m -> n + n = m+m.
Proof.
  intros n m.
  intros H.
  rewrite <- H.
  simpl.
  reflexivity. Qed.

Theorem plus_id_exercise: forall n m o : nat,
  n = m -> m = o -> n + m = m + o.
Proof.
  intros n m o.
  intros H G.
  rewrite H.
  rewrite G.
  simpl.
  reflexivity.
Qed.
  
Check mult_n_O.

Check mult_n_Sm.

Theorem mult_n_0_m_0 : forall p q : nat,
  (p * 0) + (q * 0) = 0.
Proof.
  intros p q.
  rewrite <- mult_n_O.
  rewrite <- mult_n_O.
  reflexivity. Qed.

Theorem mult_n_1: forall p : nat,
 p*1 = p.
Proof.
  intros p. 
  rewrite <- mult_n_Sm.
  rewrite <- mult_n_O.
  rewrite plus_O_n.
Qed.

Theorem plus_1_neq_0 : forall n : nat,
  (n + 1) =? 0 = false.
Proof.
  intros n.
  destruct n as [ | n'] eqn:E.
  simpl.
  reflexivity. 
  reflexivity.
Qed.

Theorem negb_involutive: forall b : bool,
  negb (negb b) = b.
Proof.
  intros b. destruct b eqn:E.
  - reflexivity. 
  - reflexivity.
Qed.
