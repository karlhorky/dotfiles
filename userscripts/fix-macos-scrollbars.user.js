// ==UserScript==
// @name         Fix macOS scrollbar hiding too quickly (always show)
// @description  DEPRECATED: Just use "Show scroll bars: Always" in macOS System Preferences
// @version      1.0.0
// @author       Karl Horky
// @namespace    https://www.karlhorky.com/
// @match        https://*/*
// @match        http://*/*
// @grant        none
// ==/UserScript==

// Demo: http://jsfiddle.net/3pog5rws/13/show

// Problems:
// - doesn't show the background through the scrollbar background

// Alternative Chrome extension to fix these problems:
// https://chrome.google.com/webstore/detail/minimal-scrollbar/ekopmclclddpoipchmcbhifohhbmjafd?hl=en
// https://github.com/iaarchiver/MinimalScrollbar

const rules = [
  `::-webkit-scrollbar {
    /* -webkit-appearance: none; */
    width: 10px;
    background-color: rgba(128, 128, 128, 0);
    transition: background-color 0.2s;
  }`,
  `::-webkit-scrollbar:hover {
    background-color: rgba(128, 128, 128, 0.2);
  }`,
  `::-webkit-scrollbar-thumb {
    border-radius: 10px;
    background-color: rgba(0, 0, 0, 0.3);
    box-shadow: 0 0 1px rgba(255, 255, 255, 0.5);
  }`,
  `::-webkit-scrollbar-thumb:hover {
    background-color: rgba(0, 0, 0, 0.5);
  }`,
];

const styleEl = document.createElement('style');
document.body.appendChild(styleEl);
rules.forEach((rule) => styleEl.sheet.insertRule(rule));
