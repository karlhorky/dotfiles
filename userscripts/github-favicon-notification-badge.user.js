// ==UserScript==
// @name         GitHub Favicon Notification Badge
// @description  Show a badge over the favicon with the number of unread notifications (requires https://github.com/tanmayrajani/notifications-preview-github)
// @version      1.0.0
// @author       Karl Horky
// @namespace    https://www.karlhorky.com/
// @match        https://github.com/*
// @grant        none
// ==/UserScript==

const faviconHref = 'https://github.githubassets.com/favicons/favicon-dark.svg';
const faviconSize = 32;

function updateFaviconWithBadge(unreadNotifications) {
  if (!unreadNotifications) {
    const link = document.createElement('link');
    link.setAttribute('rel', 'icon');
    link.href = faviconHref;
    return;
  }

  const canvas = document.createElement('canvas');
  canvas.width = faviconSize;
  canvas.height = faviconSize;

  const context = canvas.getContext('2d');
  const img = document.createElement('img');

  img.onload = () => {
    // Draw original favicon as background
    context.drawImage(img, 0, 0, faviconSize, faviconSize);

    // Draw notification circle
    context.beginPath();
    context.arc(
      canvas.width - faviconSize / 2.5,
      faviconSize / 2.5,
      faviconSize / 2.5,
      0,
      2 * Math.PI,
    );
    context.fillStyle = '#161b22';
    context.fill();

    // Draw notification number
    context.font = '18px "helvetica", sans-serif';
    context.textAlign = 'center';
    context.textBaseline = 'middle';
    context.fillStyle = '#FFFFFF';
    context.fillText(
      unreadNotifications,
      canvas.width - faviconSize / 2.5,
      faviconSize / 2.5,
    );

    // Replace favicon
    const link = document.createElement('link');
    link.setAttribute('rel', 'icon');

    [...document.head.querySelectorAll('[rel~="icon"]')].forEach((element) =>
      document.head.removeChild(element),
    );

    link.href = canvas.toDataURL('image/png');
    document.head.appendChild(link);
  };

  img.crossOrigin = 'anonymous';
  img.src = faviconHref;
}

let unreadNotifications;

setInterval(() => {
  const newUnreadNotifications = document.querySelector('.mail-status.unread')
    ?.innerText;

  if (newUnreadNotifications === unreadNotifications) {
    return;
  }

  unreadNotifications = newUnreadNotifications;
  updateFaviconWithBadge(unreadNotifications);
}, 2000);
