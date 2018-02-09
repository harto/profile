aws-exec() {
  local profile_name=$1; shift
  local profile=$(grep $profile_name ~/.aws-profiles)
  if [[ -z $profile ]]; then
    echo "no profile $profile_name; aborting" >&2
    return 1
  fi
  env AWS_ACCESS_KEY_ID=$(echo -n $profile | cut -d: -f2) \
      AWS_SECRET_ACCESS_KEY=$(echo -n $profile | cut -d: -f3) \
      "$@"
}
