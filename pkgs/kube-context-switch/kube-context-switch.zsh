#compdef c

function _c() {
    local matches=(`kubectl config get-contexts -o name 2>/dev/null`)
    compadd -a matches
}