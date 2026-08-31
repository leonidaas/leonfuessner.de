// Load self-hosted KaTeX only when the page actually contains math.
// The site never requests a CDN. Paths come from data-* on this script tag
// (layouts keep relative_url). Webfonts are not part of the vendor set.

(function () {
  var script = document.currentScript || document.querySelector("script[data-katex-js]");
  if (!script) return;

  var root = document.querySelector(".post-body") || document.querySelector("main");
  if (!root) return;

  function hasMath(node) {
    var walker = document.createTreeWalker(node, NodeFilter.SHOW_TEXT, {
      acceptNode: function (n) {
        var el = n.parentElement;
        if (!el || el.closest("pre, code, script, style, textarea, kbd")) {
          return NodeFilter.FILTER_REJECT;
        }
        var t = n.nodeValue;
        if (!t) return NodeFilter.FILTER_REJECT;
        if (/\$\$[\s\S]+?\$\$/.test(t)) return NodeFilter.FILTER_ACCEPT;
        if (/(^|[^\\])\$[^$\n]+\$/.test(t)) return NodeFilter.FILTER_ACCEPT;
        return NodeFilter.FILTER_REJECT;
      }
    });
    return walker.nextNode() !== null;
  }

  if (!hasMath(root)) return;

  var cssHref = script.getAttribute("data-katex-css");
  var jsHref = script.getAttribute("data-katex-js");
  var autoHref = script.getAttribute("data-katex-auto");
  if (!cssHref || !jsHref || !autoHref) return;

  var link = document.createElement("link");
  link.rel = "stylesheet";
  link.href = cssHref;
  document.head.appendChild(link);

  function load(src) {
    return new Promise(function (resolve, reject) {
      var s = document.createElement("script");
      s.src = src;
      s.onload = resolve;
      s.onerror = reject;
      document.head.appendChild(s);
    });
  }

  load(jsHref)
    .then(function () { return load(autoHref); })
    .then(function () {
      if (typeof renderMathInElement !== "function") return;
      renderMathInElement(root, {
        delimiters: [
          { left: "$$", right: "$$", display: true },
          { left: "$", right: "$", display: false }
        ],
        throwOnError: false,
        ignoredTags: ["script", "noscript", "style", "textarea", "pre", "code", "kbd"]
      });
    })
    .catch(function () { /* math is progressive enhancement */ });
})();
