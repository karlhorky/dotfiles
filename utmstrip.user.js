// ==UserScript==
// @name          UTM param stripper
// @author        Paul Irish
// @namespace     http://github.com/paulirish
// @version       1.2
// @description   Drop the UTM params from a URL when the page loads.
// @extra         Cuz you know they're all ugly n shit.
// @include       http*://*
// ==/UserScript==

// From https://gist.github.com/paulirish/626834

// You can install this user script by downloading this script,
// going to about: extensions, turning on developer mode and dragging and dropping
// this file onto the window. That'll install it.

// lastly, if your site / marketing funnel uses these tracking tokens. you can clean up your users URLs
// look at the comments below on correct installation to integrate with __gaq.push

if (/utm_/.test(location.search) && window.history.replaceState) {
  // thx @cowboy for the revised hash param magic.
  var oldUrl = location.href;
  var newUrl = oldUrl.replace(/\?([^#]*)/, function(_, search) {
    search = search
      .split("&")
      .map(function(v) {
        return !/^utm_/.test(v) && v;
      })
      .filter(Boolean)
      .join("&"); // omg filter(Boolean) so dope.
    return search ? "?" + search : "";
  });

  if (newUrl != oldUrl) {
    window.history.replaceState({}, "", newUrl);
  }
}
