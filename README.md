# Bash 12 – Health Monitor

## Problem Statement

It can be difficult to know when a computer is running low on disk space or memory. This project helps monitor important system resources.

## Project Goal

To create a Bash script that checks disk usage, memory usage, and system load, then reports whether everything is OK or needs attention.

## Tech Stack

- Bash
- Linux (Ubuntu)
- ShellCheck
- Git and GitHub

## Features

- Checks disk usage.
- Checks memory usage.
- Checks system load per CPU core.
- Displays OK or WARN messages.
- Saves results in a log file.
- Supports quiet mode.
- Allows custom warning limits.
- Supports automatic checks using cron.

## Installation and Setup

### 1. Clone the Repository

```bash
git clone https://github.com/Fokeng126/bash-12-health-monitor.git
cd bash-12-health-monitor
```

### 2. Make the Script Executable

```bash
chmod +x health.sh
```

### 3. Create the Health Command

Create the local bin directory if it does not exist:

```bash
mkdir -p ~/.local/bin
```

Create a symbolic link so the health command can be used from anywhere:

```bash
ln -sfn "$PWD/health.sh" "$HOME/.local/bin/health"
```

### 4. Add the Local Bin Directory to PATH

Add the following line to `~/.bashrc` only if it is not already present:

```bash
grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

Reload the Bash configuration:

```bash
source ~/.bashrc
```

You can now run the health command from any directory.

### 5. Run the Health Monitor

Run a normal health check:

```bash
health
```

Run in quiet mode:

```bash
health --quiet
```

### 6. Automatic Monitoring with Cron

Open your crontab:

```bash
crontab -e
```

Add the following line to run the health monitor every 15 minutes:

```cron
*/15 * * * * /home/your-username/.local/bin/health --quiet
```

Replace `your-username` with your Linux username.

The script automatically saves the monitoring results in:

```text
~/logs/health.log
```

## Challenges Faced

- Understanding how to check system resources using Linux commands.
- Working with environment variables.
- Setting up logging and quiet mode.
- Fixing YAML formatting issues.
- Configuring symbolic links and cron jobs.

## What I Learnt

- How to use Bash functions and variables.
- How to check disk, memory, and CPU load.
- How to handle warnings and exit codes.
- How to save system reports in log files.
- How to automate tasks using cron.
- How to configure PATH and symbolic links.

## Author

**Joshua Kroos**
