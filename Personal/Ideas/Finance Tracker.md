# FinanceTracker — Project Proposal

**Personal Finance Management System** _Version 2.0 — May 2026_

---

## 1. Executive Summary

FinanceTracker is a personal finance management system that allows users to log income and expenses by simply sending WhatsApp messages in a structured format. The system uses **Supabase as its entire backend** — handling the database, auto-generated REST API, authentication, and the WhatsApp webhook logic via Edge Functions. The web dashboard is built with Angular and communicates directly with Supabase.

The solution is designed to be **100% free to operate** with no custom backend servers to build, host, or maintain.

---

## 2. Objectives

- Allow users to register financial transactions via WhatsApp messages using a simple format
- Use Supabase as the sole backend — database, API, auth, and webhook in one platform
- Eliminate the need for any custom-built or separately hosted backend service
- Provide a visual web dashboard with charts, filters, and summaries
- Keep operational costs at zero using free-tier services

---

## 3. System Architecture

The entire backend runs inside Supabase. The only external pieces are the Meta WhatsApp Cloud API (messaging layer) and the Angular app (frontend).

|Component|Technology|Responsibility|
|---|---|---|
|WhatsApp Webhook|Supabase Edge Function (TypeScript)|Receives Meta webhook, parses message, writes to DB, sends reply|
|Database|Supabase (PostgreSQL)|Stores users, transactions, and categories|
|REST API|Supabase auto-generated API|Queried directly by Angular — no custom endpoints needed|
|Auth|Supabase Auth|User authentication for the web dashboard|
|Web Dashboard|Angular 17+|Visualizes financial data with charts and transaction tables|

### 3.1 Data Flow

1. User sends a WhatsApp message (e.g., `gasto 500 comida almuerzo`)
2. Meta Cloud API forwards the message as a POST to the Supabase Edge Function URL
3. The Edge Function parses the message with regex (amount, type, category, description)
4. The Edge Function inserts the transaction into the Supabase database
5. The Edge Function calls the Meta API to send a confirmation reply to the user
6. The Angular dashboard reads data directly from Supabase and renders it visually

### 3.2 Project Structure

```
/FinanceTracker
  /supabase
    /functions
      /whatsapp-webhook
        index.ts              ← Edge Function: parse message + write to DB + reply
    /migrations
      001_initial_schema.sql  ← Tables, views, RLS policies
  /FinanceTracker.Angular     ← Angular app
    /src/app
      /dashboard              ← Overview page
      /transactions           ← Transaction table
      /charts                 ← Charts & graphs
      /core
        supabase.service.ts   ← Supabase JS client wrapper
```

---

## 4. Database Design

The schema is defined in Supabase via SQL migrations. Tables, views, and RLS policies are all configured once in the Supabase dashboard or CLI.

|Table|Key Columns|Description|
|---|---|---|
|`users`|id, phone_number, name, created_at|Registered WhatsApp users|
|`categories`|id, name, type (income/expense)|Transaction categories (food, rent, salary…)|
|`transactions`|id, user_id, category_id, amount, type, description, date|Individual financial entries|

**Supabase extras used:**

- **Row Level Security (RLS)** — each user only sees their own transactions
- **Database Views** — pre-aggregated monthly summaries queried directly by Angular
- **Automatic backups** — included on all Supabase plans

---

## 5. Supabase Edge Function

The WhatsApp webhook is a single TypeScript file deployed to Supabase. It replaces what would otherwise be an entire separately hosted backend service.

**Responsibilities of the Edge Function:**

|Step|Action|
|---|---|
|1. Verify request|Validate the Meta webhook signature|
|2. Parse message|Extract amount, type, category, description using regex|
|3. Resolve user|Look up or register the sender's phone number in `users`|
|4. Insert transaction|Write the parsed data to the `transactions` table|
|5. Reply|Call the Meta Cloud API to send a confirmation message|
|6. Handle commands|Respond to `ayuda`, `resumen`, `categorias` helper commands|

**Deployed via Supabase CLI:**

```bash
supabase functions deploy whatsapp-webhook
```

The function gets a public HTTPS URL automatically. This URL is registered as the webhook endpoint in the Meta Developer Portal.

