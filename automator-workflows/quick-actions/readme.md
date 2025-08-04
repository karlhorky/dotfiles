# Quick Actions

## Installation

Install prerequisites:

```bash
# ffmpeg, for any video Quick Actions
# https://formulae.brew.sh/formula/ffmpeg
brew install ffmpeg

# ImageOptim, for any "ImageOptim" Quick Actions
# https://formulae.brew.sh/cask/imageoptim
brew install --cask imageoptim
```

Install and set up [the Refined GitHub browser extension](https://github.com/refined-github/refined-github).

In [the `automator-workflows/quick-actions` folder on GitHub](https://github.com/karlhorky/dotfiles/tree/main/automator-workflows/quick-actions), click on the three dots menu at the top right and select "Download directory":

<img width="2878" height="906" alt="Screenshot of GitHub at the folder, showing an open three dots menu and a highlighted 'Download directory' option in the menu" src="https://github.com/user-attachments/assets/c2523420-3913-44a9-84fc-1be62c5d71eb" />

Open the `.workflow` files to install them in `~/Library/Services/`, which will make them appear in the right-click "Quick Actions" submenu.

## ImageOptim

Optimize an image or folder with ImageOptim.

<img width="612" alt="Screen Shot 2019-04-23 at 19 53 07" src="https://user-images.githubusercontent.com/1935696/56604112-8abaa900-6601-11e9-96ee-6b4b6184c9f0.png">

<img width="476" alt="Screen Shot 2019-04-23 at 19 54 56" src="https://user-images.githubusercontent.com/1935696/56604200-bccc0b00-6601-11e9-8e6b-d9b42a7e882d.png">

## Resize to 800px width + ImageOptim

Resize an image to 800px width and then optimize it with ImageOptim.
