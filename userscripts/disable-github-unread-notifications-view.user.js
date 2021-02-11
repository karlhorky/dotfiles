// ==UserScript==
// @name         Disable GitHub Unread Notifications view
// @description  Redirect away from Notifications "Unread" view
// @version      1.1.0
// @author       Karl Horky
// @namespace    https://www.karlhorky.com/
// @match        https://github.com/notifications?query=is%3Aunread
// @grant        none
// ==/UserScript==

document
  .querySelector(
    '.BtnGroup > form[action="/notifications/beta/set_preferred_inbox_query"]:first-child > button'
  )
  .click();
