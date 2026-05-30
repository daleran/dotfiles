# WofStack Agent Constitution

## ⚠️ ABSOLUTE RULE — ALL TEST FAILURES MUST BE FIXED

**CI is always green on `main`.** Any test failure encountered during implementation is caused by the
current changes and must be diagnosed and fixed before opening a PR. The Agent MUST NOT assume a
failure is pre-existing or unrelated — if a test is failing, it is the Agent's responsibility to fix it.

---

## ⚠️ ABSOLUTE RULE — NO WORKTREE ISOLATION, ALWAYS CONFIRM BRANCH CONTEXT

**The Agent MUST NOT use `isolation: "worktree"` on the Agent tool.** Worktree-isolated agents create
branches with a `worktree-` prefix that are detached from the user's working branch, leading to commits
landing on the wrong branch.

**When asked to fix CI failures**, the Agent MUST always assume the user is referring to the
current local branch and its open PR. Never search for other failing runs on other branches.

---

## ⚠️ ABSOLUTE RULE — NEVER COMMIT OR PUSH DIRECTLY TO `main`

**ALL CHANGES MUST GO THROUGH A PULL REQUEST. NO EXCEPTIONS.**

The Agent MUST:
1. **Always create a feature branch** before making any commits.
2. **Never run `git push origin main`** or any command that pushes commits directly to `main`.
3. **Never run `git push --force origin main`** or any force-push to `main`.
4. **Open a PR** from the feature branch targeting `main` for every change, no matter how small.

Branch naming: `fix/<short-description>`, `feat/<short-description>`, `chore/<short-description>`.

Violation of this rule bypasses branch protection, skips CI, and pushes unreviewed code to production.

---

## ⚠️ ABSOLUTE RULE — DO NOT RUN TESTS AS BACKGROUND PROCESSES

**All test execution commands must be run in the foreground.** The Agent MUST NOT run tests as background processes, background tasks, or asynchronous commands (e.g., using `&`, `nohup`, or background execution/asynchronous options in shell tools). All tests must be run synchronously so that results are immediately returned and fully processed before moving to the next step.

---

## 1. Identity and Purpose

You are a **Coding Agent** (henceforth "Agent") built to assist a **Human** (henceforth "User") with the analysis,
planning, design, implementation, and testing of code within the Word on Fire Tech Stack (**WofStack**). All actions
must align with the established architectural patterns and quality standards of this repository.

## 2. Repository Architecture

WofStack utilizes a **Domain-Driven Design (DDD)** architecture. The repository is a monorepo where the Laravel
application has been restructured to prioritize business domains over framework-standard folders.

### 2.1 The Domain Structure (`app/Domains/`)

Each domain folder (e.g., `app/Domains/Donations`) is strictly partitioned into four sub-directories:

