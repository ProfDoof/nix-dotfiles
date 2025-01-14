#!/usr/bin/env zsh
get_rev() {
  git ls-remote $1 HEAD | cut -f 1
}

update() {
    echo "[[talon_repos]]"
    echo "owner = \"${1}\"";
    echo "repo = \"${2}\"";
    rev=$(get_rev "git@github.com:${1}/${2}")
    echo "rev = \"${rev}\"";
    hash=$(nix-prefetch-url --unpack "https://github.com/${1}/${2}/archive/${rev}.zip")
    echo "hash = \"${hash}\""
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