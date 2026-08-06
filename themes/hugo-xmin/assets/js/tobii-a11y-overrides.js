(() => {
  if (!('MutationObserver' in window)) return;
  const bg = document.querySelector('main, article');
  if (!bg) return;
  new MutationObserver(() => {
    bg.toggleAttribute('inert', document.body.classList.contains('tobii-is-open'));
  }).observe(document.body, { attributes: true, attributeFilter: ['class'] });
})();