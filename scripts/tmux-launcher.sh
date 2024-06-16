!/bin/bash

launch_session() {
    SESSION_NAME=$1
    read -p "How many windows 🪟 should I add for $SESSION_NAME? " WIN_NUMBER
    DIR=""
    for iw in `seq 1 $WIN_NUMBER`; do
        read -p "🖊️ How should I name window number $iw? " WIN_NAME
        if [ $iw -eq 1 ]; then
            read -e -p "Open any specific directory 📁 on that window? " DIR
        else
            read -p "Same directory? (yes/no/almost) " -r
            case $REPLY in
                [aA] )
                    read -e -p "Which directory should I open on that window? " -i "$DIR" DIR;;
                [nN] )
                    read -e -p "Which directory should I open on that window? " DIR;;
            esac
        fi
        if [ ! $DIR ]; then
            DIR="~"
        fi
        COMMAND=""
        if [[ $SESSION_NAME == "Neovim" ]]; then
            COMMAND="nvim ."
        else
            read -p "Run any commands there ⚡? " COMMAND
        fi
        if [ $iw -eq 1 ]; then
            tmux new -d -s "$SESSION_NAME" -n "$WIN_NAME" -c $DIR
        else
            tmux neww -t "$SESSION_NAME":$iw -n "$WIN_NAME" -c $DIR
        fi
        if [[ ! -z $COMMAND ]]; then
            tmux send-keys -t "$SESSION_NAME:$WIN_NAME" "i$COMMAND" "Enter" # i to enter insert mode
        fi
    done
    if [[ $SESSION_NAME == "Neovim" ]]; then
        # Add nvim default windows
        if [[ $WIN_NUMBER == "0" ]]; then
            tmux new -d -s "Neovim" -n "Dotfiles" -c ~/.dotfiles/
        else
            tmux neww -t "Neovim" -n "Dotfiles" -c ~/.dotfiles/
        fi
        tmux neww -t "Neovim" -n "Notes" -c ~/.dotfiles/
        tmux send-keys -t "Neovim:Dotfiles" "invim ." "Enter"
        tmux send-keys -t "Neovim:Notes" "invim ." "Enter"
        echo "Let's define the Terminal session."
        launch_session Terminal
    else
        if [[ $SESSION_NAME == "Terminal" ]]; then
            # Add nvim default windows
            if [[ $WIN_NUMBER == "0" ]]; then
                tmux new -d -s "Terminal" -n "HTOP" -c ~/.dotfiles/
            else
                tmux neww -t "Terminal" -n "HTOP" -c ~/.dotfiles/
            fi
            # Add terminal default windows
            tmux neww -t "Terminal" -n "Music" -c ~/.dotfiles
            tmux send-keys -t "Terminal:HTOP" "ihtop" "Enter"
            tmux send-keys -t "Terminal:Music" "ispt" "Enter"
        fi
        prompt_new_session
    fi
}

prompt_new_session() {
    read -p "That's done 😉, should I create another session? (yes/no) " -r
    case $REPLY in
    [yY] )
        read -p "Awesome 🙌! How should I name it? " NAME
        launch_session $NAME;;
    [nN] )
        echo "All done! Have fun! 🙃"
        TARGET_WINDOW=$(tmux list-windows -t Neovim | gawk 'match($0, /1: (.+)- \(1 panes\)/, a) {print a[1]}')
        read
        tmux attach -t "Neovim:$TARGET_WINDOW";;
    * ) read -p "I didn't quite get that. Should I add another session? 🤔 (yes/no) " -r
        case $REPLY in
            [yY] )
                read -p "Awesome 🙌! How should I name it? " NAME
                launch_session $NAME;;
            [nN] )
                echo "All done! Have fun! 🙃"
                read
                tmux attach;;
            * ) echo "Ok, I have no answer for that. See ya! 👋"
                read
                tmux attach;;
        esac
    esac
}

launch_tmux() {
    echo "Hey 😁! Let's set up the environment 💻"
    NEOVIM_SESSION=$(tmux list-sessions 2> /dev/null | grep "Neovim" &>2 /dev/null)
    if [[ ! -z $NEOVIM_SESSION ]]; then
        tmux kill-session "Neovim" &>2 /dev/null
    fi
    SESSION_NAME="Neovim"
    launch_session $SESSION_NAME
}

launch_tmux
