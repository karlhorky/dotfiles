// ==UserScript==
// @name         Disable GitHub Unread Notifications view
// @description  Redirect away from Notifications "Unread" view
// @version      1.0.0
// @author       Karl Horky
// @namespace    https://www.karlhorky.com/
// @match        https://github.com/notifications?query=is%3Aunread
// @grant        none
// ==/UserScript==

window.location.href = 'https://github.com/notifications?query=';
