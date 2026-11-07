# Contributing to the Ansible Boilerplate Collection

Thank you for your interest in improving the Ansible Boilerplate Collection
(`alexbarton.boilerplate`)! Bug reports, documentation improvements and patches
are welcome.

For anything larger than a small fix, please open an issue first and describe
what you want to change and why. This avoids spending time on a change that
does not fit the project.

## Reporting Bugs

Please report bugs on GitHub:
<https://github.com/alexbarton/ansible-collection-boilerplate/issues>

A good bug report includes:

- the version of the collection
  (`ansible-galaxy collection list alexbarton.boilerplate`),
- the versions of Ansible and Python, and the operating system (macOS or Linux
  distribution and release),
- whether the virtual environment was set up with `uv` or with Python `venv`,
- the exact command you ran, its complete output, and what you expected instead,
- whether the problem occurs in this repository or in a project built upon the
  collection.

Please verify that you can reproduce the problem before reporting it.

## Reporting Security Issues

Do not open a public issue for security vulnerabilities. Send an email to
Alexander Barton <alex@barton.de> instead.

## Development Setup

[uv](https://docs.astral.sh/uv/) is required to work on this repository: there
is no `requirements.txt`, so the Python `venv` + `pip` fallback of `bin/abc`
does not work here. Install [mdl](https://github.com/markdownlint/markdownlint)
and [ShellCheck](https://www.shellcheck.net/) as well; the checks skip them with
a warning when they are not installed.

- `make` – Create/update the Python virtual environment in `.venv`.
- `make check` – Run all checks: `ansible-playbook --syntax-check`,
  `ansible-lint`, `mdl` and `shellcheck`.
- `make check-ansible`, `make check-mdl`, `make check-shellcheck` – Run a
  single group of checks.
- `make dist` – Build the collection archive into `dist/`.
- `make distcheck` – Build the archive, verify that it is smaller than 100 kB,
  and run `make check` inside the extracted archive.

There is no unit test suite: `make check` is the test gate.

## Requirements for Changes

This repository is not a regular Ansible project: it ships template files,
scripts, playbooks and Makefile fragments that *other* projects install and
build upon. Many files in the repository root are both the configuration of
this repository and templates that `abc init` and `abc update` copy into
dependent projects, so changes to them affect every one of these projects. See
[AGENTS.md](AGENTS.md) for an overview of the architecture.

- `make check` must pass. Run `make distcheck` as well when you add, remove or
  rename files.
- `bin/abc` is copied into dependent projects and must work before the
  collection is installed: it must not depend on any other file of the
  collection.
- Follow the configuration in `.editorconfig`, `.yamllint.yml`, `.ansible-lint`
  and `.mdl-rules.rb`, and the style of the surrounding code.
- Record every change that is visible to users of the collection in
  `CHANGELOG.md`.
- Don't change the version number; this is done when a release is prepared (see
  [docs/how-to-release.md](docs/how-to-release.md)).

### Shell Scripts

All scripts are Bash with `set -euo pipefail` (the only exception is `bin/aps`,
a POSIX `sh` script with `set -eu`), indented with tabs, and must pass
`shellcheck`. Functions use `Capitalized_Snake_Case` names.

The scripts run on Linux and macOS:

- They must work with Bash 3.2, the version shipped with macOS. For example,
  expanding an empty array with `"${array[@]}"` fails under `set -u` there.
- Only use command options that GNU and BSD tools have in common, e.g.
  `sed -i'.bak'` instead of `sed -i`, `wc -c` instead of `stat -c %s`. Note
  that `install -b` creates `<file>~` backups on GNU and `<file>.old` on BSD
  systems.

If possible, test your changes on both platforms.

## Commits and Pull Requests

- Keep each commit to one logical change, and each pull request focused on one
  topic.
- Subject: imperative mood, capitalized, no trailing period, ≤ 50 characters
  (72 at most).
- Blank line between subject and body; wrap the body at 72 columns.
- The body explains what changed and why, not how.

## AI-Assisted Contributions

You may use AI tools such as large language models (LLMs) and coding agents to
help with your contribution, under the following conditions:

- **You are responsible.** You must understand every line you submit, be able
  to explain why it is needed, and respond to review comments yourself. "The AI
  wrote it this way" is not an answer.
- **Disclose it.** Mark commits made with AI assistance with a trailer naming
  the model that was actually used, separated from the body by a blank line:

  ```text
  Co-authored-by: <model name> <vendor no-reply address>
  ```

  Mention significant AI assistance in the pull request description, too.
- **Test it.** Run `make check` and actually try out the changed behavior.
  Code that merely looks plausible is not enough.
- **Verify reports.** Reproduce bugs and security issues yourself before
  reporting them. Unverified, AI-generated reports will be closed without
  further discussion.
- **Keep it small.** No large generated refactorings, mass reformatting, or
  series of trivial changes across the repository.
- **Write for humans.** Keep issue and pull request texts short and to the
  point, and review them before posting. Don't paste lengthy generated text.
- **Respect licenses.** Don't submit code that the tool evidently reproduced
  from other projects.

Coding agents find additional instructions in [AGENTS.md](AGENTS.md).

## License

This collection is licensed under the MIT license, see [LICENSE](LICENSE). By
submitting a contribution, you agree that it is licensed under the same terms
and confirm that you have the right to do so.
