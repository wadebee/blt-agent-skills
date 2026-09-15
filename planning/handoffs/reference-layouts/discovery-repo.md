# Discovery Repo Reference Layout

```text
<project>-disc-<id>-<slug>/
├── .git/
├── .gitmodules
├── AGENTS.md
├── DISCOVERY.yaml
├── GOVERNANCE-READING-SCOPE.yaml
├── .governance/       # read-only submodule, fixed exact commit
└── .contracts/       # Contract-aware mode only
    ├── EXPORT.yaml   # explicit source identity, approved paths and file hashes
    └── files/<approved exports>
```

The complete Governance tree is present for both Full and Curated reading scopes.
The scope record and root agent instructions control which paths may be read;
excluded bodies remain locally available but must not enter agent context through
any transport. Never place generated metadata or exports inside the submodule.

Creation stages only `.gitmodules` and the Governance Git link, leaving the
Discovery Repo uncommitted for developer review. A fresh clone must initialize
its submodule using an available copy of the retained Governance commit.

Product access permits only the approved inspection or Contract Exports. It does
not preload Product CI, lockfiles, dependencies, source, tests, directory
conventions, or history. Later implementation choices follow the Discovery Charter
and Product Access Mode. The Governance pin remains fixed; a different revision
requires a successor.
