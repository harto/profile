npm-activate() {
  npm-deactivate
  export __NPM_PROJECT_BINS=$(__npm-project-bins $1)
  export PATH=$__NPM_PROJECT_BINS:$PATH
}

npm-deactivate() {
  if [[ -n $__NPM_PROJECT_BINS ]]; then
    export PATH=${PATH#$__NPM_PROJECT_BINS:}
  fi
}

__npm-project-bins() {
  local npm_project_dir=${1:-.}
  (cd $npm_project_dir && npm bin)
}
