Karl Horky's dotfiles
=====================

System settings for OS X and bootstrapper for new systems.


### Setup

To set up a new Mac, clone and run the `fresh_install` script:

```bash
git clone git@github.com:karlhorky/dotfiles.git
cd dotfiles
./fresh_install/fresh_install.sh
```

To set up your git user, create a file in your home directory with your git credentials. This will be read by the main `.gitconfig` file:

**.gitconfig.user**
```
[user]
  name = Karl Horky
  email = kh@example.com
```

### Update

To update, run the `dotfiles_refresh` script from any location:

```bash
dotfiles_refresh
```
