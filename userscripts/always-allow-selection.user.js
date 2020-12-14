// ==UserScript==
// @name         Always Allow Selection
// @namespace    https://www.karlhorky.com/
// @version      1.0
// @description  Disable user-select: none on all elements
// @author       Karl Horky
// @match        https://*/*
// @match        http://*/*
// @grant        none
// ==/UserScript==

(function() {
  'use strict';
  const styleEl = document.createElement('style');
  document.head.appendChild(styleEl);
  styleEl.sheet.insertRule('* { user-select: auto !important; }');
})();
