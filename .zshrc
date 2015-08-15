# set umask first
umask 22

# locale/encoding
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
#export LC_ALL=ja_JP.UTF-8
#export LANG=ja_JP.UTF-8

export GOPATH=$HOME/Development/go

export ANDROID_HOME=$HOME/Library/Android.SDK

export GRADLE_HOME=/usr/local/apache-maven/gradle-2.2.1
export PATH=$PATH:$GRADLE_HOME/bin

export MAVEN_HOME=/usr/local/apache-maven/apache-maven-3.2.5
export PATH=$PATH:$MAVEN_HOME/bin

export ECLIPSE_HOME=/usr/local/eclipse
export PATH=$PATH:$ECLIPSE_HOME

# go for 256 color as long as not physical console
[ `tty` != '/dev/ttyv0' ] && export TERM=xterm-256color

# timezone
export TZ=Asia/Tokyo

# location of our git repo
profiles=~/.profiles

# if local installation, uncomment this line to add zsh-git functions to fpath
# fpath+="${profiles}/zsh-git/functions"

# source other functions
source "${profiles}/functions"

## Pre Configurations {{{

# Avoid 'no matches found' error.
unsetopt nullglob

# Add PATH and MAN_PATH.
init_paths

# Initialize EDITOR.
init_editor

## }}}

## Aliases {{{

init_aliases
init_ls_colors

# Aliases using pipes, works only on Zsh.
alias -g V="| vi -v -"
alias -g G="| grep"
alias -g T="| tail"
alias -g H="| head"
alias -g L="| less -r"

## }}}

## Zsh Basic Configurations {{{

# Initialize hook functions array.
typeset -ga preexec_functions
typeset -ga precmd_functions

# Use vi key bindings.
#bindkey -v

# Use emacs key bindings.
bindkey -e

# Use colors.
autoload -Uz colors
colors

# Expand parameters in the prompt.
setopt prompt_subst

# Load wunjo prompt
autoload -U promptinit
promptinit
prompt wunjo

# Change directory if the command doesn't exist.
setopt auto_cd

# Resume the command if the command is suspended.
setopt auto_resume

# No beep.
setopt no_beep

# Enable expansion from {a-c} to a b c.
setopt brace_ccl

# Disable spell check.
unsetopt correct

# Expand =command to the path of the command.
setopt equals

# Use #, ~ and ^ as regular expression.
setopt extended_glob

# No follow control by C-s and C-q.
setopt no_flow_control

# Don't send SIGHUP to background jobs when shell exits.
unsetopt no_hup

# Disable C-d to exit shell.
unsetopt ignore_eof

# Show long list for jobs command.
setopt long_list_jobs

# Enable completion after = like --prefix=/usr...
setopt magic_equal_subst

# Append / if complete directory.
setopt mark_dirs

# Don't show the list for completions.
unsetopt no_auto_menu

# Don't show completions when using *.
setopt glob_complete

# Perform implicit tees or cats when multiple redirections are attempted.
setopt multios

# Use numeric sort instead of alphabetic sort.
setopt numeric_glob_sort

# Enable file names using 8 bits, important to rendering Japanese file names.
setopt print_eightbit

# Show exit code if exits non 0.
unsetopt print_exit_value

# Don't push multiple copies of the same directory onto the directory stack.
setopt pushd_ignore_dups

# Use single-line command line editing instead of multi-line.
unsetopt single_line_zle

# Allow comments typed on command line.
setopt interactive_comments

# Print commands and their arguments as they are executed.
unsetopt xtrace

# Show CR if the prompt doesn't end with CR.
unsetopt promptcr

# Remove any right prompt from display when accepting a command line.
setopt transient_rprompt

# Pushd by cd -[tab]
setopt auto_pushd

# Don't report the status of background and suspended jobs.
setopt no_check_jobs

# for ** and other advanced expansions
setopt extended_glob

# Enable predict completion
#autoload -Uz predict-on
#predict-on

# Remove directory word by C-w.
autoload -Uz select-word-style
select-word-style bash

# }}}

## Zsh VCS Info and RPROMPT {{{

if autoload +X vcs_info 2> /dev/null; then
	autoload -Uz vcs_info
	zstyle ':vcs_info:*' enable git cvs svn # hg - slow, it scans all parent directories.
	zstyle ':vcs_info:*' formats '%s %b'
	zstyle ':vcs_info:*' actionformats '%s %b (%a)'
	precmd_vcs_info() {
		psvar[1]=""
		LANG=en_US.UTF-8 vcs_info
		[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
	}
	precmd_functions+=precmd_vcs_info
	RPROMPT="${RPROMPT}%1(V. %F{green}%1v%f.)"
fi

# }}}

## Zsh Completion System {{{

# Use zsh completion system.
autoload -Uz compinit
compinit

# Colors completions.
zstyle ':completion:*' list-colors ''

# Colors processes for kill completion.
zstyle ':completion:*:*:kill:*:processes' command 'ps -axco pid,user,command'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# Ignore case.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Formatting and messages.
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:messages' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for: %d%{\e[0m%}'
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*' group-name ''

# Make the completion menu selectable.
zstyle ':completion:*:default' menu select=1

# Fuzzy match.
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

# Hostname completion
local knownhosts
if [ -f $HOME/.ssh/known_hosts ]; then
	knownhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} ) 
	zstyle ':completion:*:(ssh|scp|sftp):*' hosts $knownhosts
