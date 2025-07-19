
#!/usr/bin/env bash
selected=`cat ~/.scripts/ch_repo/.tmux-cht-languages ~/.scripts/ch_repo/.tmux-cht-command | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    echo \"curl cheat.sh/$selected/$query/\ & curl cheat.sh/$selected/$query & while [ : ]; do sleep 1; done
else
    curl -s cheat.sh/$selected/$query
fi
