#!/usr/bin/env bash
# https://github.com/jaredbeck/shellconf/blob/master/lib/jb_rubygem_page.sh

function jb_rubygem_page() {
  local gemname="$1"
  open "https://rubygems.org/gems/$gemname"
}
