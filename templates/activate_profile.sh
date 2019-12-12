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

clean_active_profile() {
  case $CURRENT_PROFILE in
  admin)
    deactivate_profile_for_personal_admin
    deactivate_profile_for_work_admin
    echo "Unset current profile from admin"
    ;;
  *)
    echo "No valid profile currently active"
    ;;
  esac
}

activate_profile_for_personal_admin() {
  clean_active_profile
  export AWS_ACCESS_KEY_ID="$PERSONAL_ADMIN_AWS_ACCESS_KEY_ID"
  export AWS_SECRET_ACCESS_KEY="$PERSONAL_ADMIN_AWS_SECRET_ACCESS_KEY"
  export AWS_ACCOUNT_ID="$PERSONAL_ADMIN_AWS_ACCOUNT_ID"
  export AWS_ACCESS_KEY="$PERSONAL_ADMIN_AWS_ACCESS_KEY_ID"
  export AWS_SECRET_KEY="$PERSONAL_ADMIN_AWS_SECRET_ACCESS_KEY"
  export AWS_DEFAULT_REGION="$PERSONAL_ADMIN_AWS_DEFAULT_REGION"
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
  unset AWS_ACCOUNT_ID
  unset AWS_DEFAULT_REGION
  unset DEPLOY_GITHUB_TOKEN
  unset DOCKERHUB_USERNAME
  unset DOCKERHUB_PASSWORD
  unset GITHUB_USERNAME
  unset BINTRAY_USERNAME
  unset BINTRAY_API_KEY
  unset BINTRAY_REPO_NAME
  unset AWS_ROLE_ARN
  unset AWS_MFA_SERIAL
  unset AWS_PROFILE
}

activate_help() {
  echo "
    Valid profiles are : $(_all_available_profiles)
    Valid options for calling acivate profile are
      activate_profile_for_personal_admin
      deactivate_profile_for_personal_admin
      activate_profile_for_work_admin
      deactivate_profile_for_work_admin
      activate_help
      all_available_profiles
      clean_active_profile
  "
}

[[ -f "$HOME/.work_helpers.sh" && -z $SOURCED_WORK_HELPERS ]] && . "$HOME/.work_helpers.sh"
export SOURCED_ACTIVATE_PROFILE=1
