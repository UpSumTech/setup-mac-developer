## Setup Mac Developer

This repo is used to set up a development environment. It has recently been tested with OSX Monterey and on Mac M1 (arm64).
This project is not backwards compatible and does not support older versions of Mac OS.
There is a script to run it all called `./src/main.sh`.
But i advise you to run each script mentioned in that file one by one, so that you can fix things according to your needs as you go.

I pretty much work on it as and when i need to setup a new dev machine. So there could be months between bug fixes. But feel free to create a PR and i will merge.

### Pre-requisites
There are a few pre-reqs for Monterey

1. To allow the terminal to be able to change dirs etc on mac some of which could be owned by root you need to provide "Full Disk Access" to terminal and iterm in the "Privacy" settings.
    Go to
      System Preferences > Security and Privacy > Privacy > Full Disk Access
      System Preferences > Security and Privacy > Privacy > Developer Tools
    and add Terminal and Iterm

### Provisioning on AWS

For development purposes or fixing things in this project you can test out the scripts on a Mac in AWS.

For provisioning a mac on AWS, you need a dedicated host with auto-placement on. You can get that with this
```
aws ec2 allocate-hosts --instance-type mac1.metal --availability-zone us-west-2b --auto-placement on --quantity 1 --region us-west-2
```
Remember this dedicated host can be deleted only after 24 hours it has been allocated to your account.

Now you can launch an instance with this AMI - `amzn-ec2-macos-12.2.1`

To ssh into the mac use
```
ssh -i <private-key> ec2-user@<machine-dns>
```

To setup a user for experimenting
```
USERNAME=dev
sysadminctl -addUser $USERNAME -UID 1001 -fullName "$USERNAME" -password "<password>" -home /Users/$USERNAME -shell /bin/bash -admin
mkdir /Users/$USERNAME
chown $USERNAME:staff /Users/$USERNAME
```

OR

```
USERNAME=dev
dscl . -create /Users/$USERNAME
dscl . -create /Users/$USERNAME UserShell /bin/bash
dscl . -create /Users/$USERNAME RealName "dev"
dscl . -create /Users/$USERNAME UniqueID 2001
dscl . -create /Users/$USERNAME PrimaryGroupID 80
dscl . -passwd /Users/$USERNAME <password>
dscl . -append /Groups/admin GroupMembership $USERNAME
dscl . -create /Users/$USERNAME NFSHomeDirectory /Users/$USERNAME
```
