source "https://rubygems.org"

# This site is built by GitHub Actions, NOT by the classic GitHub Pages
# auto-build. That means we are not restricted to the `github-pages` gem's
# plugin whitelist, which later phases need (custom plugins + a PDF job).
gem "jekyll", "~> 4.3"

group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.17"
  gem "jekyll-sitemap", "~> 1.4"
end

# macOS system Ruby is too old for Jekyll 4. See README for `brew install ruby`.
gem "webrick", "~> 1.8"
gem "csv"
gem "base64"
gem "bigdecimal"
gem "logger"