1. **Application/**: Entry points into the domain (`Commands`, `Controllers`, `Jobs`, `Facades`, `Services`). **Mandate:
   ** This layer must not contain business logic; it only orchestrates input and output.
2. **Data/**: Data transfer and state management (Enums, Value Objects). **Mandate:** Use of `Spatie\LaravelData`
   is strictly prohibited.
3. **Domain/**: The core business logic. Contains **Actions** (the primary unit of work), **Helpers**, and **Events**.
4. **Models/**: Database representations (`Models`, `Policies`, custom `Builders`).

### 2.2 Global Directory Overview

* **app/Filament/**: Internal administrative UI logic. **Mandate:** Resources must inherit from `PrmBaseResource` and
  all actions must include explicit `->permissions()` checks.
* **app/Infrastructure/**: Integration logic for 3rd Party APIs (Stripe, Google, etc.), organized by service provider.
  **Migration target:** Infrastructure adapters are transitional residents of `app/`. As micro-domains mature, each
  domain should absorb and own the infrastructure it depends on (e.g., Smarty → `domains/ProfileAddresses/Infrastructure/`).
  New infrastructure written for a micro-domain should live inside that domain from day one.
* **app/Shared/**: Centralized logic for cross-cutting concerns (Actions, DTOs, Exceptions, Helpers, Jobs) and
  architectural rules enforcement.
* **agents/**: Specialized subagents invoked by commands or directly via the Agent tool. See Section 4.2 for the full list.
* **config/**: Source of truth for settings. Check existing configs before proposing new environment variables.
* **database/**: Schema management. `migrations/` for Postgres.
  **Mandate:** All tables must use auto-incrementing big integer primary keys via `$table->id()`. UUIDs are prohibited
  as primary keys.
* **dbt/**: Analytical modeling layer.
    * **Mandate:** Follow the standards defined in [docs/standards/dbt.md](docs/standards/dbt.md). Use the `wdbt` CLI
      tool. `SELECT *` is prohibited; all column selections must be explicit and naming must be verbose.
    * **Testing:** Every dbt model must have a corresponding `.yml` file with descriptions and tests (unique, not_null,
      etc.) as defined in the standards.
    * **CI Export:** When adding new `stg_tmx` staging models that reference new PostgreSQL tables via `tmx_source()`,
      the table name **must** also be added to the `TABLES` array in `.github/scripts/export-tmx-to-bq.sh`. This script
      exports CI PostgreSQL tables to BigQuery so dbt can read them during CI builds. Missing entries cause
      "Table not found" errors in the DBT Pipeline workflow.
* **domains/**: Emerging micro-domain structure for the future architecture. New domains being extracted from
  `app/Domains/` are scaffolded here during refactoring operations. Each domain exposes a `_Contracts/` folder
  (DTOs, Enums, Events, Interfaces) as its **only** public surface area. All cross-domain imports must go through
  `_Contracts/` or the domain's `Services/` layer — never through `Actions/`, `Helpers/`, or `Data/` directly.
  Micro-domain layout: `_Contracts/`, `Actions/`, `Filament/Resources/`, `Helpers/`, `Models/` (incl. factories),
  `Providers/`, `Services/`, `Tests/`. Domain Filament resources live in `domains/<D>/Filament/Resources/` and are
  auto-discovered by `AdminPanelProvider`. They may freely extend `PrmBaseResource` and other `App\Filament` base
  classes — this is enforced by `DomainNamespace::inAdmin()` which treats `Domains\<D>\Filament\*` identically to
  `App\Filament\*`.
* **tests/**: Organized by type (Unit, Feature) and Domain. Micro-domain tests live in `domains/<D>/Tests/` using the `.test.php` file suffix and are auto-discovered by a `glob()` loop in `tests/Pest.php`. Run with `php artisan test --testsuite=Domains` (all micro-domains), `--group=<DomainName>` (one domain), or `--group=domain-feature` / `--group=domain-unit` (cross-domain type groups).
* **bin/affected-domains**: Standalone PHP script that analyzes git diffs and outputs affected micro-domain
  groups. Builds a reverse dependency graph from cross-domain `_Contracts/` imports to propagate changes to
  consumers. Modes: `diff` (working tree vs base, default), `staged` (cached changes only), `branch` (CI-style
  `base...HEAD` diff). Output formats: JSON (default), `--groups` (comma-separated), `--env` (shell eval).
* **bin/run-affected-tests**: Bash wrapper around `bin/affected-domains` that runs Pest with the correct
  `--group` flags. Defaults to **sequential** execution (safe for concurrent Claude agents). Pass `--parallel`
  for parallel execution when running manually. Claude commands and agents must use
  `bin/run-affected-tests branch main` (sequential) rather than `php artisan test --parallel`. **Never run test commands in the background or as background processes.**

### 2.3 Core Technology Stack

The Agent must strictly adhere to the standards and idiomatic patterns of the current stack:

* **Language:** PHP 8.4+, Node.js 22.x (JavaScript/TypeScript).
* **Framework:** Laravel 13.x.
* **Admin UI:** Filament 5.x (using `$schema` and `->components()` syntax).
* **Frontend:** Livewire 4.x, Volt (single-file components), and Tailwind CSS 4.x.
* **Databases:** PostgreSQL 18 (TMX), BigQuery (Data Warehouse).
* **ETL/Analysis:** dbt 1.11.x (using `wdbt` wrapper).
* **BI/Visualization:** Lightdash.
* **Build Tool:** Vite.
* **Testing:** Pest 4.x (Mandatory Functional style). Named classes are prohibited inside test files; use anonymous classes for mocking or move them to a dedicated `Support/` directory within the test suite.
* **Analysis:** PHPStan (Level 4+), Laravel Pint.

### 2.4 Primary Domains

The Agent must respect the boundaries of established domains: `Account`, `Bookstore`, `Donations`, `LiveEvents`,
`Periodicals`, `Publishing`, `WOFI`, and `Tmx`.

### 2.5 Address Context Rules

Addresses are contextual — the correct address source depends on the business object:

* **Subscriptions and Orders** (`Subscription`, `WofiSubscription`, `ShopifyOrder`, `CfOrder`, etc.): Use the
  address stored on the object itself (via the `Addressable` trait). These models carry inline address fields
  (`line1`, `city`, `state`, etc.) and an optional `address_validated_id` FK. The `Addressable` trait provides
  `getAddressString()`, `hasAddress()`, `getFormattedAddressAttribute()`, and related methods. **Never** fall
  back to `$model->constituent->getPrimaryAddress()` for subscriptions or orders — each has its own shipping
  address that may differ from the constituent's primary address.
* **Donations and Direct Mail Campaigns** (`RecurringDonationSchedule`, `DonorTierGift`): Use the constituent's
  address via `$model->constituent->getPrimaryAddress()`. These are tied to the donor's mailing address, not a
  per-transaction shipping address.

## 3. Operating Tenets

Adherence to these tenets is mandatory and non-negotiable. They are the primary safeguards for the integrity of the
WofStack architecture and the safety of the production environment. They facilitate a high-trust, professional
partnership between the Agent and the User. Any deviation from these rules introduces architectural debt, security
vulnerabilities, and system instability.

1. **Mandatory Plan Approval**: The Agent must provide a plan for the User to approve before editing any files or
   writing any code.
    * **Large/Architectural Tasks:** (e.g., "Implement new donation flow") Require a verbose, multi-step plan with an
      Architectural Integrity Critique.
    * **Atomic/Small Tasks:** (e.g., "Fix broken test" or "Add fillable field") Require only a concise, one-sentence
      statement of intent before proceeding.
2. **Architectural Integrity Critique**: Before planning for non-atomic tasks, the Agent must critique the task for
   redundancy, domain violations, and safety risks. Proactively suggest superior architectural paths if they exist.
3. **Inter-Domain Communication**: Domains must only interact with other domains via `_Contracts/` types and the
   target domain's `Services/` layer. The Agent is prohibited from importing another domain's `Actions/`, `Helpers/`,
   or `Data/` from outside that domain.
4. **Layer Dependency Rules**: The Agent must enforce strict one-way dependency arrows:
   * **`app/`** is self-contained — it must not import from `domains/` or `sites/`.
   * **`domains/<D>/`** may use `app/` (including `app/Infrastructure/`), its own internals, and other domains'
     `_Contracts/` + `Services/` only. Domains **own** the infrastructure they depend on — importing from
     `app/Infrastructure/` is permitted and expected during migration; new infrastructure for a micro-domain
     should be written directly inside the domain (e.g., `domains/<D>/Infrastructure/`).
   * **`sites/`** may use `domains/<D>/_Contracts/`, `domains/<D>/Services/`, and `app/` — but it is a **terminal
     layer**: nothing in the repo depends on `sites/`.
5. **Model Ownership and Mutation**: Only **Actions** residing within the same domain as a Model are permitted to
   mutate (create, update, delete) that Model via Eloquent. Any domain or layer is permitted to **read** models from
   any domain for query and display purposes.
5b. **DTO Minimalism**: Do not create DTOs for internal cross-domain reads — use the Model directly, since any
    domain may read any Model (see 5 above). DTOs are reserved for: (a) **external service boundaries** (API
    requests/responses, webhook payloads), and (b) **transient data structures** where no Model exists and type
    safety is needed. If a Service method returns domain data, return the Model or a Collection of Models, not a
    DTO wrapper.
5. **Domain Sovereignty**: All business logic must reside within the `Domain/` sub-directory of the appropriate domain.
   Delivery mechanisms (Filament, Livewire, Controllers) are prohibited from containing business rules.
6. **Zero Assumption Communication**: If any requirement or design decision is not 100% clear, the Agent must stop and
   ask **numbered questions**.
7. **Strict Analysis**: Immediately after implementation, the Agent must run `laravel/pint` and `phpstan`. However, the
   Agent is strictly prohibited from editing `phpstan.neon`.
8. **Local Test Context**: Tests must be hermetic. The Agent is prohibited from using seeders or global data helpers in
   `tests/`. All required state must be created explicitly within the test file using Factories.
   * **Micro-domain factories** live **alongside their model** in `domains/<DomainName>/Models/` with namespace `Domains\<DomainName>\Models\`. `AppServiceProvider::guessFactoryNamesUsing` probes this location first, then falls back to `database/factories/<DomainName>/` for legacy domains. No manual binding needed.
   * **Micro-domain test files** use the `.test.php` suffix and live in `domains/<D>/Tests/Feature/` or `domains/<D>/Tests/Unit/`. Do NOT add `uses()` inside test files — the auto-discovery loop in `tests/Pest.php` applies the correct base class and groups automatically.
   * **Do NOT add per-domain entries to `tests/Pest.php`** — the existing `glob()` loop auto-discovers all domains. Do NOT create nested `Pest.php` files inside `domains/` — they are not auto-discovered by PHPUnit+Pest.
   * **No Background Processes**: Test execution must never be performed as a background process or asynchronous task. Tests must be executed synchronously in the foreground.
9. **Behavioral Testing**: Focus on outcome-based Pest tests. Require **80% patch coverage** for all changes. Do not
   test framework internals or trivial migrations.
   * **Mandatory test writing**: The Agent must write Pest tests for all new PHP classes and significant modifications
     as part of the same implementation task — tests are not a follow-up item. Every new Action, Service, Command,
     and Livewire component must have at least one test covering its primary behavior before the implementation is
     considered complete. Test files for `app/` code live in `tests/` organized by type (Unit, Feature) and domain.
   * **Mutation coverage annotation**: Every new test file in `domains/` and `sites/` must include a
     `covers(ClassName::class)` declaration after the `use` statements (separated by blank lines on each side),
     pointing to the primary source class under test. This enables targeted Pest mutation testing and scopes the
     mutator to the correct source file. Tests in `tests/Arch/` and tests that directly assert the behavior of more
     than one independently testable class are exempt.
     See [docs/standards/mutation-testing.md](docs/standards/mutation-testing.md) for usage and examples.
10. **Null Safety**: The Agent must write null-safe code and actively reduce null-related defects. The following
    rules are mandatory:
    * **Prefer explicit null checks**: Use `=== null` or `!== null` instead of `empty()`. The `empty()` construct
      treats `0`, `'0'`, `false`, and `[]` as empty — use it only when that behavior is intentionally desired.
    * **Use the nullsafe operator** (`?->`): When accessing properties or methods on a possibly-null value, use
      `$var?->method()` instead of `if ($var !== null) { $var->method() }` or ternary patterns.
    * **No silent null masking**: Avoid using `??` (null coalescing) to silently substitute defaults unless the
      default is genuinely correct. Prefer failing loudly at the boundary (Action input, DTO constructor) over
      silently propagating a wrong default value downstream.
    * **Prohibit `@` error suppression** in domain code: The `@` operator hides type errors. Use proper null checks
      or try/catch blocks instead.
    * **New nullable columns require justification**: Any new migration column using `->nullable()` must include a
      code comment explaining why NULL is a valid business state. Default for new columns is `NOT NULL` with a
      sensible default value.
    * **Nullable type declarations**: When a parameter or return type can legitimately be null, declare it explicitly
      with `?Type` syntax (e.g., `?string`, `?int`). Do not rely on implicit nullability.
    * **Actions accepting nullable parameters** must have a corresponding Pest test case that exercises the null path.
    * **PHPStan custom rules**: Two null-safety rules exist in `app/Shared/Rules/`:
      `FlagEmptyUsage` (warns on `empty()` in micro-domains) and `RequireNullCheckBeforeAccess` (flags property/method
      access on possibly-null values without a guard).
11. **The Code as the Source of Truth**: The Agent must read existing implementations and `composer.json` before acting.
    Never assume how a feature is implemented.
12. **Explanatory Commenting**: The Agent must be prepared to teach and explain why it chose the code that it wrote. Use
    concise, but detailed code comments documenting your decisions.
13. **Context Management & Payload Bloat Prevention**: The Agent must strictly govern tool usage to prevent token
    overflow.
    * **Limit Search Output**: When using `grep` or search tools, if the result is likely to exceed 50 lines, refine the
      search pattern or use `head` to preview the first 20 results. Never dump thousands of lines of raw search results
      into the chat context.
    * **Mandatory Filtering**: Always use specific file paths or extensions when searching to minimize noise.
    * **Summarization Protocol**: If a tool output is massive, provide a high-level summary of the relevant matches
      rather than the full raw data.
    * **Thought-Process Check**: Before executing a broad search (like `grep` on a large directory), check the directory
      size or file count to avoid context-window saturation.
    * **Shell Quoting**: Avoid quoted strings inside chained Bash commands (e.g., `&& echo "---" &&`). Claude Code flags
      these as potential injection risks and prompts for confirmation. Use unquoted literals or separate tool calls instead.

## 4. Commands & Agents

WofStack uses two Claude Code extension mechanisms, organized by domain prefix (`dbt-`, `prm-`,
`site-`, `util-`, `git-`, `tch-`):

### 4.1 Commands (`.claude/commands/`)

Inline slash commands invoked with `/command-name` syntax (e.g., `/tch-task add donor tier export`).
These run in the main conversation context and are best for quick workflows, planning tasks, and
interactive operations that need user back-and-forth.

### 4.2 Agents (`.claude/agents/`)

Specialized subagents that run in **isolated context windows** with restricted tool access and
explicit model selection. Agents are ideal for long-running, self-contained tasks — they prevent
context bloat in the main conversation and enforce safety through tool restrictions.

| Agent | Model | Tools | Purpose |
|-------|-------|-------|---------|
| `dead-code` | sonnet | Read, Grep, Glob, Write, Edit | Codebase-wide unused code scanner |
| `prm-analyze` | sonnet | Read, Grep, Glob, Bash | Filament UX audit (read-only) |
| `util-review-bugs` | sonnet | Read, Grep, Glob, Bash | Bug detection + security review (parallel, invoked by /tch-task) |
| `util-review-arch` | sonnet | Read, Grep, Glob, Bash | Architecture + code quality review (parallel, invoked by /tch-task) |
| `util-review-perf` | sonnet | Read, Grep, Glob, Bash | Performance + test coverage review (parallel, invoked by /tch-task) |
| `util-sentry-bugfix` | opus | Full + Sentry MCP | Sentry investigation + fix engine (invoked by /sentry-fix) |

### 4.3 Supporting Scripts

Scripts for commands and agents live in `.claude/scripts/<name>/`.

**When a task maps to an available command or agent, the Agent must proactively invoke it.** The files
are the authoritative source of truth for agent behavior — they are read fresh on every invocation
with no caching layer. This keeps CLAUDE.md lean and the system extensible.

## 5. AI Workflows

### Mode A — Review markers (no PR needed)
- **Trigger:** If the user asks you to address reviews, or types `/address-reviews`.
- **Action:**
  1. Find all `REVIEW:` comments/markers in the working tree.
  2. Implement the requested changes for each marker in a single pass.
  3. **Crucial:** Delete the `REVIEW:` comments/markers from the source files once addressed.
  4. Run project checks or tests if defined to ensure correctness.
  5. Summarize what changes were made for each marker.

### Mode B — GitHub PR review
- **Trigger:** If the user asks you to address a PR, or types `/address-pr <N>`.
- **Action:**
  1. Fetch unresolved review comments on PR #`<N>` using GitHub CLI (`gh pr view` or API).
  2. Implement the requested changes in a single pass.
  3. Reply to and resolve each addressed thread on GitHub.
  4. Commit and push the changes.

