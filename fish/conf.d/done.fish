# https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 5000  # default: 5000 ms
set -U __done_exclude '^git (?!push|pull|fetch)'  # default: all git commands, except push and pull. accepts a regex.
set -U --append __done_exclude '^emacsclient'
set -U __done_notify_sound 1
# set -U __done_notification_command "your-command \$title \$message"