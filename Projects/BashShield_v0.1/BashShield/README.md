# BashShield

BashShield is a modular Bash-based Linux security audit and incident-response toolkit.

## Requirements

- Linux / WSL recommended
- Bash 4+
- Standard Linux utilities such as `ps`, `ss`, `awk`, `grep`, `find`, and `sha256sum`

> Git Bash on Windows is useful for learning Bash, but many Linux security files and commands do not exist there. Use WSL or a Linux VM for the full project.

## Quick Start

```bash
chmod +x bashshield.sh
./bashshield.sh help
./bashshield.sh scan
```

## Modules

- System audit
- User/account audit
- Process analysis
- Network audit
- Authentication log analysis
- Persistence checks
- File integrity monitoring
- IOC filename/path scanning
- Risk scoring

## Project Philosophy

BashShield is a defensive auditing tool. It reports findings for analyst investigation rather than automatically deleting files, killing processes, changing accounts, or blocking network traffic.
