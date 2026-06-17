$root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not (Test-Path (Join-Path $root "index.html"))) {
  $root = Split-Path -Parent $PSScriptRoot
}

function Get-HeaderHtml([string]$homeHref) {
  @"
  <header class="site-header site-header--pro" id="site-header" data-header>
    <div class="container site-header__inner">
      <a class="logo logo--pro" href="$homeHref" aria-label="Stackly Adventure home">
        <img class="logo__img" src="images/stackly-adventure.svg" alt="Stackly Adventure" width="180" height="44" decoding="async">
      </a>
      <button type="button" class="nav-toggle" id="nav-toggle" aria-expanded="false" aria-controls="nav-wrap" aria-label="Open menu">
        <span class="nav-toggle__bar"></span>
        <span class="nav-toggle__bar"></span>
        <span class="nav-toggle__bar"></span>
      </button>
      <div class="site-header__nav-wrap" id="nav-wrap">
        <div class="site-header__nav-inner">
          <nav class="site-header__nav" aria-label="Main navigation">
            <ul class="nav-list">
              <li><a class="nav-link" href="$homeHref" data-nav-file="index.html">Home</a></li>
              <li><a class="nav-link" href="about.html" data-nav-file="about.html">About</a></li>
              <li><a class="nav-link" href="services.html" data-nav-file="services.html">Adventures</a></li>
              <li><a class="nav-link" href="pricing.html" data-nav-file="pricing.html">Pricing</a></li>
              <li><a class="nav-link" href="contact.html" data-nav-file="contact.html">Contact</a></li>
            </ul>
          </nav>
          <div class="site-header__actions">
            <a class="btn btn--nav-login" href="login.html" data-nav-file="login.html">Login</a>
            <a class="btn btn--nav-register" href="contact.html">Book Expedition</a>
          </div>
        </div>
      </div>
    </div>
  </header>
"@
}

$footerHtml = @'
  <footer class="footer-premium footer-premium--pro" id="site-footer">
    <div class="footer-premium__cta">
      <div class="container footer-premium__cta-inner">
        <div>
          <p class="footer-premium__cta-kicker">Ready for the wild?</p>
          <h2>Your next expedition starts here</h2>
        </div>
        <a class="btn btn--primary" href="contact.html">Book Expedition</a>
      </div>
    </div>
    <div class="container footer-premium__grid">
      <div class="footer-brand">
        <a class="logo logo--pro" href="index.html" aria-label="Stackly Adventure home">
          <img class="logo__img" src="images/stackly-adventure.svg" alt="Stackly Adventure" width="180" height="44" decoding="async">
        </a>
        <p>Premium adventure sports—rock climbing, hiking, kayaking, trail running, camping, and alpine expeditions—guided by experts who live for the wild.</p>
        <div class="footer-social">
          <a href="404.html" aria-label="LinkedIn"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/></svg></a>
          <a href="404.html" aria-label="Twitter"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg></a>
          <a href="404.html" aria-label="Facebook"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M22.675 0H1.325C.593 0 0 .593 0 1.325v21.351C0 23.407.593 24 1.325 24H12.82v-9.294H9.692v-3.622h3.128V8.413c0-3.1 1.893-4.788 4.659-4.788 1.325 0 2.463.099 2.795.143v3.24l-1.918.001c-1.504 0-1.795.715-1.795 1.763v2.313h3.587l-.467 3.622h-3.12V24h6.116c.73 0 1.323-.593 1.323-1.325V1.325C24 .593 23.407 0 22.675 0z"/></svg></a>
          <a href="404.html" aria-label="Instagram"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zM12 0C8.741 0 8.333.014 7.053.072 2.695.272.273 2.69.073 7.052.014 8.333 0 8.741 0 12c0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98C15.668.014 15.259 0 12 0zm0 5.838a6.162 6.162 0 100 12.324 6.162 6.162 0 000-12.324zM12 16a4 4 0 110-8 4 4 0 010 8zm6.406-11.845a1.44 1.44 0 110 2.881 1.44 1.44 0 010-2.881z"/></svg></a>
        </div>
      </div>
      <div>
        <h4>Company</h4>
        <ul>
          <li><a href="about.html">About</a></li>
          <li><a href="services.html">Adventures</a></li>
          <li><a href="pricing.html">Pricing</a></li>
          <li><a href="contact.html">Contact</a></li>
          <li><a href="login.html">Adventurer login</a></li>
        </ul>
      </div>
      <div>
        <h4>Adventures</h4>
        <ul>
          <li><a href="services.html#rock-climbing">Rock Climbing</a></li>
          <li><a href="services.html#mountain-hiking">Mountain Hiking</a></li>
          <li><a href="services.html#kayaking">Kayaking</a></li>
          <li><a href="services.html#trail-running">Trail Running</a></li>
          <li><a href="services.html#alpine-trek">Alpine Trek</a></li>
        </ul>
      </div>
      <div class="footer-contact">
        <h4>Contact</h4>
        <address class="footer-contact__addr">
          <p class="footer-contact__row footer-contact__row--email">
            <a href="mailto:hello@stacklyadventure.com" class="footer-contact__email">
              <svg class="footer-contact__icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><path d="m22 6-10 7L2 6"/></svg>
              hello@stacklyadventure.com
            </a>
          </p>
          <p class="footer-contact__row footer-contact__row--phone">
            <a href="tel:+18005551234" class="footer-contact__email">
              <svg class="footer-contact__icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
              +1 (800) 555-1234
            </a>
          </p>
          <p class="footer-contact__row footer-contact__row--location">
            <span class="footer-contact__loc">
              <svg class="footer-contact__icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
              <span class="footer-contact__loc-text">Begur Road, Bangalore 560068</span>
            </span>
          </p>
        </address>
      </div>
    </div>
    <div class="footer-bar">
      <div class="container footer-bar__inner">
        <p>&copy; <span data-year></span> Stackly Adventure. All rights reserved.</p>
        <nav class="footer-bar__legal" aria-label="Legal">
          <a href="404.html">Privacy</a>
          <a href="404.html">Terms</a>
          <a href="404.html">Safety policy</a>
        </nav>
      </div>
    </div>
  </footer>