---

## 6. Message Parsing Strategy

Users send messages in a defined structured format, parsed entirely with regex inside the Edge Function.

**Format:** `<keyword> <amount> <category> <description>`

|Keyword|Type|Example|
|---|---|---|
|`gasto` / `gaste`|Expense|`gasto 500 comida almuerzo`|
|`ingreso` / `cobré`|Income|`ingreso 80000 sueldo`|

**Examples:**

- `gasto 500 comida almuerzo` → expense $500, category: food, description: lunch
- `ingreso 80000 sueldo` → income $80,000, category: salary
- `gasto 1200 transporte uber` → expense $1,200, category: transport

**Helper commands:**

- `ayuda` — shows the accepted message format
- `resumen` — returns the current month's balance
- `categorias` — lists available categories

If a message doesn't match the expected format, the bot replies with a usage hint.

---

## 7. Supabase API & Angular Integration

Angular communicates directly with Supabase using the official `@supabase/supabase-js` client — no custom API layer in between.

|Operation|How|
|---|---|
|Query transactions|`supabase.from('transactions').select()` with filters|
|Monthly summary|Query a pre-built Supabase database **view**|
|Auth (dashboard login)|Supabase Auth built-in (email/password)|
|Real-time updates|Supabase Realtime subscriptions (optional)|

---

## 8. Angular Dashboard

The web dashboard will include the following views:

|View|Features|
|---|---|
|Overview|Monthly balance, income vs expenses card, recent transactions|
|Charts|Donut chart by category, monthly trend bar chart, daily spending line chart|
|Transactions|Filterable/sortable table, search, date range picker, CSV export|
|Categories|Category management, spending limits per category|

---

## 9. Technology Stack

|Layer|Technology|
|---|---|
|Webhook|Supabase Edge Function (TypeScript / Deno)|
|Database|Supabase (PostgreSQL)|
|REST API|Supabase auto-generated|
|Auth|Supabase Auth|
|Frontend|Angular 17+|
|Supabase JS Client|@supabase/supabase-js|
|Charts|Chart.js via ng2-charts|
|WhatsApp|Meta WhatsApp Cloud API (v19.0)|
|Local dev tunneling|ngrok (for webhook testing only)|

---

## 10. Development Phases

|Phase|Name|Deliverables|Est. Duration|
|---|---|---|---|
|1|Supabase Setup|Create project, define schema, configure RLS and views|2–3 days|
|2|Edge Function|Webhook receiver, regex parser, DB insert, WhatsApp reply|1 week|
|3|Angular Dashboard|Project scaffold, Supabase client, charts, transaction table|1–2 weeks|
|4|Polish & Deploy|Auth, error handling, deploy Angular to Vercel|1 week|

---

## 11. Cost Analysis

|Service|Free Tier|Cost|
|---|---|---|
|Meta WhatsApp Cloud API|1,000 conversations/month|$0|
|Supabase|500MB DB, 2GB bandwidth, Edge Functions included|$0|
|Angular App (Vercel)|Unlimited static hosting|$0|
|**Total**||**$0/month**|

---

## 12. Risks & Mitigations

|Risk|Mitigation|
|---|---|
|Meta API setup complexity|Follow official quickstart; use ngrok locally to expose Edge Function during dev|
|Edge Function cold starts|Acceptable for a personal bot; cold starts are only a few hundred ms|
|Message parsing errors|Reply with usage hint if format doesn't match; log unrecognized messages|
|Supabase free tier limits|500MB DB is ample for personal use; monitor via Supabase dashboard|

---

## 13. Recommended Next Steps

- [ ] Create Supabase project and define schema (tables, views, RLS policies)
- [ ] Create Meta Developer account and configure WhatsApp Cloud API app
- [ ] Write and test the Edge Function locally using the Supabase CLI
- [ ] Use ngrok to expose the local Edge Function and register it as the Meta webhook
- [ ] Deploy Edge Function to Supabase (`supabase functions deploy`)
- [ ] Scaffold Angular project and connect via `@supabase/supabase-js`
- [ ] Deploy Angular app to Vercel

---

_FinanceTracker — Project Proposal v2.0 — May 2026_