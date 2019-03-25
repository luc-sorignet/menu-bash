#/bin/bash


_question(){

    local QUESTION="$1"
    shift
    local DEFAULT="$1"
    echo "$QUESTION"  >$(tty)
    shift
    PS3='> '   # le prompt
    local OPTIONS=("$@")

    local item i=0 numItems=$#OPTIONS

    for item in "${OPTIONS[@]}"; do
    if [ "$((i+1))" == "$DEFAULT" ]; then
        printf '%s\n' "$((++i))) $item (valeur par defaut)"
    else
        printf '%s\n' "$((++i))) $item"
    fi
    done >$(tty)

    while :; do
    printf '%s' "${PS3-#? }" >$(tty)
    read -r REPLY
    # Make sure that the input is either empty or that a valid index was entered.
    if [[ -z $REPLY ]]; then
        REPLY="$DEFAULT"
        break
    fi
    if [ "$REPLY" -le ${#OPTIONS[@]} -a "$REPLY" -gt 0 ]; then
            break
    fi

  done
  echo  "$REPLY"
    return 0
}

QUESTION="Votre commande ?"
# liste de choix disponibles
OPTIONS=(
         "Country Double"
         "Welsh"
         "MultiWEEEELLLLSSSHH"
         "Quitter"
        )

CHOIX=$( _question "$QUESTION" "3" "${OPTIONS[@]}" )
clear
echo "votre CHOIX = --$CHOIX--"