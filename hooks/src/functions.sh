#!/bin/bash

function parse_branch_name() {
    local pattern="^(feature|hotfix|support)/([0-9]{8})-([a-z]+)-([0-9]+)-(.+)$"

    if ! [[ $1 =~ $pattern ]] ; then
        echo "Branch name not apply pattern:"
        echo $1

        exit 1
    fi

    BRANCH_TYPE=${BASH_REMATCH[1]}
    BRANCH_DATE=${BASH_REMATCH[2]}
    BRANCH_AUTHOR=${BASH_REMATCH[3]}
    BRANCH_ISSUE=${BASH_REMATCH[4]}

    local description=${BASH_REMATCH[5]}

    BRANCH_DESCRIPTION=${description//-/ }
}

function render_template() {
    local template_file=$1
    local result_file=$2

    (eval "cat <<EOF
$(<$template_file)
EOF
" 2> /dev/null) > $result_file
}