// ==UserScript==
// @name         Autoclose Zoom Success Tabs
// @description  Automatically close Zoom tabs after success à la https://github.com/thesephist/clozoom/blob/master/background.js
// @version      1.0.6
// @author       Karl Horky
// @namespace    https://www.karlhorky.com/
// @match        https://*.zoom.us/*
// @grant        window.close
// ==/UserScript==

setTimeout(() => {
  if (
    // https://us02web.zoom.us/j/6830992169#success
    /^https:\/\/\S+\.zoom.us\/j\/.+#success$/.test(location.href) ||
    // https://us02web.zoom.us/postattendee?id=8
    // https://us02web.zoom.us/postattendee
    /^https:\/\/\S+\.zoom.us\/postattendee/.test(location.href)
  ) {
    window.close();
  }
}, 10000);
