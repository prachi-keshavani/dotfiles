---
name: herdr
description: Control herdr from inside it. Manage workspaces and tabs, split panes, spawn agents, read output, and wait for state changes — all via CLI commands that talk to the running herdr instance over a local unix socket. Use when running inside herdr (HERDR_ENV=1).
---

## herdr — agent skill

before using this skill, check that `HERDR_ENV=1`. if it is not set to `1`, say you are not running inside a herdr-managed pane and stop. do not inspect or control the focused herdr pane from outside herdr.

you are running inside herdr, a terminal-native agent multiplexer. herdr gives you workspaces, tabs, and panes — each pane is a real terminal with its own shell, agent, server, or log stream — and you can control all of it from the cli.

this means you can:

*   see what other panes and agents are doing
*   create tabs for separate subcontexts inside one workspace
*   split panes and run commands in them
*   start servers, watch logs, and run tests in sibling panes
*   wait for specific output before continuing
*   wait for another agent to finish
*   spawn more agent instances

the `herdr` binary is available in your PATH. its workspace, tab, pane, and wait commands talk to the running herdr instance over a local unix socket.

if you need the raw protocol or full api reference, read the [socket api docs](https://herdr.dev/docs/socket-api/).

## orchestration policy

when you need to run a shell command, start a dev server, run tests, tail logs, or do anything that produces terminal output — **do not ask the user to run it for you**. instead, create a tab or split a pane and run the command there via `herdr pane run`. then read the output with `herdr pane read` or wait for completion with `herdr wait output`.

this keeps your own pane clean for reasoning and conversation while the work happens in a dedicated terminal.

### when to orchestrate vs. when to ask

| situation | action |
|-----------|--------|
| run tests, lint, build, format | **orchestrate** — create a pane, run it, read results |
| start a dev server, watcher, tunnel | **orchestrate** — create a tab, run it, wait for "ready", report the url/port |
| tail logs, run long commands | **orchestrate** — create a pane, run it, read recent output |
| run a one-off command with no interesting output | **orchestrate** — quick split, run, read, close |
| sudo that needs a password | **ask** — create a tab, run it, wait for password prompt, tell user to switch tab and type it (see sudo recipe below) |
| command that needs user interaction (e.g. `git rebase -i`, `vim`) | **ask** — do not run interactive tools in a background pane |
| command where the user explicitly said "run this in my terminal" | **ask** — respect their intent |

### naming conventions for orchestrated panes and tabs

use descriptive labels so the user can identify what is running in the sidebar:

- dev servers: `--label "server"` or `--label "vite"`
- tests: `--label "tests"` or `--label "pytest"`
- logs: `--label "logs"`
- build: `--label "build"`
- sudo tasks: `--label "sudo-task"`

### cleanup policy

- **leave running** — dev servers, watchers, tunnels, log tails. these are long-lived and the user may want to keep them.
- **close when done** — one-off commands like tests, builds, lint. close the pane or tab after reading the result to avoid clutter.
- **close on failure** — if a command fails and the user has seen the error, offer to close the pane.

### the standard orchestration pattern

this is the default flow for almost every command you need to run:

```
# 1. create a dedicated tab (or split a pane)
NEW_PANE=$(herdr tab create --workspace <current_ws> --label "<descriptive-name>" | python3 -c 'import sys,json; print(json.load(sys.stdin)["result"]["root_pane"]["pane_id"])')

# 2. run the command with a completion marker if needed
herdr pane run "$NEW_PANE" "<command>; echo 'HERDR_DONE'"

# 3. wait for output indicating success or completion
herdr wait output "$NEW_PANE" --match "<success-pattern>" --timeout <ms>

# 4. read the result
herdr pane read "$NEW_PANE" --source recent --lines 40

# 5. close if it was a one-off
herdr tab close $(herdr pane get "$NEW_PANE" | python3 -c 'import sys,json; print(json.load(sys.stdin)["result"]["pane"]["tab_id"])')
```

use `--no-focus` on splits so the user stays in your pane while work happens elsewhere.

## concepts

**workspaces** are project contexts. each workspace has one or more tabs. unless manually renamed, a workspace's label follows the first tab's root pane — usually the repo name, otherwise the root pane's current folder name.

**tabs** are subcontexts inside a workspace. each tab has one or more panes.

**panes** are terminal splits inside a tab. each pane runs its own process — a shell, an agent, a server, anything.

**agent status** is detected automatically by herdr. the api exposes one public field for it:

*   `agent_status` — `idle`, `working`, `blocked`, `done`, `unknown`

`done` means the agent finished, but you have not looked at that finished pane yet.

plain shells still exist as panes, but herdr's sidebar agent section intentionally focuses on detected agents rather than listing every shell.

**ids** — workspace ids look like `1`, `2`. tab ids look like `1:1`, `1:2`, `2:1`. pane ids look like `1-1`, `1-2`, `2-1`. these are compact public ids for the current live session.

important: ids can compact when tabs, panes, or workspaces are closed. do not treat them as durable ids. re-read ids from `workspace list`, `tab list`, `pane list`, or create/split responses when you need a current id. do not guess that an older `1-3` is still the same pane later.

## discover yourself

see what panes exist and which one is focused:

herdr pane list

the focused pane is yours. other panes are your neighbors.

list workspaces:

herdr workspace list

## tab management

list tabs in the current workspace:

herdr tab list --workspace 1

create a new tab:

herdr tab create --workspace 1

without `--label`, the new tab keeps the default numbered tab name.

create and name it in one step:

herdr tab create --workspace 1 --label "logs"

rename it:

herdr tab rename 1:2 "logs"

focus it:

herdr tab focus 1:2

close it:

herdr tab close 1:2

## read another pane

see what is on another pane's screen:

herdr pane read 1-1 --source recent --lines 50

*   `--source visible` = current viewport
*   `--source recent` = recent scrollback as rendered in the pane
*   `--source recent-unwrapped` = recent terminal text with soft wraps joined back together

## split a pane and run a command

split your pane to the right and keep focus on your current pane:

herdr pane split 1-2 --direction right --no-focus

that prints json with the new pane nested at `result.pane.pane_id`. parse that value, then run a command in that pane:

NEW_PANE=$(herdr pane split 1-2 --direction right --no-focus | python3 -c 'import sys,json; print(json.load(sys.stdin)["result"]["pane"]["pane_id"])')
herdr pane run "$NEW_PANE" "npm run dev"

split downward instead:

herdr pane split 1-2 --direction down --no-focus

## wait for output

block until specific text appears in a pane. useful for waiting on servers, builds, and tests.

for `--source recent`, matching uses unwrapped recent terminal text, so pane width and soft wrapping do not break matches. `pane read --source recent` still shows the pane as rendered. if you want to inspect the same transcript that the waiter matches, use `pane read --source recent-unwrapped`.

herdr wait output 1-3 --match "ready on port 3000" --timeout 30000

with regex:

herdr wait output 1-3 --match "server.*ready" --regex --timeout 30000

if it times out, exit code is `1`.

## wait for an agent status

block until another agent reaches a specific status:

herdr wait agent-status 1-1 --status done --timeout 60000

use this when you want the same `done` / `idle` distinction the UI shows.

## send text or keys to a pane

send text without pressing Enter:

herdr pane send-text 1-1 "hello from claude"

press Enter or other keys:

herdr pane send-keys 1-1 Enter

`pane run` sends the text and then a real `Enter` key in one request:

herdr pane run 1-1 "echo hello"

## workspace management

create a new workspace:

herdr workspace create --cwd /path/to/project

without `--label`, the new workspace keeps the default cwd-based name.

create and name one in one step:

herdr workspace create --cwd /path/to/project --label "api server"

create one without focusing it:

herdr workspace create --no-focus

focus a workspace:

herdr workspace focus 2

rename:

herdr workspace rename 1 "api server"

close:

herdr workspace close 2

## close a pane

herdr pane close 1-3

## recipes

### run a one-off command and report results

use this for tests, builds, lint, or any command that finishes and produces output.

CURRENT_WS=$(herdr workspace list | python3 -c 'import sys,json; print(next(w["workspace_id"] for w in json.load(sys.stdin)["result"]["workspaces"] if w["focused"]))')
NEW_PANE=$(herdr tab create --workspace "$CURRENT_WS" --label "pytest" | python3 -c 'import sys,json; print(json.load(sys.stdin)["result"]["root_pane"]["pane_id"])')
herdr pane run "$NEW_PANE" "pytest -xvs; echo 'HERDR_DONE'"
herdr wait output "$NEW_PANE" --match "HERDR_DONE" --timeout 120000
herdr pane read "$NEW_PANE" --source recent --lines 50
herdr tab close $(herdr pane get "$NEW_PANE" | python3 -c 'import sys,json; print(json.load(sys.stdin)["result"]["pane"]["tab_id"])')

### run a server and wait until it is ready

CURRENT_WS=$(herdr workspace list | python3 -c 'import sys,json; print(next(w["workspace_id"] for w in json.load(sys.stdin)["result"]["workspaces"] if w["focused"]))')
NEW_PANE=$(herdr tab create --workspace "$CURRENT_WS" --label "server" | python3 -c 'import sys,json; print(json.load(sys.stdin)["result"]["root_pane"]["pane_id"])')
herdr pane run "$NEW_PANE" "npm run dev"
herdr wait output "$NEW_PANE" --match "ready" --timeout 30000
herdr pane read "$NEW_PANE" --source recent --lines 20

# leave the server tab running — do not close it

### run a sudo command with human-in-the-loop

use this when you need sudo in a pane but do not want the password to flow through pi. the user types the password directly into the target pane.

# 1. create a dedicated tab
NEW_PANE=$(herdr tab create --workspace 1 --label "sudo-task" | python3 -c 'import sys,json; print(json.load(sys.stdin)["result"]["root_pane"]["pane_id"])')

# 2. run the sudo command with a completion marker
herdr pane run "$NEW_PANE" "sudo apt update; echo 'HERDR_SUDO_DONE'"

# 3. wait for password prompt (short timeout to detect if sudo needs auth)
herdr wait output "$NEW_PANE" --match "password for" --timeout 8000

# if the wait succeeds, tell the user to switch to the 'sudo-task' tab and enter their password.
# if the wait times out, sudo may be cached — skip the prompt and wait for completion directly.

# 4. wait for the completion marker
herdr wait output "$NEW_PANE" --match "HERDR_SUDO_DONE" --timeout 300000

# 5. read results (exclude the marker line)
herdr pane read "$NEW_PANE" --source recent --lines 40

# 6. close the tab when done
herdr tab close $(herdr pane get "$NEW_PANE" | python3 -c 'import sys,json; print(json.load(sys.stdin)["result"]["pane"]["tab_id"])')

important notes:
- never send passwords via `herdr pane send-text` or `herdr pane run`. passwords would appear in pane logs and screen history.
- the completion marker (`HERDR_SUDO_DONE`) ensures pi can reliably detect command completion regardless of what the sudo command outputs.
- if the first `wait output` times out, assume cached sudo credentials and proceed to wait for the marker.
- if the second `wait output` times out, the command may have hung or the user has not entered the password yet. read the pane output and report the state to the user.

### run tests in a separate pane and inspect the result

herdr pane split 1-2 --direction down --no-focus
herdr pane run 1-3 "cargo test"
herdr wait output 1-3 --match "test result" --timeout 60000
herdr pane read 1-3 --source recent --lines 30

### check what another agent is working on

herdr pane list
herdr pane read 1-1 --source recent --lines 80

### watch another pane robustly

use this pattern when you need to coordinate with a sibling pane:

# inspect what is already there
herdr pane read 1-3 --source recent --lines 40

# wait only for the next output you expect
herdr wait output 1-3 --match "ready" --timeout 30000

# if you need to inspect the same transcript the waiter matched,
# read the unwrapped recent text directly
herdr pane read 1-3 --source recent-unwrapped --lines 40

### spawn a new agent and give it a task

herdr pane split 1-2 --direction right --no-focus
herdr pane run 1-3 "claude"
herdr wait output 1-3 --match ">" --timeout 15000
herdr pane run 1-3 "review the test coverage in src/api/"

### coordinate with another agent

herdr wait agent-status 1-1 --status done --timeout 120000
herdr pane read 1-1 --source recent --lines 100

## notes

*   `workspace list`, `workspace create`, `tab list`, `tab create`, `tab get`, `tab focus`, `tab rename`, `tab close`, `pane list`, `pane get`, `pane split`, `wait output`, and `wait agent-status` print json on success.
*   `pane read` prints text, not json.
*   `pane read --format ansi` or `pane read --ansi` returns a rendered ANSI snapshot for TUI feedback loops.
*   `pane read --source recent-unwrapped` is useful when you want to inspect the same unwrapped transcript that `wait output --source recent` matches against.
*   `pane send-text`, `pane send-keys`, and `pane run` print nothing on success.
*   parse ids from `workspace create`, `tab create`, and `pane split` responses when you need new ids. `workspace create` returns `result.workspace`, `result.tab`, and `result.root_pane`. `tab create` returns `result.tab` and `result.root_pane`. for `pane split`, the new pane id is at `result.pane.pane_id`.
*   use `pane read` for current output that already exists. use `wait output` for future output you expect next.
*   `--no-focus` on split, tab create, and workspace create keeps your current terminal context focused.
*   without `--label`, workspace create keeps cwd-based naming and tab create keeps numbered naming.
*   `--label` on tab create and workspace create applies the custom name immediately.
*   if you are running inside herdr, the `HERDR_ENV` environment variable is set to `1`.
