// ==UserScript==
// @name         Repeat last Seitenbacher order
// @description  Login to your account and repeats the last order, allowing confirmation
// @version      1.0.0
// @author       Karl Horky
// @namespace    https://www.karlhorky.com/
// @match        https://www.seitenbacher.de/*
// @grant        GM_getValue
// @grant        GM_setValue
// ==/UserScript==

const currentStep = GM_getValue('currentStep', 'showButton');

if (currentStep === 'showButton') {
  const buttonEl = document.createElement('button');

  buttonEl.innerHTML = 'Repeat last order';
  buttonEl.style = 'float: right; margin-top: 8px';

  buttonEl.onclick = async function buttonOnclick() {
    document
      .querySelector('#block-menu-menu-sb-user-menu > .menu .login')
      .click();
    await new Promise((resolve) => window.setTimeout(resolve, 200));
    document.querySelector('#user-login-form button[type="submit"]').click();
    GM_setValue('currentStep', 'navigateToOrders');
  };

  const topMenu = document.querySelector('.sticky-menu--wrapper > .menu');
  topMenu.append(buttonEl);
} else if (currentStep === 'navigateToOrders') {
  window.location.href = window.location.href.replace(/\/edit$/, '/orders');
  GM_setValue('currentStep', 'viewLastOrder');
} else if (currentStep === 'viewLastOrder') {
  document
    .querySelector(
      '.region--user-content .views-table > tbody > tr:first-child a',
    )
    .click();
  GM_setValue('currentStep', 'repeatOrder');
} else if (currentStep === 'repeatOrder') {
  window.location.href = window.location.href + '/reorder';
  GM_setValue('currentStep', 'autoConfirmRepeatOrder');
} else if (currentStep === 'autoConfirmRepeatOrder') {
  document
    .querySelector('.confirmation.sb-order-reorder-form button[type="submit"]')
    .click();
  GM_setValue('currentStep', 'manualConfirmRepeatOrder');
} else if (currentStep === 'manualConfirmRepeatOrder') {
  window.addEventListener('load', () => {
    if (window.confirm('Reorder last order below?')) {
      document
        .querySelector(
          '.views-form-commerce-cart-form-default button#edit-checkout[type="submit"]',
        )
        .click();
      GM_setValue('currentStep', 'acceptTermsAndBuy');
    } else {
      document
        .querySelector(
          '.views-form-commerce-cart-form-default button.delete-line-item[type="submit"]',
        )
        .click();
      GM_setValue('currentStep', 'showButton');
    }
  });
} else if (currentStep === 'acceptTermsAndBuy') {
  const longCheckoutButton =
    document.querySelector(
      '.commerce-checkout-form-checkout button.button-continue[type="submit"]',
    ) ||
    document.querySelector(
      '.commerce-checkout-form-address-data button.button-continue[type="submit"]',
    ) ||
    document.querySelector(
      '.commerce-checkout-form-shipping button.button-continue[type="submit"]',
    );

  if (longCheckoutButton) {
    longCheckoutButton.click();
    return;
  }

  document
    .querySelector(
      '.commerce-checkout-form-review input#edit-sb-checkout-agb-agb',
    )
    .click();
  document
    .querySelector(
      '.commerce-checkout-form-review button.button-continue[type="submit"]',
    )
    .click();
  GM_setValue('currentStep', 'showButton');
}
