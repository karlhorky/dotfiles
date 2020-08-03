// ==UserScript==
// @name         Add TMDb links to IMDb
// @namespace    https://www.karlhorky.com/
// @version      1.0
// @description  Add links to themoviedb.org on IMDb pages
// @author       Karl Horky
// @match        https://www.imdb.com/title/*
// @grant        none
// ==/UserScript==

(function () {
  const h1 = document.querySelector('div.title_wrapper > h1');
  const movieTitle = h1.firstChild.nodeValue;

  fetch(
    `https://cors-anywhere.herokuapp.com/https://www.themoviedb.org/search/trending?query=${movieTitle}`,
  )
    .then((response) => response.json())
    .then((json) => {
      let linksHtml = '<h4 style="color: white">TMDb Results</h4>';
      json.results.forEach((result) => {
        if (typeof result === 'string') return;

        const {
          media_type: mediaType,
          id,
          title,
          name,
          release_date,
          first_air_date,
        } = result;

        const link = `https://www.themoviedb.org/${mediaType}/${id}`;

        linksHtml += `<div style="margin-bottom: 5px"><a href="${link}">${
          title || name
        } (${release_date || first_air_date})</a></div>`;
      });

      h1.insertAdjacentHTML('afterend', linksHtml + '<br />');
    });
})();
