# =================
# Bash Prompt
# =================

# Show more information regarding git status in prompt
GIT_DIFF_IN_PROMPT=true

# --------------------
# Colors for the prompt
# --------------------

# Set the TERM var to xterm-256color
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM=xterm-256color
fi
if tput setaf 1 &> /dev/null; then
  tput sgr0
  if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    # this is for xterm-256color
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 196)
    DARK_RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 226)
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 13)
    CYAN=$(tput setaf 14) #45
    WHITE=$(tput setaf 7)
    ORANGE=$(tput setaf 208)
    PURPLE=$(tput setaf 93)
    LIGHT_PURPLE=$(tput setaf 141)
    BG_BLACK=$(tput setab 0)
    BG_RED=$(tput setab 1)
    BG_GREEN=$(tput setab 2)
    BG_BLUE=$(tput setab 4)
    BG_MAGENTA=$(tput setab 5)
    BG_CYAN=$(tput setab 6)
    BG_YELLOW=$(tput setab 226)
    BG_ORANGE=$(tput setab 172)
    BG_WHITE=$(tput setab 7)
  else
    MAGENTA=$(tput setaf 5)
    ORANGE=$(tput setaf 4)
    GREEN=$(tput setaf 2)
    PURPLE=$(tput setaf 1)
    WHITE=$(tput setaf 7)
  fi
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
  UNDERLINE=$(tput sgr 0 1)
else
  BLACK="\[\e[0;30m\]"
  RED="\033[1;31m"
  ORANGE="\033[1;33m"
  GREEN="\033[1;32m"
  PURPLE="\033[1;35m"
  WHITE="\033[1;37m"
  YELLOW="\[\e[0;33m\]"
  CYAN="\[\e[0;36m\]"
  BLUE="\[\e[0;34m\]"
  BOLD=""
  RESET="\033[m"
fi
# ---------------------
# Style the prompt
# ---------------------

style_user="\[${RESET}${PURPLE}\]"
style_path="\[${RESET}${CYAN}\]"
style_chars="\[${RESET}${WHITE}\]"
style_dollar="\[${RESET}${ORANGE}\]"
style_branch="${DARK_RED}"
style_git_status="${MAGENTA}"

# ---------------------
# Build the prompt
# ---------------------

# Example with committed changes: username ~/documents/GA/wdi on master[+]
PS1="${style_user}\u"                    # Username
PS1+="${style_path} \w"                  # Working directory
PS1+="\$(prompt_git)"                    # Git details
PS1+="\n"                                # Newline
PS1+="${style_dollar}\$ \[${RESET}\]"    # $ (and reset color)

# -----------------
# For the prompt
# -----------------

# Long git to show + ? !
is_git_repo() {
    $(git rev-parse --is-inside-work-tree &> /dev/null)
}

is_git_dir() {
    $(git rev-parse --is-inside-git-dir 2> /dev/null)
}

get_git_branch() {
    local branch_name
    # Get the short symbolic ref
    branch_name=$(git symbolic-ref --quiet --short HEAD 2> /dev/null) ||
    # If HEAD isn't a symbolic ref, get the short SHA
    branch_name=$(git rev-parse --short HEAD 2> /dev/null) ||
    # Otherwise, just give up
    branch_name="(unknown)"
    printf $branch_name
}

# Git status information
prompt_git() {
    local git_info git_state uc us ut st
    if ! is_git_repo || is_git_dir; then
        return 1
    fi
    git_info=$(get_git_branch)

    if $GIT_DIFF_IN_PROMPT; then
      # Check for uncommitted changes in the index
      if ! $(git diff --quiet --ignore-submodules --cached); then
          uc="${YELLOW}+"
      fi
      # Check for unstaged changes
      if ! $(git diff-files --quiet --ignore-submodules --); then
          us="${ORANGE}!"
      fi
      # Check for untracked files
      if [ -n "$(git ls-files --others --exclude-standard)" ]; then
          ut="${ORANGE}?"
      fi
      # Check for stashed files
      if $(git rev-parse --verify refs/stash &>/dev/null); then
          st="${BLUE}$"
      fi
      git_state=$uc$us$ut$st
      # Combine the branch name and state information
      if [[ $git_state ]]; then
          git_info="$git_info${RED}[$git_state${RED}]${RESET}"
      fi
    fi

    printf "${WHITE} on ${style_branch}${git_info}${RESET}"
}
