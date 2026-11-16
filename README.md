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

## Screenshot

Add a screenshot of your health monitor running in the terminal here.

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

Clone the repository:

```bash
git clone https://github.com/YOUR-USERNAME/bash-12-health-monitor.git
cd bash-12-health-monitor
```

Make the script executable:

```bash
chmod +x health.sh
```

Run the health monitor:

```bash
./health.sh
```

Run in quiet mode:

```bash
./health.sh --quiet
```

### Automatic Monitoring with Cron

Add this line to your crontab to run the monitor every 15 minutes:

```cron
*/15 * * * * /home/YOUR-USERNAME/.local/bin/health --quiet
```

Replace `YOUR-USERNAME` with your Linux username.

## Challenges Faced

- Understanding how to check system resources using Linux commands.
- Working with environment variables.
- Setting up logging and quiet mode.
- Fixing YAML formatting issues.

## What I Learnt

- How to use Bash functions and variables.
- How to check disk, memory, and CPU load.
- How to handle warnings and exit codes.
- How to save system reports in log files.
- How to automate tasks using cron.

## Author

**Joshua Kroos**