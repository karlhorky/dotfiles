// ==UserScript==
// @name         Highlight All Occurrences of Selected Text
// @description  Highlight all occurrences of any text that has been selected on the page
// @author       James Wilson, Karl Horky
// @namespace    https://www.karlhorky.com/
// @version      1.3.1
// @match        https://*/*
// @match        http://*/*
// @grant        none
// ==/UserScript==
//
// Copyright James Wilson / neaumusic 2019
//
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// Donate on PayPal to James Wilson: https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=L5G6ATNAMJHC4&currency_code=USD

const options = {
  isSelectionValid: function ({ selectionString, selection }) {
    return (
      selectionString.length >= 2 &&
      selection.type !== 'None' &&
      selection.type !== 'Caret'
    );
  },
  isWindowLocationValid: function (windowLocation) {
    const blacklistedHosts = [
      'localhost',
      'linkedin.com',
      'collabedit.com',
      'coderpad.io',
      'jsbin.com',
      'plnkr.co',
      'youtube.com',
      'notion.so',
      'codesandbox.io',
      'github1s.com',
      'track.toggl.com',
      'app.sqldbm.com',
    ];
    return !blacklistedHosts.some((h) => windowLocation.host.includes(h));
  },
  areKeysPressed: function (pressedKeys = []) {
    // return pressedKeys.includes('Meta'); // CMD key
    // return pressedKeys.includes('Alt'); // Option key
    return true;
  },
  occurrenceRegex: function (selectionString) {
    return new RegExp(selectionString, 'i'); // partial word, case insensitive
    // return new RegExp(selectionString); // partial word, case sensitive
    // return new RegExp(`\\b${selectionString}\\b`, 'i'); // whole word, case insensitive
    // return new RegExp(`\\b${selectionString}\\b`); // whole word, case sensitive
  },
  isAncestorNodeValid: function isAncestorNodeValid(ancestorNode) {
    return (
      !ancestorNode ||
      ((!ancestorNode.classList ||
        !ancestorNode.classList.contains('CodeMirror')) &&
        ancestorNode.nodeName !== 'SCRIPT' &&
        ancestorNode.nodeName !== 'STYLE' &&
        ancestorNode.nodeName !== 'HEAD' &&
        ancestorNode.nodeName !== 'TITLE' &&
        ancestorNode.nodeName !== 'INPUT' &&
        ancestorNode.nodeName !== 'TEXTAREA' &&
        ancestorNode.contentEditable !== 'true' &&
        isAncestorNodeValid(ancestorNode.parentNode))
    );
  },
  trimRegex: function () {
    // leading, selectionString, trailing
    // trim parts maintained for offset analysis
    return /^(\s*)(\S+(?:\s+\S+)*)(\s*)$/;
  },
  highlightedClassName: 'highlighted_selection',
  styles: {
    backgroundColor: 'rgb(255,255,0,1)', // yellow 100%
    margin: '0',
    padding: '0',
    lineHeight: '1',
    // display: 'inline',
  },
  areScrollMarkersEnabled: function () {
    return true;
  },
  scrollMarkerClassName: 'highlighted_selection_scroll_marker',
  scrollMarkerStyles: function ({ window, document, highlightedNode }) {
    const clientRect = highlightedNode.getBoundingClientRect();
    if (!clientRect.width || !clientRect.height) {
      return false;
    }

    return {
      height: '2px',
      width: '16px',
      boxSizing: 'content-box',
      border: '1px solid grey',
      position: 'fixed',
      top:
        // window height times percent of element position in document
        (window.innerHeight *
          (+window.scrollY +
            clientRect.top +
            0.5 * (clientRect.top - clientRect.bottom))) /
          document.body.clientHeight +
        'px',
      right: '0px',
      backgroundColor: 'yellow',
      zIndex: '2147483647',
    };
  },
};

const highlightedMarkTemplate = document.createElement('mark');
highlightedMarkTemplate.className = options.highlightedClassName;
Object.entries(options.styles).forEach(([styleName, styleValue]) => {
  highlightedMarkTemplate.style[styleName] = styleValue;
});

const pressedKeys = [];
document.addEventListener('keydown', (e) => {
  const index = pressedKeys.indexOf(e.key);
  if (index === -1) {
    pressedKeys.push(e.key);
  }
});
document.addEventListener('keyup', (e) => {
  const index = pressedKeys.indexOf(e.key);
  if (index !== -1) {
    pressedKeys.splice(index, 1);
  }
});
window.addEventListener('blur', (e) => {
  pressedKeys.splice(0, pressedKeys.length);
});

document.addEventListener('selectionchange', onSelectionChange);

let latestStartTime = null;
function onSelectionChange(e) {
  latestStartTime = performance.now();

  if (!options.isWindowLocationValid(window.location)) return;
  if (!options.areKeysPressed(pressedKeys)) return;

  document
    .querySelectorAll('.' + options.highlightedClassName)
    .forEach((element) => {
      const parent = element.parentNode;
      if (parent) {
        parent.replaceChild(new Text(element.textContent || ''), element);
        parent.normalize();
      }
    });
  if (options.areScrollMarkersEnabled()) {
    document
      .querySelectorAll('.' + options.scrollMarkerClassName)
      .forEach((element) => {
        document.body.removeChild(element);
      });
  }

  highlight(latestStartTime);
}

