#!/usr/bin/env zsh
get_rev() {
  git ls-remote $1 HEAD | cut -f 1
}

update() {
    echo "[[talon_repos]]"
    echo "owner = \"${1}\"";
    echo "repo = \"${2}\"";
    echo "rev = \""$(get_rev "git@github.com:${1}/${2}")"\"";
    combined="${1}${2}"
    echo "hash = \"sha256-${(l:44::A:)combined}=\""
    echo
}

REPOS=(
    'talonhub' 'community'
    'david-tejada' 'rango-talon'
    'cursorless-dev' 'cursorless-talon'
    'chaosparrot' 'talon_hud'
    'ProfDoof' 'speak-the-spire-talon'
)



for owner repo in "$REPOS[@]"
do
    update $owner $repo
done > talon_repos.toml