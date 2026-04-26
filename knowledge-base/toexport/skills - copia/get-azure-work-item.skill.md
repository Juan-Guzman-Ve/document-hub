# Skill — Get Azure Work Item

> **Purpose:** Retrieve a work item from the Azure DevOps backlog and present it in a consistent, readable format.
> **Triggered by:** Any agent or user request that references a backlog ticket — by ID number or by title.

---

## When to Use This Skill

Use this skill whenever:

- The user provides an Azure DevOps work item ID (e.g. `2271880`, `AB#2271880`)
- The user provides a title or partial title (e.g. `"Watson metrics"`, `"signals balance service"`)
- An agent needs backlog context before starting a feature or task

---

## Input Resolution

Determine the lookup strategy from what the user provides:

| Input type | How to detect | Strategy |
|---|---|---|
| Numeric ID | Input is a number, or prefixed with `AB#` | Direct lookup by ID |
| Title / keyword | Input is a string, not purely numeric | Text search, then confirm |

Strip `AB#` prefix if present before passing the ID to the tool.

---

## Execution Flow

### Path A — Lookup by ID

1. Call `mcp_microsoft_azu_wit_get_work_item` with `id` set to the numeric ID and `expand` set to `"all"`
2. If the item is found → proceed to **Format & Return**
3. If not found → report: *"No work item found with ID {id}. Please verify the number."* — do not guess or search

### Path B — Lookup by Title / Keywords

1. Call `mcp_microsoft_azu_search_workitem` with `searchText` set to the user's input
2. Evaluate the results:

| Result count | Action |
|---|---|
| 0 results | Report: *"No work items found matching '{input}'. Try refining the search terms."* |
| 1 result | Use that item's ID → proceed to **Path A** step 1 |
| 2–5 results | Present the list (ID + title + state) and ask the user to confirm which one |
| >5 results | Present the top 5, ask the user to refine or pick |

3. Once the user confirms a single item → proceed to **Path A** step 1 to fetch full details

---

## Format & Return

After a successful retrieval, always present the work item in this standard block:

```
**AB#{id} — {title}**

| Field        | Value        |
|---|---|
| Type         | {WorkItemType} |
| State        | {State} |
| Assigned To  | {AssignedTo.displayName} |
| Iteration    | {IterationPath} |
| Priority     | {Priority} |
| Tags         | {Tags} |
| Created      | {CreatedDate} |
| Last Updated | {ChangedDate} |

---

**Description**
{Description — plain text, HTML stripped}

---

**Acceptance Criteria**
{AcceptanceCriteria — plain text, HTML stripped}
```

**HTML stripping rules:**
- Remove all HTML tags
- Render `<ul>/<li>` as markdown bullet lists (`- item`)
- Render `<ol>/<li>` as numbered lists (`1. item`)
- Render `<strong>/<b>` as `**bold**`
- Render `<code>` as backtick-wrapped inline code
- Render `<table>` as markdown tables where possible; fall back to a bullet list of rows if columns are too wide
- Collapse excess blank lines to a single blank line

---

## Tool Reference

| Tool | When to use |
|---|---|
| `mcp_microsoft_azu_wit_get_work_item` | Fetch a single work item by numeric ID. Use `expand: "all"` to include description and acceptance criteria. |
| `mcp_microsoft_azu_search_workitem` | Search by title/keywords when no ID is available. Returns summary results — always follow up with a full `get_work_item` call for the chosen result. |

---

## Error Handling

| Situation | Response |
|---|---|
| ID not found | *"No work item found with ID {id}. Please verify the number."* |
| Search returns 0 results | *"No work items found matching '{input}'. Try refining the search terms."* |
| Search is ambiguous | Present a numbered list of matches (ID + title + state). Ask user to pick. |
| Tool call fails | Report the error as-is. Do not retry silently or invent fallback data. |

---

## Rules

- **Never invent work item data** — only return what the tools provide
- **Never proceed on an ambiguous search match** — always confirm with the user first
- **Always fetch full details** via `get_work_item` before presenting — search results are summaries only
- **Always strip HTML** from description and acceptance criteria fields before displaying

---

*Created: 2026-04-23*
*Last updated: 2026-04-23*
