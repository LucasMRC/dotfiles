#!/bin/bash

launch_session() {
    SESSION_NAME=$1
    echo "How many windows 🪟 should I add for $SESSION_NAME?"
    read WIN_NUMBER
    for iw in `seq 1 $WIN_NUMBER`; do
        read -p "🖊️ How should I name window number $iw? " WIN_NAME
        read -e -p "Open any specific directory 📁 on that window? " DIR
        if [ ! $DIR ]; then
            DIR="~"
        fi
        read -p "Run any commands there ⚡? " COMMAND
        if [[ $COMMAND == "nvim"* ]]; then
            COMMAND="nvim $DIR"
        fi
        if [ $iw -eq 1 ]; then
            tmux new -d -s "$SESSION_NAME" -n "$WIN_NAME" -c $DIR $COMMAND
        else
            tmux neww -t "$SESSION_NAME":$iw -n "$WIN_NAME" -c $DIR $COMMAND
        fi
    done
    prompt_new_session
}

prompt_new_session() {
    read -p "That's done 😉, should I create another session? (yes/no) " -n 1 -r
    echo
    case $REPLY in
    [yY] )
        read -p "Awesome 🙌! How should I name it? " NAME
        launch_session $NAME;;
    [nN] )
        echo "All done! Have fun! 🙃"
        read
        tmux attach;;
    * ) read -p "I didn't quite get that. Should I add another session? 🤔 (yes/no) " -n 1 -r
        echo
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
    tmux kill-server &> /dev/null
    echo "Hey 😁! Let's set up the environment 💻"
    SESSION_NAME="Neovim"
    launch_session Neovim
}

launch_tmux
