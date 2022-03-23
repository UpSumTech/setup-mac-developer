## Setup Mac Developer

This repo is used to set up a development environment. It has recently been tested with Catalina.
This project is not backwards compatible and does not support older versions of Mac OS.

I pretty much work on it as and when i need to setup a new dev machine. So there could be months between bug fixes.

### Pre-requisites
There are a few pre-res for Catalina

1. To allow the terminal to be able to change dirs etc on mac
   some of which could be owned by root, you need to provide "Full Disk Access" to terminal and iterm2 in the "Privacy" settings.

### Provisioning on AWS

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
