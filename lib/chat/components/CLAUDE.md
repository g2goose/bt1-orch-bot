# lib/chat/components/

JSX components for the chat UI. Compiled to `.js` by `npm run build` (esbuild).

## Tool Display Names

`tool-names.js` auto-generates display names from the tool's snake_case name (split on `_`, capitalize each word). No map to maintain — adding a new tool automatically gets a display name.

This file is **UI-only** — it controls display text, not which tools are available. Tool-to-agent assignment lives in `lib/ai/agent.js`.

## Settings UI Standards

All admin/settings pages follow a unified design system. Shared components live in `settings-shared.jsx`. **Use these components — do not create local duplicates.**

### Shared Components (`settings-shared.jsx`)

| Component | Purpose |
|-----------|---------|
| `StatusBadge` | Green/muted dot + "Set" / "Not set" text |
| `SecretRow` | Unified credential/secret row — handles KeyIcon, status, edit mode, saved feedback, delete |
| `VariableRow` | GitHub variable row — shows current value, text input, delete |
| `Dialog` | Modal wrapper — `max-w-md`, Escape key, backdrop click, portal |
| `EmptyState` | Dashed border card with message and optional action button |
| `formatDate` | Timestamp → "Jan 1, 2025" |
| `timeAgo` | Timestamp → "5m ago" |

### Page Headers

- Section heading: `text-base font-medium` (never `text-lg` or larger — the layout title "Admin" is `text-2xl`)
- With action button: `<div className="flex items-center justify-between mb-4">`
- Without action button: `<div className="mb-4">`
- No horizontal rule dividers between header and content

### Buttons

All buttons include `transition-colors`. Three tiers by context:

| Context | Padding | Text | Example |
|---------|---------|------|---------|
| Inline row | `px-2.5 py-1.5` | `text-xs` | Set, Update, Cancel, Delete |
| Dialog footer | `px-3 py-1.5` | `text-sm` | Save, Cancel |
| Empty state | `px-3 py-1.5` | `text-sm` | Create API key |

Primary: `bg-foreground text-background hover:bg-foreground/90 disabled:opacity-50`
Secondary: `border border-border text-muted-foreground hover:bg-accent hover:text-foreground`
Cancel (inline): `border border-border text-muted-foreground hover:text-foreground`
Cancel (dialog): same as inline cancel
Destructive: `border-destructive text-destructive hover:bg-destructive/10`

### Delete Confirmation

Two-click inline pattern. First click shows "Confirm" in destructive style, auto-resets after 3 seconds. Never use `confirm()` browser dialogs.

### Save Feedback

- During save: button text → "Saving..."
- After save: button border turns green + "Saved" with checkmark for 2 seconds
- Auto-save (Chat LLM only): 800ms debounce, "Saving..." / "Saved" indicators

### Loading Skeletons

`bg-border/50 rounded-md animate-pulse`. Sizes by page type:
- Single-item: `h-24`
- List pages: two blocks `h-16` in `space-y-3`
- Complex pages: `h-48`

### Spacing

- Between major sections: `space-y-6`
- Card padding: `p-4`
- Form field spacing: `space-y-3`
- Dialog footer: `mt-5 flex justify-end gap-2`

### Status Text

Always "Set" / "Not set" — never "Configured".

### Dialogs

- Width: `max-w-md`
- Title: `text-base font-semibold mb-4`
- Use the shared `Dialog` component, not inline modal markup
