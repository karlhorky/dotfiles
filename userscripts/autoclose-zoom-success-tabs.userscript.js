// ==UserScript==
// @name         Autoclose Zoom Success Tabs
// @namespace    https://www.karlhorky.com/
// @version      1.0.2
// @description  Automatically close Zoom tabs after success à la https://github.com/thesephist/clozoom/blob/master/background.js
// @author       Karl Horky
// @match        https://*.zoom.us/postattendee/*
// @grant        window.close
// ==/UserScript==

(function() {
  'use strict';
  // https://us02web.zoom.us/postattendee?id=8
  if (location.href.match(/^https:\/\/\S+\.zoom.us\/postattendee\?id=/)) {
    setTimeout(() => window.close(), 2000);
  }
})();
