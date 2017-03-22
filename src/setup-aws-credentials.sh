#!/usr/bin/env bash

main() {
  # Rotate your was keys by going to IAM > Users on the aws console or use aws cli to do it.
  # Get a fresh pair of access key id and secret key and update your bash_profile with this.
  echo "export AWS_ACCESS_KEY_ID=<access key id>" >> ~/.bash_profile
  echo "export AWS_ACCESS_KEY=\"$AWS_ACCESS_KEY_ID\”" >> ~/.bash_profile
  echo "export AWS_SECRET_ACCESS_KEY=<secret key>" >> ~/.bash_profile
  echo "export AWS_SECRET_KEY=\"$AWS_SECRET_ACCESS_KEY\”" >> ~/.bash_profile
  echo "export AWS_DEFAULT_REGION=us-west-2" >> ~/.bash_profile
}

[[ "$BASH_SOURCE" == "$0" ]] && main "$@"
