#!/bin/bash

# check that the function doesn't already exist
[[ ! -z "$(compgen -c | grep "^app$")" ]] \
  && echo "The command 'app' already exists." \
  && exit

app() {
  open ~/.nix-profile/Applications/"$1"
}

_app() {
    # Get the currently completing word
    local CWORD=${COMP_WORDS[COMP_CWORD]}

    # This is our word list
    local WORD_LIST=$(/bin/ls -1p ~/.nix-profile/Applications)

    # Commands below depend on this IFS
    local IFS=$'\n'

    # Filter our candidates
    CANDIDATES=($(compgen -W "${WORD_LIST[*]}" -- "$CWORD"))

    # Correctly set our candidates to COMPREPLY
    if [ ${#CANDIDATES[*]} -eq 0 ]; then
        COMPREPLY=()
    else
        COMPREPLY=($(printf '%q\n' "${CANDIDATES[@]}"))
    fi
}

complete -o filenames -F _app app