// ==UserScript==
// @name         Autoclose Zoom Success Tabs
// @namespace    https://www.karlhorky.com/
// @version      1.0.4
// @description  Automatically close Zoom tabs after success à la https://github.com/thesephist/clozoom/blob/master/background.js
// @author       Karl Horky
// @match        https://*.zoom.us/*
// @grant        window.close
// ==/UserScript==

(function() {
  'use strict';
  if (
    // https://us02web.zoom.us/j/6830992169#success
    /^https:\/\/\S+\.zoom.us\/j\/.+#success$/.test(location.href) ||
    // https://us02web.zoom.us/postattendee?id=8
    /^https:\/\/\S+\.zoom.us\/postattendee\?id=/.test(location.href)
  ) {
    setTimeout(() => window.close(), 2000);
  }
})();
