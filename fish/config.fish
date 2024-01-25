if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Supresses fish's intro message
set fish_greeting

# Syntax:
# To just rerun your last command, simply type '!!'
# '!! sudo' will prepend sudo to your most recent command
# Running !! with anything other than sudo will append the argument to your most recent command
# To add another command to prepend list remove the # on line 10 and put the command in the quotes. Repeat as needed
function !!;
  set var (history | head -n 1)
  if test $argv
    if test $argv = "sudo"        #; or "any other command you want to prepend"
        eval $argv $var
    else
        eval $var $argv
    end
    else
        eval $var
  end
end

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias code='code-insiders'
alias standing-setup='sh /home/lucas/.screenlayout/standing-setup.sh'
alias sitting-setup='sh /home/lucas/.screenlayout/sitting-setup.sh'
alias laptop-only='sh /home/lucas/.screenlayout/laptop-only.sh'
alias pdf='mupdf'
alias hist='history --show-time="%d/%m/%Y %T " | less'
alias conda-activate='eval ~/anaconda3/bin/conda "shell.fish" "hook" $argv | source'

if [ -f /usr/bin/neofetch ]
    neofetch | lolcat
end

# Set up ssh-agent with GH key
if [ -z "$SSH_AUTH_SOCK" ]
    eval "$(ssh-agent -c)" &>/dev/null
    ssh-add -q ~/.ssh/id_ed25519_GH
end

set fish_color_normal '#17a1a1'
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command '#17a1a1'
set fish_color_error '#ff6c6b'
set fish_color_param '#0070a3'

set __fish_git_prompt_show_informative_status true
set __fish_git_prompt_showcolorhints true
set __fish_git_prompt_char_dirtystate '*'

set -gx EDITOR nvim
set -gx JAVA_HOME /usr/lib/jvm/java-11-openjdk
set -gx MVN_HOME /opt/apache-maven-3.9.6/bin
set -gx MAVEN_HOME /opt/apache-maven-3.9.6/bin
# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
set -gx PNPM_HOME "/home/lucas/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
