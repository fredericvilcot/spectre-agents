---
name: learn
description: "Re-run stack learning. Generates CRAFT skills for your stack. Use when stack evolved manually."
context: conversation
allowed-tools: Read, Bash, Glob, Grep, Write, Task
---

# Spectre Learn — Re-generate Stack Skills

**Re-run learning when your stack has evolved.**

---

## When to Use

```
/learn    # Re-generate CRAFT skills for current stack
```

Use when:
- Stack changed (added new framework, library)
- First time on existing project
- Skills seem outdated

---

## What It Does

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                  │
│   /learn                                                         │
│       │                                                          │
│       ▼                                                          │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │  1. DETECT STACK                                         │   │
│   │     → package.json, tsconfig.json, go.mod, etc.         │   │
│   │     → Write .spectre/context.json                        │   │
│   └─────────────────────────────────┬───────────────────────┘   │
│                                     │                            │
│                                     ▼                            │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │  2. GENERATE CRAFT SKILLS                                │   │
│   │     → Written as Architect would write them             │   │
│   │     → Write .spectre/stack-skills.md                    │   │
│   └─────────────────────────────────┬───────────────────────┘   │
│                                     │                            │
│                                     ▼                            │
│                                   DONE                           │
│   Skills ready for Architect and Dev                            │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Automatic During /craft

Learning runs automatically at the start of `/craft`:

```
/craft
   │
   ├─ Stack detected or asked
   │
   ├─ ══════════════════════════════════
   │   LEARNING AGENT RUNS AUTOMATICALLY
   │   → context.json + stack-skills.md
   │  ══════════════════════════════════
   │
   └─ PO → Architect (with skills) → Dev (with skills) → QA
```

**You only need `/learn` to re-run manually if stack changed.**

---

## Execution

```
Task(
  subagent_type: "learning-agent",
  prompt: """
    RE-GENERATE STACK SKILLS

    1. Detect current stack from project files
    2. Generate CRAFT-oriented skills for the stack
    3. Output to .spectre/stack-skills.md

    Skills will be injected to Architect and Dev.
  """
)
```

---

## Output Files

```
.spectre/
├── context.json        # Detected stack (gitignored)
└── stack-skills.md     # CRAFT skills (gitignored)
```

### .gitignore

On first run, adds to `.gitignore`:

```
# Spectre Agents
.spectre/
```

---

## Summary

| Command | When |
|---------|------|
| `/craft` | Learning runs automatically |
| `/learn` | Re-run manually if stack evolved |
