# AI Work Log Template

Simple, zero-dependency Markdown system to track decisions, outputs, experiments, failures, and context across **any** AI tools.

Goal: Full process awareness — recall what happened, data generated, and decisions made, pasteable into new chats whenever/wherever.

## Quick Start
1. Run `./setup.sh "Your-Log-Name"` to create a new log file and config
2. Paste the full content of `INSTRUCTION-TEMPLATE.md` as your **first message** in any new AI chat (Claude, Gemini, Grok, etc.)
3. When resuming a session: run `./continue_last.sh` to get the most recent entry, or use `./start_conversation.sh` for a fresh conversation with context

## Features
- Reverse-chronological append-only format
- Unique IDs (YYYYMMDD-tag) for easy referencing
- Hashtags: #decision #data #failure #insight #task
- Built-in weekly/monthly summary workflow
- 100% plain text → git sync, offline, no lock-in
- Auto-detects log files with smart config management
- Works with symlinks (scripts resolve to actual location)

## Scripts
- `setup.sh "Log-Name"` — Create new log file and set as default in config
- `add_log.sh` — Interactively add new dated entry to your log
- `continue_last.sh` — Show most recent entry (for resuming work)
- `start_conversation.sh` — Generate full context paste for new AI conversations
- `find.sh "keyword"` — Search your log by date, ID, hashtag, or text

## Configuration
After running `setup.sh`, a `config` file is created with your default log. You can:
- Edit `config` to change `DEFAULT_LOG` to a different file
- Copy `config.example` to `config` and customize manually
- Run `setup.sh` again to create a new log and update the config

If you have multiple log files, scripts will auto-select the default or prompt you to choose.

## Example Usage
See `examples/` folder for filled sample entries.

Fork this repo, customize, and start logging your AI-powered projects!
