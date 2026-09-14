---
name: shimmy-onboarding
description: Install or onboard Shimmy by finding and invoking the authoritative bootstrap logic owned by the Shimmy Product repository. Use for first-time Shimmy setup or contributor onboarding; never duplicate or invent bootstrap behavior.
---

# Shimmy Onboarding

1. Determine whether the user is installing a release, onboarding from a local Product checkout, or setting up a contributor workspace.
2. Read authoritative Shimmy Product documentation and repository contents to locate the current bootstrap entrypoint and prerequisites.
3. Explain material effects, required permissions, and any destructive behavior.
4. Obtain user approval before invoking the bootstrap.
5. Invoke the Product-owned logic; do not reproduce its implementation inside this plugin.
6. Validate the installed CLI/runtime using Product-documented checks.
7. For contributor onboarding, optionally invoke or recommend the governed-development project-onboarding workflow.
8. Never create Git commits.

If the authoritative bootstrap entrypoint cannot be determined, stop and report the missing contract. Do not guess a command from historical conversation context.
