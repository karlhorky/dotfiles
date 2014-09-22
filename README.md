Karl Horky's dotfiles
=====================

Configuration dotfiles for OSX. Heavily based on [Mathias Bynens' Dotfiles](https://github.com/mathiasbynens/dotfiles).

### Using Git and the setup script

You can clone the repository wherever you want. The setup script will pull in the latest version and copy the files to your home folder.

```bash
git clone git@github.com:karlhorky/dotfiles.git && cd dotfiles && source setup.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source setup.sh
```

### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./.osx
```
