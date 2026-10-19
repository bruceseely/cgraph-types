# cgraph-types

The Conceptual Graph **type lattice** for [`cgraph`](https://github.com/bruceseely/cgraph):
the concept and relation type definitions the engine loads as its live ontology.

The two type files are the ontology proper, each a plain list of S-expression
definitions:

- **`concept-types.lisp`** — 174 concept types (the `[BRACKET]` node types), each
  `(:label … :supertypes (…) [:canonical-graph "…"])`. Verbs are concepts (e.g.
  `give`, `pay`, `see`, `relocate`); the lattice runs
  `individual ⊃ {entity, situation} ⊃ …`.
- **`relation-types.lisp`** — 37 relation types (the `(paren)` arc types, e.g.
  `agnt`, `obj`, `rcpt`, `time`), each with `:source-types` / `:dest-type`
  signatures. Case roles are relations.

Two more files give those types their **English**, because a domain is one
directory — what exists, what relates, and how it is said:

- **`lexicon-overrides.lisp`** — how cgraph's generator WORDS these types, one
  `(:label … :key value …)` form per entry. Defaults come from the lattice, so a
  type is listed only where English departs from them: `(:label baltimore
  :proper-p t)` is what stops `say` producing "to a baltimore". Loaded by
  `initialize-types`; see cgraph `docs/lexicon-overrides.md`.
- **`lexicon.dict`** — the PARSIFAL vocabulary that lets the
  [`cg-from-parse`](https://github.com/bruceseely/cg-from-parse) extractor PARSE
  sentences about these types (word features, verb case frames, semantic
  markers). Loaded by that system's `ensure-domain-lexicon`, not by cgraph.

## How it's used

`cgraph` reads this as its **live catalog** through the `~/.cgraph/types` symlink
(→ this repo). Editing a file here changes the ontology the engine uses on its
next `initialize-cgraph` / `reset-cgraph`.

## Validating a change

There's no unit suite — the relevant check is that the whole catalog **loads**
and every `:canonical-graph` parses cleanly:

```lisp
(ql:quickload :cgraph)
(let ((cg::*external-types-directory* nil)
      (cg::*cgraph-types-directory* "/path/to/cgraph-types/"))   ; note trailing slash
  (cg::reset-cgraph))            ; signals an error on a malformed type or canonical graph
```

Downstream, cgraph is a dependency of the
[`cg-from-parse`](https://github.com/bruceseely/cg-from-parse) extractor, whose
`test/run-all-suites.sh` is a **whole-stack gate** (parsifal + cgraph + extractor,
each in its own process). That gate deliberately runs cgraph against its own
throwaway **test-types** catalog — *not* this live one — so it never touches the
ontology here; this repo's own safety net is the load check above.
