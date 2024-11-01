# Create Chrome Desktop App Shortcuts to multiple Google Calendar accounts

## Problem

You have a personal Google Calendar and also a GSuite Google Calendar account, and you want to have [Chrome desktop apps](#chrome-desktop-apps) (aka pseudo-PWAs or Shortcuts) for both of them.

However, when creating the app to the second account, Chrome does not create a new app:

1. Creating a new app replaces your existing app.
2. Creating an app using the `/u/1` url (example URL: https://calendar.google.com/calendar/u/1/r) will launch the incorrect Google Calendar account when you relaunch it

## Solution 1: Add a Web App Manifest

1. Copy the JavaScript below
2. On the Google Calendar page, open the Chrome Devtools (right click anywhere on the page and select "Inspect")
3. Go to the Console tab and paste the copied JavaScript
4. Modify the URL if necessary to whatever URL you are trying to create an app for
5. Hit return to run the JavaScript

```js
const startUrl = 'https://calendar.google.com/calendar/u/1/r';
document.head
  .querySelector(':first-child')
  .insertAdjacentHTML(
    'beforebegin',
    `<link rel="manifest" href='data:application/manifest+json,{"start_url":"${startUrl}"}' />`,
  );
```

This will add a [Web App Manifest](https://www.w3.org/TR/appmanifest) for this website, which will be used when creating the app.

Once you have done this, you can create the desktop app as normal:

6. Click on the three dots menu > More Tools > Create Shortcut
   <img src="gsuite-google-calendar-chrome-desktop-app-shortcut-create-shortcut.png" alt="" /><br /><br />
7. Check "Open as window" and select "Create"
   <img src="gsuite-google-calendar-chrome-desktop-app-shortcut-create-shortcut-window.png" alt="" /><br /><br />

Now you should have a separate desktop app for your second calendar account!

<img src="gsuite-google-calendar-chrome-desktop-app-shortcut-dock.png" alt="" />

## Solution 2: Edit an Existing Web App Manifest

For applications other than Google Calendar, you may have issues with the solution above, and you may have more success [editing an existing Web App Manifest](https://github.com/karlhorky/pwa-tricks#change-starting-url-of-pwa-in-chrome).

## Alternative Offline Mode Solution

The new solutions above are simpler and work more reliably than [the old solution](https://github.com/karlhorky/dotfiles/blob/3dc4f34f4ef00159987d4dee0dec4aafd8331895/tricks/gsuite-google-calendar-chrome-desktop-app-shortcut.md), which used offline mode in the Network tab.

## Chrome Desktop Apps

Chrome desktop apps can be created for any website or web application, and behave similar to full desktop applications on your computer (see https://twitter.com/karlhorky/status/1127884049073233920).
