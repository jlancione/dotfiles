fish_add_path /opt/homebrew/bin
fish_add_path /usr/local/bin/ 

set fish_greeting               # Supresses fish's intro message
set TERM "xterm-256color"       # Sets the terminal type

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


### Aliases ###
alias clr='clear; echo; echo; seq 1 (tput cols) | sort -R | spark | lolcat; echo'
alias skim='/Applications/Skim.app/Contents/MacOS/Skim'
alias root='root -l'
alias config='/opt/homebrew/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# To launch the venv for python in Mac (all because of homebrew)
alias pyenv='source ~/.pyvenv/bin/activate.fish; source /opt/homebrew/Cellar/root/6.38.04/bin/thisroot.fish'

alias rm='rm -i' # for safety reasons

alias ls='eza --color=always --long --git'
alias lt='eza --color=always -a --tree --level=2 --git'
alias la='eza -a --color=always --long --git'
alias ll='eza -a -g --color=always --long --git'
alias cd='z'

## Initializations ##
# fzf keybindings
fzf --fish | source

zoxide init fish | source
starship init fish | source
