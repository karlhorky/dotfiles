# Folder Actions

## Installation

To enable the workflows to automatically run on a folder:

1. Copy to `~/Library/Workflows/Applications/Folder Actions`
2. Right-click on the folder in question and select Services -> Folder Actions Setup... and add the action, if it's not already there.

## ImageOptim Downloads Screenshots

Automatically optimize the screenshots that appear in the Downloads folder (but you can reconfigure this folder however you like).

Consists of the following actions:

1. A **Filter Finder Items** Action and set the `Kind` to `image`
2. A **Run Shell Script** Action and add the following code:

```sh
[[ `basename "$@"` == Screen\ Shot* ]] && /Applications/ImageOptim.app/Contents/MacOS/ImageOptim "$@"
```

Preview of the workflow looks like in Automator:

![Screen Shot 2019-08-11 at 16 24 27](https://user-images.githubusercontent.com/1935696/62835108-d9de2580-bc54-11e9-893e-57823761729d.png)

Alternately, download from [my `dotfiles`](https://github.com/karlhorky/dotfiles/tree/master/workflows/folder-actions/ImageOptim%20Downloads%20Screenshots.workflow).
