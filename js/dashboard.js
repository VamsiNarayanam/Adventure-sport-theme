(function () {
  "use strict";

  var fontFamily = "'Inter', system-ui, sans-serif";
  var tickColor = "#5c6f7a";
  var gridColor = "rgba(148, 168, 180, 0.22)";

  function getStacklyUser() {
    try {
      var raw = sessionStorage.getItem("stacklyUser");
      return raw ? JSON.parse(raw) : null;
    } catch (err) {
      return null;
    }
  }

  function getUserInitials(name) {
    var parts = (name || "").trim().split(/\s+/).filter(Boolean);
    if (!parts.length) return "?";
    if (parts.length === 1) return parts[0].slice(0, 2).toUpperCase();
    return (parts[0].charAt(0) + parts[parts.length - 1].charAt(0)).toUpperCase();
  }

  function formatRoleLabel(role) {
    if (role === "admin") return "Administrator";
    if (role === "customer") return "Adventurer";
    return "User";
  }

  function initDashboardUser() {
    if (!document.body.classList.contains("dashboard-page")) return;

    var user = getStacklyUser();
    var displayName = user && user.name ? user.name : "";
    var displayEmail = user && user.email ? user.email : "";
    var displayRole = user && user.role ? formatRoleLabel(user.role) : "";

    document.querySelectorAll("[data-dash-user-name]").forEach(function (el) {
      if (displayName) el.textContent = displayName;
    });

    document.querySelectorAll("[data-dash-user-email]").forEach(function (el) {
      if (displayEmail) el.textContent = displayEmail;
    });

    document.querySelectorAll("[data-dash-user-role]").forEach(function (el) {
      if (displayRole) el.textContent = displayRole;
    });

    document.querySelectorAll("[data-dash-avatar]").forEach(function (el) {
      if (displayName) el.textContent = getUserInitials(displayName);
    });

    document.querySelectorAll("[data-dash-greeting]").forEach(function (el) {
      if (!displayName) return;
      var tail = el.textContent.replace(/^Welcome back[^.]*\.?\s*/i, "").trim();
      el.textContent = "Welcome back, " + displayName + (tail ? ". " + tail : ".");
    });

    var profileContact = document.querySelector("[data-dash-profile-contact]");
    if (profileContact && displayName && displayEmail) {
      profileContact.textContent = displayName + " · " + displayEmail;
    }

    var orgLabel = document.querySelector("[data-dash-org-label]");
    if (orgLabel && displayName && !document.body.classList.contains("dashboard-page--customer")) {
      var lastName = displayName.split(/\s+/).pop() || displayName;
      orgLabel.textContent = lastName + " workspace";
    }

    document.querySelectorAll("[data-dash-signout]").forEach(function (el) {
      el.addEventListener("click", function () {
        sessionStorage.removeItem("stacklyUser");
      });
    });
  }

  function initSidebar() {
    var toggle = document.querySelector("[data-dash-sidebar-toggle]");
    var sidebar = document.querySelector("[data-dash-sidebar]");
    var backdrop = document.querySelector("[data-dash-backdrop]");
    if (!toggle || !sidebar) return;

    function setOpen(open) {
      sidebar.classList.toggle("is-open", open);
      if (backdrop) backdrop.classList.toggle("is-open", open);
      toggle.setAttribute("aria-expanded", open ? "true" : "false");
      document.body.style.overflow = open ? "hidden" : "";
      window.dispatchEvent(new Event("resize"));
    }

    toggle.addEventListener("click", function () {
      setOpen(!sidebar.classList.contains("is-open"));
    });

    if (backdrop) {
      backdrop.addEventListener("click", function () {
        setOpen(false);
      });
    }

    sidebar.querySelectorAll("a").forEach(function (a) {
      a.addEventListener("click", function () {
        if (window.matchMedia("(max-width: 1024px)").matches) setOpen(false);
      });
    });

    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape") setOpen(false);
    });
  }

  function baseLegend() {
    return {
      position: "bottom",
      labels: {
        boxWidth: 10,
        padding: 16,
        font: { family: fontFamily, size: 11 },
        color: tickColor,
      },
    };
  }

  function initAdminCharts() {
    if (typeof Chart === "undefined") return;

    var amber = "#f59e0b";
    var amberLight = "#fbbf24";
    var ember = "#ea580c";
    var teal = "#14b8a6";

    var elSessions = document.getElementById("admin-chart-sessions");
    if (elSessions) {
      new Chart(elSessions, {
        type: "line",
        data: {
          labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
          datasets: [
            {
              label: "Active sessions",
              data: [118, 162, 198, 176, 214, 142, 128],
              borderColor: amber,
              backgroundColor: "rgba(245, 158, 11, 0.12)",
              fill: true,
              tension: 0.35,
              borderWidth: 2,
              pointRadius: 3,
              pointHoverRadius: 5,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          interaction: { intersect: false, mode: "index" },
          plugins: {
            legend: { display: false },
            tooltip: {
              titleFont: { family: fontFamily },
              bodyFont: { family: fontFamily },
            },
          },
          scales: {
            x: {
              grid: { color: gridColor },
              ticks: { font: { family: fontFamily, size: 11 }, color: tickColor },
            },
            y: {
              beginAtZero: true,
              grid: { color: gridColor },
              ticks: { font: { family: fontFamily, size: 11 }, color: tickColor },
            },
          },
        },
      });
    }

    var elStages = document.getElementById("admin-chart-stages");
    if (elStages) {
      new Chart(elStages, {
        type: "bar",
        data: {
          labels: ["New", "Confirmed", "Preparing", "In progress", "Completed", "Cancelled"],
          datasets: [
            {
              label: "Bookings",
              data: [28, 42, 24, 18, 14, 6],
              backgroundColor: [amberLight, amber, ember, teal, "#059669", "#94a3b8"],
              borderRadius: 6,
              borderSkipped: false,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { display: false },
            tooltip: {
              titleFont: { family: fontFamily },
              bodyFont: { family: fontFamily },
            },
          },
          scales: {
            x: {
              grid: { display: false },
              ticks: { font: { family: fontFamily, size: 11 }, color: tickColor },
            },
            y: {
              beginAtZero: true,
              grid: { color: gridColor },
              ticks: { font: { family: fontFamily, size: 11 }, color: tickColor },
            },
          },
        },
      });
    }

    var elChannels = document.getElementById("admin-chart-channels");
    if (elChannels) {
      new Chart(elChannels, {
        type: "doughnut",
        data: {
          labels: ["Organic search", "Referral", "Partner", "Events", "Direct"],
          datasets: [
            {
              data: [38, 24, 18, 12, 8],
              backgroundColor: [amber, ember, teal, amberLight, "#94a3b8"],
              borderWidth: 0,
              hoverOffset: 6,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          cutout: "58%",
          plugins: {
            legend: baseLegend(),
            tooltip: {
              titleFont: { family: fontFamily },
              bodyFont: { family: fontFamily },
            },
          },
        },
      });
    }

    var elLoad = document.getElementById("admin-chart-load");
    if (elLoad) {
      new Chart(elLoad, {
        type: "line",
        data: {
          labels: ["W1", "W2", "W3", "W4", "W5", "W6"],
          datasets: [
            {
              label: "Guide utilization %",
              data: [72, 78, 81, 76, 84, 79],
              borderColor: ember,
              backgroundColor: "rgba(234, 88, 12, 0.08)",
              fill: true,
              tension: 0.4,
              borderWidth: 2,
              pointRadius: 2,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { display: false },
            tooltip: {
              titleFont: { family: fontFamily },
              bodyFont: { family: fontFamily },
            },
          },
          scales: {
            x: {
              grid: { color: gridColor },
              ticks: { font: { family: fontFamily, size: 11 }, color: tickColor },
            },
            y: {
              min: 50,
              max: 100,
              grid: { color: gridColor },
              ticks: {
                font: { family: fontFamily, size: 11 },
                color: tickColor,
                callback: function (v) {
                  return v + "%";
                },
              },
            },
          },
        },
      });
    }
  }

  function initCustomerCharts() {
    if (typeof Chart === "undefined") return;

    var amber = "#f59e0b";
    var ember = "#ea580c";
    var teal = "#14b8a6";
    var amberSoft = "#fbbf24";

    var elMix = document.getElementById("customer-chart-status");
    if (elMix) {
      new Chart(elMix, {
        type: "polarArea",
        data: {
          labels: ["In progress", "Preparing", "Completed", "Scheduled"],
          datasets: [
            {
              data: [2, 1, 3, 1],
              backgroundColor: [
                "rgba(245, 158, 11, 0.75)",
                "rgba(234, 88, 12, 0.65)",
                "rgba(20, 184, 166, 0.7)",
                "rgba(251, 191, 36, 0.55)",
              ],
              borderWidth: 2,
              borderColor: "#fff",
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: baseLegend(),
            tooltip: {
              titleFont: { family: fontFamily },
              bodyFont: { family: fontFamily },
            },
          },
          scales: {
            r: {
              ticks: {
                display: false,
                backdropColor: "transparent",
              },
              grid: { color: gridColor },
            },
          },
        },
      });
    }

    var elPhases = document.getElementById("customer-chart-phases");
    if (elPhases) {
      new Chart(elPhases, {
        type: "bar",
        data: {
          labels: ["Gear prep", "Briefing", "Departure", "Summit"],
          datasets: [
            {
              label: "Completion",
              data: [100, 75, 25, 0],
              backgroundColor: [amber, ember, teal, amberSoft],
              borderRadius: 8,
              borderSkipped: false,
            },
          ],
        },
        options: {
          indexAxis: "y",
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { display: false },
            tooltip: {
              titleFont: { family: fontFamily },
              bodyFont: { family: fontFamily },
              callbacks: {
                label: function (ctx) {
                  return " " + ctx.raw + "% complete";
                },
              },
            },
          },
          scales: {
            x: {
              max: 100,
              grid: { color: gridColor },
              ticks: {
                font: { family: fontFamily, size: 11 },
                color: tickColor,
                callback: function (v) {
                  return v + "%";
                },
              },
            },
            y: {
              grid: { display: false },
              ticks: { font: { family: fontFamily, size: 11 }, color: tickColor },
            },
          },
        },
      });
    }
  }

  document.addEventListener("DOMContentLoaded", function () {
    initDashboardUser();
    initSidebar();
    if (document.body.classList.contains("dashboard-page--admin")) initAdminCharts();
    if (document.body.classList.contains("dashboard-page--customer")) initCustomerCharts();
  });
})();
