;;; -*- Mode: LISP; Syntax: Common-lisp; Base: 10; Lowercase: Yes -*-
;;;
;;; lexicon-overrides.lisp -- how this domain's types are WORDED.
;;;
;;; The third file of the domain, beside concept-types.lisp (what exists) and
;;; relation-types.lisp (what relates). This one is read by cgraph's generator:
;;; one form per entry, in the same shape the type files use, each a
;;; REGISTER-LEXICON-ENTRY call with :label naming the type.
;;;
;;;   (:label baltimore :proper-p t)      ; no article, capitalized
;;;   (:label rice      :mass-p t)        ; "rice", never "a rice"
;;;   (:label belief    :lemma "believe") ; the English is not the label
;;;
;;; Every key REGISTER-LEXICON-ENTRY takes works here; see cgraph
;;; notes/lexicon-overrides.md for the full list, and (cg::report-lexicon-lint)
;;; for the checks -- a misspelled key is a lint ERROR, a label no type has is
;;; :INFO. Defaults come from the lattice (POS from the supertypes, gender from
;;; PERSON subtypes, ...), so a type needs an entry here only when English
;;; departs from what the lattice implies. Most types need none.

;; A city that is one particular city. Without this the generator has only the
;; type label to go on and says "John will drive his automobile to a baltimore".
(:label baltimore :proper-p t)
