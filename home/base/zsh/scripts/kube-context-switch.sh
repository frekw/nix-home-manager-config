#!/usr/bin/env bash

function c() {
    kubectl config use-context $1
}
function _c() {
    local cur kubectl_out
    cur=${COMP_WORDS[COMP_CWORD]}
    if kubectl_out=$(kubectl config get-contexts -o name 2>/dev/null); then
        COMPREPLY=( $( compgen -W "${kubectl_out[*]}" -- "$cur" ) )
    fi
}
complete -F _c c