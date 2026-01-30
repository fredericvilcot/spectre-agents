---
name: craft
description: "Craft something. Smart professional flow: spec first, then adapt. QA optional."
context: conversation
allowed-tools: Task
---

# /craft — Launch CRAFT Master

**Claude does ONE thing: spawn the CRAFT Master. Nothing else.**

---

## ABSOLUTE RULE

```
╔═══════════════════════════════════════════════════════════════════╗
║                                                                   ║
║   🚫  CLAUDE MUST NOT INTERACT DURING /craft  🚫                 ║
║                                                                   ║
║   Claude's ONLY job:                                              ║
║   1. Spawn craft-master agent                                     ║
║   2. Relay final results                                          ║
║                                                                   ║
║   Claude MUST NOT:                                                ║
║   ❌ Ask questions                                                ║
║   ❌ Write code                                                   ║
║   ❌ Make decisions                                               ║
║   ❌ Interpret user requests                                      ║
║                                                                   ║
║   CRAFT Master handles EVERYTHING.                                ║
║                                                                   ║
╚═══════════════════════════════════════════════════════════════════╝
```

---

## Execution

**IMMEDIATELY spawn the CRAFT Master:**

```
Task(
  subagent_type: "craft-master",
  prompt: """
    /craft has been invoked.

    You are now in control. Handle the entire session:
    1. Display welcome banner
    2. Spawn learning-agent to detect stack
    3. Ask user what they want to craft
    4. Gather requirements
    5. Orchestrate agents (PO, Architect, Dev, QA)
    6. Run verification loop until all green
    7. Report final results

    YOU are the interface. YOU ask questions. YOU make CRAFT decisions.
    Claude will only relay your final output to the user.
  """
)
```

---

## Why CRAFT Master?

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                  │
│   BEFORE: Claude orchestrates                                    │
│   ─────────────────────────────                                  │
│   → Claude asks questions (may miss CRAFT)                      │
│   → Claude interprets requests (may accept anti-patterns)       │
│   → Claude routes to agents (may skip steps)                    │
│                                                                  │
│   AFTER: CRAFT Master orchestrates                               │
│   ────────────────────────────────                               │
│   → CRAFT Master is a SUPERSET of all agents                    │
│   → Embodies Kent Beck, Uncle Bob, Fowler, Evans, Cockburn      │
│   → CANNOT produce anti-CRAFT code                              │
│   → Every question, every decision = CRAFT-aligned              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## That's It

The entire /craft skill is now:

1. Claude receives `/craft`
2. Claude spawns `craft-master`
3. CRAFT Master takes over completely
4. Claude relays final result

**No more Claude in the middle. Pure CRAFT.**
