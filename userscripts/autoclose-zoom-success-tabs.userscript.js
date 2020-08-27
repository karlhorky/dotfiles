// ==UserScript==
// @name         Autoclose Zoom Success Tabs
// @namespace    https://www.karlhorky.com/
// @version      1.0.0
// @description  Automatically close Zoom tabs after success à la https://github.com/thesephist/clozoom/blob/master/background.js
// @author       Karl Horky
// @match        https://*.zoom.us/j/*
// @grant        window.close
// ==/UserScript==

(function() {
  'use strict';
  const url = location.href;

  // https://us02web.zoom.us/j/6830992169#success
  const isZoomInviteUrl = url.match(/https:\/\/\S+\.zoom.us\/j\/.+/);
  const isSuccess = url.endsWith('#success');

  if (isZoomInviteUrl && isSuccess) {
    setTimeout(() => window.close(), 2000);
  }
})();
