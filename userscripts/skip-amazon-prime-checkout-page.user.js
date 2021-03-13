// ==UserScript==
// @name         Skip Amazon Prime Checkout Page
// @description  Skip the page asking for customer to sign up to Amazon Prime checkout
// @version      1.0.1
// @author       Karl Horky
// @namespace    https://www.karlhorky.com/
// @match        https://www.amazon.de/gp/buy/primeinterstitial/handlers/display.html*
// @grant        none
// ==/UserScript==

// Click on "Continue and don't gain Amazon Prime benefits"
document.querySelector('.no-thanks-link > a.prime-nothanks-button').click();
