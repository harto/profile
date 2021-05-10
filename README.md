My system configuration, plus helper scripts for installing it onto new computers.

# Steps to setup a new computer

- Generate GitHub ssh cert (note: not strictly necessary to run the setup script here, but eventually required)
- Install Homebrew (https://brew.sh/)
- ```
  mkdir -p ~/src
  git clone https://github.com/harto/profile.git
  cd profile
  ./install
  ```
- After Dropbox is configured, run `~/Dropbox/config/install` to symlink more things into `$HOME`.
