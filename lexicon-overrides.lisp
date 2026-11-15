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
;;; docs/lexicon-overrides.md for the full list, and (cg::report-lexicon-lint)
;;; for the checks -- a misspelled key is a lint ERROR, a label no type has is
;;; :INFO. Defaults come from the lattice (POS from the supertypes, gender from
;;; PERSON subtypes, ...), so a type needs an entry here only when English
;;; departs from what the lattice implies. Most types need none.

;; A city that is one particular city. Without this the generator has only the
;; type label to go on and says "John will drive his automobile to a baltimore".
(:label baltimore :proper-p t)

;;; --- Labels that say more than the English -------------------------------
;;; These moved here from cgraph's own lexicon.lisp (2026-11-15): each exists
;;; because of how THIS ontology names or places a type, not because of
;;; anything about the English word, so it belongs with the ontology.

;; Compound labels whose hyphen is ontology, not English. A hyphenated label
;; surfaces with its hyphen ("a body-part"), and these are types you would
;; actually write in a graph, so the hyphen reaches the reader. The label stays
;; as it is: BODY-PART and the rest are named to sit in the lattice. Only the
;; English needs saying. (Purely structural types -- ABSTRACT-OBJECT, the
;; *-ATTRIBUTEs, the *-EXTENTs -- are left alone: nothing puts them in a graph.)
(:label body-part       :lemma "body part")
(:label food-item       :lemma "food item")
(:label city-government :lemma "city government")
(:label office-building :lemma "office building")

;; A label qualified to split a polysemous word says more than the English
;; does: the word for an EMAIL-MESSAGE is just "email". Pluralization appends
;; to the whole string, so "text messages" comes out right.
(:label text-message  :lemma "text message")
(:label email-message :lemma "email" :synonym-ok t)

;; English says "state" for both the land and the polity; the split that
;; matters here is one the ontology makes and the word does not.
(:label geological-landform :lemma "landform")
(:label geographical-state  :lemma "state")
(:label geopolitical-state  :lemma "state")

;; Marques. The -VEHICLE suffix distinguishes the car from the company that
;; makes it, a distinction English drops entirely -- you say "a Chevy". Not
;; :proper-p, which means no article and would give "Dave has Chevy": a marque
;; used for the car is an ordinary count noun that happens to be capitalized.
(:label chevy-vehicle :lemma "Chevy")
(:label ford-vehicle  :lemma "Ford")
(:label tesla-vehicle :lemma "Tesla")

;; TELEPHONY is the medium, TELEPHONE the device: you reach someone BY
;; telephone but WITH a telephone. A medium is mass, and wants "by" on an
;; instrument arc rather than :inst's default "with". (EMAIL and POST, whose
;; labels are already the English word, keep their entries in cgraph.)
(:label telephony :mass-p t :inst-prep "by" :lemma "telephone" :synonym-ok t)

;; The verb is "call", not the label "phone-call"; as an NP the same lemma
;; reads "a call". A communication verb, so the recipient is the direct object
;; and the content takes "about" ("she called him about the party").
(:label phone-call :lemma "call" :rcpt-direct t :obj-prep "about")

;; A noun that names an event. Everything under EVENT realizes as a verb by
;; default -- without this PARTY comes out "Is partied in a library" -- and
;; unlike DINNER-EVENT, which never surfaces because its parts carry the
;; clause, a party is usually the subject of its own sentence.
(:label party :pos :noun)
