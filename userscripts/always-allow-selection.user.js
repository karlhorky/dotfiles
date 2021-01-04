// ==UserScript==
// @name         Always Allow Selection
// @namespace    https://www.karlhorky.com/
// @version      2.2
// @description  Disable user-select: none on all elements
// @author       Karl Horky
// @match        https://fuelcellsworks.com/*
// @grant        none
// ==/UserScript==

(function () {
  'use strict';
  const styleEl = document.createElement('style');
  document.body.appendChild(styleEl);
  styleEl.sheet.insertRule(
    '*, a, abbr, address, area, article, aside, audio, b, base, bdi, bdo, blockquote, body, br, button, canvas, caption, cite, code, col, colgroup, data, datalist, dd, del, details, dfn, dialog, div, dl, dt, em, embed, fieldset, figcaption, figure, footer, form, h1, h2, h3, h4, h5, h6, head, header, hgroup, hr, html, i, iframe, img, input, ins, kbd, label, legend, li, link, main, map, mark, math, menu, menuitem, meta, meter, nav, noscript, object, ol, optgroup, option, output, p, param, picture, pre, progress, q, rb, rp, rt, rtc, ruby, s, samp, script, section, select, slot, small, source, span, strong, style, sub, summary, sup, svg, table, tbody, td, template, textarea, tfoot, th, thead, time, title, tr, track, u, ul, var, video, wbr { user-select: auto !important; }',
  );
})();