fi

## }}}

## Zsh History {{{

# Don't save history in file
unset HISTFILE

# Max history in memory.
HISTSIZE=100000

# Max history on disk.
SAVEHIST=0

# Remove command lines from the history list when the first character on the line is a space.
setopt hist_ignore_space

# Remove the history (fc -l) command from the history list when invoked.
setopt hist_no_store

# Read new commands from the history and your typed commands to be appended to the history file.
unsetopt share_history

# Append the history list to the history file for mutiple Zsh sessions.
unsetopt append_history

# Save each command's beginning timestamp.
unsetopt extended_history

# Don't add duplicates.
setopt hist_ignore_dups

# Don't require confirmation of !$ etc.
unsetopt hist_verify

# Seach history.
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

## }}}

## Zsh Keybinds {{{
## based on http://github.com/kana/config/

# To delete characters beyond the starting point of the current insertion.
bindkey -M viins '\C-h' backward-delete-char
bindkey -M viins '\C-w' backward-kill-word
bindkey -M viins '\C-u' backward-kill-line

# Undo/redo more than once.
bindkey -M vicmd 'u' undo
bindkey -M vicmd '\C-r' redo

# History
# See also 'autoload history-search-end'.
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd '?' history-incremental-search-forward
bindkey -M viins '^p' history-beginning-search-backward-end
bindkey -M viins '^n' history-beginning-search-forward-end

bindkey -M emacs '^p' history-beginning-search-backward-end
bindkey -M emacs '^n' history-beginning-search-forward-end

# Transpose
bindkey -M vicmd '\C-t' transpose-words
bindkey -M viins '\C-t' transpose-words

# }}}

## Zsh Terminal Title Changes {{{

case "${TERM}" in
screen*|ansi*)
	preexec_term_title() {
		print -n "\ek$1\e\\"
	}
	preexec_functions+=preexec_term_title
	precmd_term_title() {
		print -n "\ek$(whoami)@$(hostname -s):$(basename "${PWD}")\e\\"
	}
	precmd_functions+=precmd_term_title
	;;
xterm*)
	preexec_term_title() {
		print -n "\e]0;$1\a"
	}
	preexec_functions+=preexec_term_title
	precmd_term_title() {
		print -n "\e]0;$(basename "${PWD}")\a"
	}
	precmd_functions+=precmd_term_title
	;;
esac

# }}}

## Scan Additonal Configurations {{{

setopt no_nomatch
#init_additionl_configration "*.zsh"

# }}}

## Post Configurations {{{

if init_rubies; then
	RPROMPT="${RPROMPT} %{$fg[red]%}\${RUBIES_RUBY_NAME}%{$reset_color%}"
fi

# Load Perl local::lib.
init_locallib

# Cleanup PATH, MANPATH.
clean_paths

# }}}

# autoconf and automake {{{
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"
# }}}

# whois method for .jp domain names {{{
whois() {
	if echo "$1" | grep '\.jp$' > /dev/null 2>&1
	then
		=whois $* | iconv -f iso-2022-jp -t utf-8
	else
		=whois $*
	fi
}
# }}}

# The next line updates PATH for the Google Cloud SDK.
#source $HOME/Library/google-cloud-sdk/path.zsh.inc

# The next line enables zsh completion for gcloud.
#source $HOME/Library/google-cloud-sdk/completion.zsh.inc

# connect to gpg key agent
if [ `tty` != '/dev/ttyv0' ];then
	. ${HOME}/.profiles/bin/gpg-agent-startup
	export GPG_AGENT_INFO
	export SSH_AUTH_SOCK
	export SSH_AGENT_PID
fi

# mutt background fix
export COLORFGBG="default;default"

# bitcoin build
export BDB_PREFIX=$HOME/Development/db-4.8.30.NC/build_unix/build
# ./configure CPPFLAGS="-I${BDB_PREFIX}/include/ -O2" LDFLAGS="-L${BDB_PREFIX}/lib/" --with-gui

alias gpg=gpg2

export PATH=$PATH:$HOME/.gvp/bin:$HOME/.gpm/bin:$HOME/.gpm-bootstrap/bin:$HOME/.gpm-git:$HOME/.gpm-local

source $HOME/.gvm/scripts/gvm
gvm use go1.4

# vim:ts=4:sw=4:noexpandtab:foldmethod=marker:nowrap:
