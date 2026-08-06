(() => {
  const figures = document.querySelectorAll('figure');
  if (!figures.length) return;
  const load = () => {
    if (!document.querySelector('link[href*="tobii.min.css"]')) {
      for (const href of ['/vendor/tobii/tobii.min.css', '/vendor/tobii/tobii-a11y-overrides.css']) {
        const link = document.createElement('link');
        link.rel = 'stylesheet';
        link.href = href;
        document.head.appendChild(link);
      }
    }
    import('/vendor/tobii/tobii.min.js').then(() => new window.Tobii({ selector: '.lightbox' }));
  };
  if ('IntersectionObserver' in window) {
    new IntersectionObserver((es, o) => {
      for (const e of es) if (e.isIntersecting) { o.disconnect(); load(); break; }
    }, { rootMargin: '200px' }).observe(figures[0]);
  } else {
    load();
  }
})();