'@

$publicPages = @(
  @{ File = "index.html"; Home = "#hero" },
  @{ File = "about.html"; Home = "index.html" },
  @{ File = "services.html"; Home = "index.html" },
  @{ File = "pricing.html"; Home = "index.html" },
  @{ File = "contact.html"; Home = "index.html" },
  @{ File = "login.html"; Home = "index.html" },
  @{ File = "register.html"; Home = "index.html" },
  @{ File = "404.html"; Home = "index.html" }
)

foreach ($page in $publicPages) {
  $path = Join-Path $root $page.File
  if (-not (Test-Path $path)) { continue }
  $html = Get-Content -Path $path -Raw -Encoding UTF8

  $html = $html -replace 'images/stackly-adventure\.webp', 'images/stackly-adventure.svg'
  $html = $html -replace 'SummitForge', 'Stackly Adventure'
  $html = $html -replace 'expeditions@summitforge\.com', 'hello@stacklyadventure.com'
  $html = $html -replace 'Join the Stackly Adventure dispatch', 'Join the Stackly Adventure dispatch'

  $header = Get-HeaderHtml $page.Home
  if ($page.File -eq "index.html") {
    $html = $html -replace '(?s)<header class="site-header[^"]*"[^>]*>.*?</header>', $header
    $html = $html -replace 'data-section="hero"\s*', ''
  } else {
    $html = $html -replace '(?s)<header class="site-header[^"]*"[^>]*>.*?</header>', $header
  }

  $html = $html -replace '(?s)<footer class="footer-premium[^"]*"[^>]*>.*?</footer>', $footerHtml

  [System.IO.File]::WriteAllText($path, $html, [System.Text.UTF8Encoding]::new($false))
  Write-Host "Updated $($page.File)"
}


foreach ($dash in @("admin-dashboard.html", "customer-dashboard.html")) {
  $path = Join-Path $root $dash
  if (Test-Path $path) {
    $html = Get-Content -Path $path -Raw -Encoding UTF8
    $html = $html -replace 'images/stackly-adventure\.webp', 'images/stackly-adventure.svg'
    $html = $html -replace 'SummitForge', 'Stackly Adventure'
    [System.IO.File]::WriteAllText($path, $html, [System.Text.UTF8Encoding]::new($false))
    Write-Host "Updated $dash"
  }
}

Write-Host "Done."
