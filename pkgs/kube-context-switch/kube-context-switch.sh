#!/usr/bin/env bash

function c() {
    kubectl config use-context $1
}

c "$1"