fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin/ 
fish_add_path /Users/jacopolancione/.bin
fish_add_path /Users/jacopolancione/.tmuxifier/bin/

set fish_greeting               # Supresses fish's intro message
if not set -q TERM
  set TERM "xterm-256color"       # Sets the terminal type, if not already set
end
set -gx EDITOR nvim
set -gx MANPAGER "nvim +Man!"

### Set either default emacs mode or vi mode ###
function fish_user_key_bindings
  #fish_default_key_bindings
  fish_vi_key_bindings
end
### End of VI Mode ###

### Functions ###
## Spark ##
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
## Spark end ##

# Flatten annotated pdf (add annotations to pdf stream)
function flatten 
  # E.g. flatten annotated.pdf annotated-flat.pdf
  gs -dSAFER -dBATCH -dNOPAUSE -dNOCACHE -sDEVICE=pdfwrite -dPreserveAnnots=false \
    -sOutputFile=$argv[2] $argv[1]
end

# Change working dir in fish to last dir in lf on exit (adapted from ranger).
function lfcd --wraps="lf" --description="lf - Terminal file manager (changing directory on exit)"
    # `command` is needed in case `lfcd` is aliased to `lf`.
    # Quotes will cause `cd` to not change directory if `lf` prints nothing to stdout due to an error.
    cd "$(command lf -print-last-dir $argv)"
end


### Aliases ###
alias clr="clear; echo; echo; seq 1 (tput cols) | sort -R | spark | lolcat; echo"
alias skim="/Applications/Skim.app/Contents/MacOS/Skim"
alias root="root -l"
alias config="/opt/homebrew/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
alias wiki="nvim +'WikiIndex'"
alias journal="nvim +'WikiJournal'"

# To launch the venv for python in Mac (all because of homebrew)
alias pyenv="source ~/.pyvenv/bin/activate.fish"

# alias rm="rm -i" # for safety reasons

alias ls="eza --color=always --long --git -s type"
alias lt="eza --color=always -a --tree --level=2 --git -s type"
alias la="eza -a --color=always --long --git -s type"
alias ll="eza -a -g --color=always --long --git -s type"
alias cd="z"
alias kopia="/Applications/KopiaUI.app/Contents/Resources/server/kopia"

## Initializations ##
# fzf keybindings and defaults
fzf --fish | source
# find key/event binding possibilities in man fzf
set FZF_DEFAULT_OPTS "--bind=ctrl-n:up,ctrl-p:down"


zoxide init fish | source
eval (tmuxifier init - fish)
starship init fish | source
