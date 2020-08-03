// ==UserScript==
// @name github-notifications-show-all-messages
// @description Change links to always show all messages on the GitHub Notifications Beta
// @version 1.0.0
// @match https://github.com/notifications/beta
// @match https://github.com/notifications/beta?*
// ==/UserScript==
(function () {
  const showAllMessagesParameter = '&show_full=true';

  function alwaysShowAllMessages() {
    Array.from(document.querySelectorAll('.notifications-list-item .flex-row:first-child a[href]')).forEach(anchor => {
      if (anchor.href.includes(showAllMessagesParameter)) return;
      anchor.href = anchor.href + showAllMessagesParameter;
    });
  }

  document.body.addEventListener('pjax:complete', alwaysShowAllMessages);

  alwaysShowAllMessages();
}());