function highlight(startTime) {
  const selection = document.getSelection();
  const trimmedSelection = String(selection).match(options.trimRegex());
  if (!trimmedSelection) return;

  const leadingSpaces = trimmedSelection[1];
  const selectionString = trimmedSelection[2];
  const trailingSpaces = trimmedSelection[3];
  if (!options.isSelectionValid({ selectionString, selection })) return;

  // https://stackoverflow.com/questions/3561493/is-there-a-regexp-escape-function-in-javascript
  const occurrenceRegex = options.occurrenceRegex(
    selectionString.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&'),
  );

  const allTextNodes = [];
  const treeWalker = document.createTreeWalker(
    document.body,
    NodeFilter.SHOW_TEXT,
    null,
    false,
  );
  while (treeWalker.nextNode()) {
    allTextNodes.push(treeWalker.currentNode);
  }

  for (let i = 0; i < allTextNodes.length; i++) {
    const textNode = allTextNodes[i];
    const parent = textNode.parentNode;
    const highlightedNodes = highlightOccurrences(textNode);
    if (highlightedNodes) {
      if (parent) parent.normalize();
    }
  }

  if (options.areScrollMarkersEnabled()) {
    requestAnimationFrame(() => {
      if (startTime !== latestStartTime) return;

      const highlighted = document.querySelectorAll(
        '.' + options.highlightedClassName,
      );
      const scrollMarkersFragment = document.createDocumentFragment();

      for (let i = 0; i < highlighted.length; i++) {
        setTimeout(() => {
          if (startTime !== latestStartTime) return;

          const highlightedNode = highlighted[i];
          const scrollMarker = document.createElement('div');
          scrollMarker.className = options.scrollMarkerClassName;
          const scrollMarkerStyles = options.scrollMarkerStyles({
            window,
            document,
            highlightedNode,
          });
          if (scrollMarkerStyles) {
            Object.entries(scrollMarkerStyles).forEach(
              ([styleName, styleValue]) => {
                scrollMarker.style[styleName] = styleValue;
              },
            );
            scrollMarkersFragment.appendChild(scrollMarker);
          }
        }, 0);
      }

      setTimeout(() => {
        if (startTime === latestStartTime) {
          document.body.appendChild(scrollMarkersFragment);
        }
      }, 0);
    });
  }

  function highlightOccurrences(textNode) {
    const match = occurrenceRegex.exec(textNode.data);
    if (!match) return;
    if (!options.isAncestorNodeValid(textNode.parentNode)) return;

    const matchIndex = match.index;
    const anchorToFocusDirection = selection.anchorNode.compareDocumentPosition(
      selection.focusNode,
    );
    const isUsersSelection =
      anchorToFocusDirection & Node.DOCUMENT_POSITION_FOLLOWING
        ? (textNode === selection.anchorNode &&
            ((selection.anchorNode.nodeType === Node.ELEMENT_NODE &&
              selection.anchorOffset === 0) ||
              selection.anchorOffset === matchIndex - leadingSpaces.length)) ||
          (textNode === selection.focusNode &&
            ((selection.focusNode.nodeType === Node.ELEMENT_NODE &&
              selection.focusOffset === 0) ||
              selection.focusOffset ===
                matchIndex + selectionString.length + trailingSpaces.length)) ||
          (textNode !== selection.anchorNode &&
            textNode !== selection.focusNode &&
            selection.anchorNode.compareDocumentPosition(textNode) &
              Node.DOCUMENT_POSITION_FOLLOWING &&
            selection.focusNode.compareDocumentPosition(textNode) &
              Node.DOCUMENT_POSITION_PRECEDING)
        : anchorToFocusDirection & Node.DOCUMENT_POSITION_PRECEDING
        ? (textNode === selection.anchorNode &&
            ((selection.anchorNode.nodeType === Node.ELEMENT_NODE &&
              selection.anchorOffset === 0) ||
              (selection.anchorNode.nodeType === Node.TEXT_NODE &&
                selection.anchorOffset ===
                  matchIndex +
                    selectionString.length +
                    trailingSpaces.length))) ||
          (textNode === selection.focusNode &&
            ((selection.focusNode.nodeType === Node.ELEMENT_NODE &&
              selection.focusOffset === 0) ||
              selection.focusOffset === matchIndex - leadingSpaces.length)) ||
          (textNode !== selection.anchorNode &&
            textNode !== selection.focusNode &&
            selection.anchorNode.compareDocumentPosition(textNode) &
              Node.DOCUMENT_POSITION_PRECEDING &&
            selection.focusNode.compareDocumentPosition(textNode) &
              Node.DOCUMENT_POSITION_FOLLOWING)
        : (selection.anchorOffset < selection.focusOffset &&
            textNode === selection.anchorNode &&
            selection.anchorOffset === matchIndex - leadingSpaces.length) ||
          (selection.anchorOffset > selection.focusOffset &&
            textNode === selection.focusNode &&
            selection.focusOffset === matchIndex - leadingSpaces.length);
    if (!isUsersSelection) {
      const trimmedTextNode = textNode.splitText(matchIndex);
      const remainingTextNode = trimmedTextNode.splitText(
        selectionString.length,
      );
      const highlightedNode = highlightedMarkTemplate.cloneNode(true);
      highlightedNode.appendChild(trimmedTextNode.cloneNode(true));

      const parent = trimmedTextNode.parentNode;
      if (parent) parent.replaceChild(highlightedNode, trimmedTextNode);

      const otherHighlightedNodes =
        highlightOccurrences(remainingTextNode) || [];
      return [highlightedNode].concat(otherHighlightedNodes);
    } else {
      const clonedNode = textNode.cloneNode();
      const remainingClonedTextNode = clonedNode.splitText(
        matchIndex + selectionString.length,
      );
      if (occurrenceRegex.exec(remainingClonedTextNode.data))
        return highlightOccurrences(
          textNode.splitText(matchIndex + selectionString.length),
        );
    }
  }
}
