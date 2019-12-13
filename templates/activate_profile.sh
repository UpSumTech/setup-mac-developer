#!/usr/bin/env bash

all_available_profiles() {
  local profiles=( \
    "admin" \
  )
  echo "${profiles[@]}"
}

which_profile_is_active() {
  if [[ ! -z "$CURRENT_PROFILE" ]]; then
    echo "Current active profile is $CURRENT_PROFILE"
  else
    echo "No currently active profile"
  fi
}

setup_aws_session_token() {
  local creds_file
  local aws_access_key_id
  local aws_secret_access_key
  local aws_session_token
  if [[ ! -z "$AWS_ROLE_ARN" ]]; then
    if [[ ! -z "$AWS_MFA_ARN" ]]; then
      rm -rf "$HOME/.aws/cli/cache"
      # aws sts get-session-token --profile $AWS_PROFILE --duration-seconds 43200
      aws sts get-caller-identity --profile $AWS_PROFILE
      creds_file="$(find ~/.aws/cli/cache/ -type f)"
      aws_access_key_id="$(cat $creds_file | jq -r '.Credentials.AccessKeyId')"
      aws_secret_access_key="$(cat $creds_file | jq -r '.Credentials.SecretAccessKey')"
      aws_session_token="$(cat $creds_file | jq -r '.Credentials.SessionToken')"
      export AWS_ACCESS_KEY_ID="$aws_access_key_id"
      export AWS_SECRET_ACCESS_KEY="$aws_secret_access_key"
      export AWS_ACCESS_KEY="$aws_access_key_id"
      export AWS_SECRET_KEY="$aws_secret_access_key"
      export AWS_SESSION_TOKEN="$aws_session_token"
    fi
  fi
}

clean_active_profile() {
  rm -rf "$HOME/.aws/cli/cache"
  deactivate_profile_for_personal_admin
  deactivate_profile_for_work_admin
  echo "Unset current profile from $CURRENT_PROFILE"
}

activate_profile_for_personal_admin() {
  clean_active_profile
  export AWS_ACCESS_KEY_ID="$PERSONAL_ADMIN_AWS_ACCESS_KEY_ID"
  export AWS_SECRET_ACCESS_KEY="$PERSONAL_ADMIN_AWS_SECRET_ACCESS_KEY"
  export AWS_ACCOUNT_ID="$PERSONAL_ADMIN_AWS_ACCOUNT_ID"
  export AWS_ACCESS_KEY="$PERSONAL_ADMIN_AWS_ACCESS_KEY_ID"
  export AWS_SECRET_KEY="$PERSONAL_ADMIN_AWS_SECRET_ACCESS_KEY"
  export AWS_DEFAULT_REGION="$PERSONAL_ADMIN_AWS_DEFAULT_REGION"
  export AWS_DEFAULT_OUTPUT="json"
  export DEPLOY_GITHUB_TOKEN="$PERSONAL_ADMIN_DEPLOY_GITHUB_TOKEN"
  export DOCKERHUB_USERNAME="$PERSONAL_ADMIN_DOCKERHUB_USERNAME"
  export DOCKERHUB_PASSWORD="$PERSONAL_ADMIN_DOCKERHUB_PASSWORD"
  export GITHUB_USERNAME="$PERSONAL_ADMIN_GITHUB_USERNAME"
  export BINTRAY_USERNAME="$PERSONAL_ADMIN_BINTRAY_USERNAME"
  export BINTRAY_API_KEY="$PERSONAL_ADMIN_BINTRAY_API_KEY"
  export BINTRAY_REPO_NAME="$PERSONAL_ADMIN_BINTRAY_REPO_NAME"
  export AWS_PROFILE="personal_root"
  activate_profile_helper "admin"
}

deactivate_profile_for_personal_admin() {
  deactivate_profile_helper
}

activate_profile_for_work_admin() {
  clean_active_profile
  export AWS_ACCESS_KEY_ID="$WORK_ADMIN_AWS_ACCESS_KEY_ID"
  export AWS_SECRET_ACCESS_KEY="$WORK_ADMIN_AWS_SECRET_ACCESS_KEY"
  export AWS_ACCOUNT_ID="$WORK_ADMIN_AWS_ACCOUNT_ID"
  export AWS_ACCESS_KEY="$WORK_ADMIN_AWS_ACCESS_KEY_ID"
  export AWS_SECRET_KEY="$WORK_ADMIN_AWS_SECRET_ACCESS_KEY"
  export AWS_DEFAULT_REGION="$WORK_ADMIN_AWS_DEFAULT_REGION"
  export AWS_DEFAULT_OUTPUT="json"
  export DEPLOY_GITHUB_TOKEN="$WORK_ADMIN_DEPLOY_GITHUB_TOKEN"
  export DOCKERHUB_USERNAME="$WORK_ADMIN_DOCKERHUB_USERNAME"
  export DOCKERHUB_PASSWORD="$WORK_ADMIN_DOCKERHUB_PASSWORD"
  export GITHUB_USERNAME="$WORK_ADMIN_GITHUB_USERNAME"
  export BINTRAY_USERNAME="$WORK_ADMIN_BINTRAY_USERNAME"
  export BINTRAY_API_KEY="$WORK_ADMIN_BINTRAY_API_KEY"
  export BINTRAY_REPO_NAME="$WORK_ADMIN_BINTRAY_REPO_NAME"
  export AWS_PROFILE="work_root"
  activate_profile_helper "admin"
}

deactivate_profile_for_work_admin() {
  deactivate_profile_helper
}

activate_profile_helper() {
  export CURRENT_PROFILE="$1"
  echo "Set current profile to $CURRENT_PROFILE"
}

deactivate_profile_helper() {
  unset CURRENT_PROFILE
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_ACCESS_KEY
  unset AWS_SECRET_KEY
  unset AWS_SESSION_TOKEN
  unset AWS_ACCOUNT_ID
  unset AWS_DEFAULT_REGION
  unset AWS_DEFAULT_OUTPUT
  unset DEPLOY_GITHUB_TOKEN
  unset DOCKERHUB_USERNAME
  unset DOCKERHUB_PASSWORD
  unset GITHUB_USERNAME
  unset BINTRAY_USERNAME
  unset BINTRAY_API_KEY
  unset BINTRAY_REPO_NAME
  unset AWS_ROLE_ARN
  unset AWS_MFA_ARN
  unset AWS_PROFILE
}

activate_help() {
  echo "
    Valid profiles are : $(_all_available_profiles)
    Valid options for calling acivate profile are
      activate_profile_for_personal_admin
      deactivate_profile_for_personal_admin
      activate_help
      all_available_profiles
      clean_active_profile
  "
}

[[ -f "$HOME/.work_helpers.sh" && -z $SOURCED_WORK_HELPERS ]] && . "$HOME/.work_helpers.sh"
export SOURCED_ACTIVATE_PROFILE=1
