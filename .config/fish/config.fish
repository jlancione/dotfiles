# if status is-interactive
    # Commands to run in interactive sessions can go here
# end
#
# Preso pezzi da DT, ma non e' tutto il suo config.fish

fish_add_path /opt/homebrew/bin
fish_add_path /Library/TeX/texbin
fish_add_path /usr/local/bin/ 

### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set TERM "xterm-256color"                         # Sets the terminal type
# set EDITOR "emacsclient -t -a ''"                 # $EDITOR use Emacs in terminal
# set VISUAL "emacsclient -c -a emacs"              # $VISUAL use Emacs in GUI mode

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end
### END OF VI MODE ###

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
# set fish_color_normal brcyan
# set fish_color_autosuggestion '#7d7d7d'
# set fish_color_command brcyan
# set fish_color_error '#ff6c6b'
# set fish_color_param brcyan

### FUNCTIONS ###

## SPARK ##
function spark --description Sparklines
    argparse --ignore-unknown --name=spark v/version h/help m/min= M/max= -- $argv || return

    if set --query _flag_version[1]
        echo "spark, version 1.1.0"
    else if set --query _flag_help[1]
        echo "Usage: spark <numbers ...>"
        echo "       stdin | spark"
        echo "Options:"
        echo "       --min=<number>   Minimum range"
        echo "       --max=<number>   Maximum range"
        echo "       -v or --version  Print version"
        echo "       -h or --help     Print this help message"
        echo "Examples:"
        echo "       spark 1 1 2 5 14 42"
        echo "       seq 64 | sort --random-sort | spark"
    else if set --query argv[1]
        printf "%s\n" $argv | spark --min="$_flag_min" --max="$_flag_max"
    else
        command awk -v min="$_flag_min" -v max="$_flag_max" '
            {
                m = min == "" ? m == "" ? $0 : m > $0 ? $0 : m : min
                M = max == "" ? M == "" ? $0 : M < $0 ? $0 : M : max
                nums[NR] = $0
            }
            END {
                n = split("▁ ▂ ▃ ▄ ▅ ▆ ▇ █", sparks, " ") - 1
                while (++i <= NR) 
                    printf("%s", sparks[(M == m) ? 3 : sprintf("%.f", (1 + (nums[i] - m) * n / (M - m)))])
            }
        ' && echo
    end
end
## SPARK END ##

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

### ALIASES ###
alias clr='clear; echo; echo; seq 1 (tput cols) | sort -R | spark | lolcat; echo'

alias vim='nvim'

alias skim='/Applications/Skim.app/Contents/MacOS/Skim'
alias config='/opt/homebrew/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
# to launch the venv for python in Mac (all because of homebrew)
alias pyenv='python3 -m venv ~/Documents/tesi/pyvenv; source ~/Documents/tesi/pyvenv/bin/activate.fish'

### RANDOM COLOR SCRIPT ###
# Get this script from my GitLab: gitlab.com/dwt1/shell-color-scripts
# Or install it from the Arch User Repository: shell-color-scripts
# colorscript random

# nuke-dash/pokemon-colorscripts-mac
# pokemon-colorscripts --random --no-title
clr

### SETTING THE STARSHIP PROMPT ###
starship init fish | source
