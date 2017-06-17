dump-docker-machine-env() {
  local machine="$1"
  docker-machine env $machine > ~/.docker-machine-env.sh
}

if [[ -e ~/.docker-machine-env.sh ]]; then
  source ~/.docker-machine-env.sh
fi
