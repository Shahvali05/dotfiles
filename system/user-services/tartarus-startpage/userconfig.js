let saved_config = JSON.parse(localStorage.getItem("CONFIG"));

const default_config = {
  overrideStorage: true,
  temperature: {
    location: 'Matão, São Paulo',
    scale: "C",
  },
  clock: {
    format: "h:i p",
    iconColor: "#ea6962",
  },
  search: {
    engines: {
      g: ["https://google.com/search?q=", "Google"],
      d: ["https://duckduckgo.com/html?q=", "DuckDuckGo"],
      y: ["https://youtube.com/results?search_query=", "Youtube"],
      r: ["https://www.reddit.com/search/?q=", "Reddit"],
      p: ["https://www.pinterest.es/search/pins/?q=", "Pinterest"],
    },
  },
  keybindings: {
    "s": "search-bar",
    "q": "config-tab",
  },
  disabled: [],
  localIcons: false,
  fastlink: "https://habitica.com",
  openLastVisitedTab: true,
  tabs: [
    {
      name: "home",
      background_url: "src/img/banners/cbg-2.gif",
      categories: [{
        name: "Video",
        links: [
          {
            name: "youtube",
            url: "https://www.youtube.com/",
            icon: "brand-youtube-filled",
            icon_color: "#ea6962",
          },
          {
            name: "twitch",
            url: "https://www.twitch.tv/",
            icon: "brand-twitch",
            icon_color: "#d3869b",
          },
        ],
      }, {
        name: "Programming",
        links: [
          {
            name: "github",
            url: "https://github.com/",
            icon: "brand-github",
            icon_color: "#7daea3",
          },
          {
            name: "edu",
            url: "https://edu.21-school.ru",
            icon: "school",
            icon_color: "#a9b665",
          },
          {
            name: "rocket",
            url: "https://rocketchat-student.21-school.ru",
            icon: "rocket",
            icon_color: "#DC455C",
          },
        ],
      }, {
        name: "AI",
        links: [
          {
            name: "chatgpt",
            url: "https://chatgpt.com",
            icon: "brand-openai",
            icon_color: "#89b482",
          },
          {
            name: "grok",
            url: "https://grok.com",
            icon: "planet",
            icon_color: "#1C0B13",
          },
          {
            name: "notebooklm",
            url: "https://notebooklm.google.com",
            icon: "notebook",
            icon_color: "#3BD25C",
          },
        ],
      }],
    },
    {
      name: "infra",
      background_url: "src/img/banners/cbg-6.gif",
      categories: [
        {
          name: "communication",
          links: [
            {
              name: "discord",
              url: "https://discord.com/channels/@me",
              icon: "brand-discord-filled",
              icon_color: "#4D59D5",
            },
          ],
        },
        {
          name: "Hosting & Domains",
          links: [
            {
              name: "PQH",
              url: "https://bill.pq.hosting/billmgr?startform=dashboard",
              icon: "server",
              icon_color: "#172D6A",
            },
            {
              name: "zetalink",
              url: "https://bill.zetalink.ru",
              icon: "cloud",
              icon_color: "#120853",
            },
            {
              name: "domain",
              url: "https://cp.sweb.ru/domains/my_domains",
              icon: "spider",
              icon_color: "#2B79D4",
            },
            {
              name: "MCPE",
              url: "https://panel.mcpehost.ru/user/detail",
              icon: "brand-minecraft",
              icon_color: "#8F5B35",
            },
          ],
        },
        {
          name: "courses",
          links: [
            {
              name: "karpov",
              url: "https://lab.karpov.courses/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHBfaWQiOiI1MDNmYmVjYy1iZjYwLTQ5MmMtYThjNy04ZTdlZWE5ZmJmMmIiLCJ0cyI6MTczNTMwNTY2MiwiYWN0aW9uIjoiaXNzdWVfY29va2llIiwidXNlcl9pZCI6NjcxNTB9.zlOdOge0aVk6bGloGeudp0hlKttQwIOzZIb-RL0_QBc",
              icon: "math-1-divide-3",
              icon_color: "#E85037",
            },
            {
              name: "po-arabski",
              url: "https://po-arabski.ru",
              icon: "moon",
              icon_color: "#0AABB1",
            },
          ],
        },
      ],
    },
    {
      name: "dev",
      background_url: "src/img/banners/cbg-7.gif",
      categories: [
        {
          name: "linux",
          links: [
            {
              name: "flathub",
              url: "https://flathub.org",
              icon: "icons",
              icon_color: "#E8E5EB",
            },
            {
              name: "nerdfonts",
              url: "https://www.nerdfonts.com",
              icon: "sunglasses",
              icon_color: "#E0B537",
            },
            {
              name: "explainshell",
              url: "https://explainshell.com",
              icon: "brand-tabler",
              icon_color: "#4D83D6",
            },
            {
              name: "nix search",
              url: "https://search.nixos.org",
              icon: "settings",
              icon_color: "#3F5C96",
            },
          ],
        },
        {
          name: "challenges",
          links: [
            {
              name: "hackthebox",
              url: "https://app.hackthebox.com",
              icon: "box",
              icon_color: "#a9b665",
            },
            {
              name: "cryptohack",
              url: "https://cryptohack.org/challenges/",
              icon: "brain",
              icon_color: "#e78a4e",
            },
            {
              name: "tryhackme",
              url: "https://tryhackme.com/dashboard",
              icon: "brand-onedrive",
              icon_color: "#ea6962",
            },
            {
              name: "hackerrank",
              url: "https://www.hackerrank.com/dashboard",
              icon: "code-asterix",
              icon_color: "#a9b665",
            },
          ],
        },
        {
          name: "shops",
          links: [
            {
              name: "AliExpress",
              url: "https://aliexpress.ru",
              icon: "shopping-bag",
              icon_color: "#DF221E",
            },
          ],
        },
      ],
    },
    {
      name: "myself",
      background_url: "src/img/banners/cbg-9.gif",
      categories: [
        {
          name: "mails",
          links: [
            {
              name: "gmail",
              url: "https://mail.google.com/mail/u/0/",
              icon: "brand-gmail",
              icon_color: "#ea6962",
            },
          ],
        },
        {
          name: "storage",
          links: [
            {
              name: "drive",
              url: "https://drive.google.com/drive/u/0/my-drive",
              icon: "brand-google-drive",
              icon_color: "#e78a4e",
            },
            {
              name: "dropbox",
              url: "https://www.dropbox.com/h?role=personal&di=left_nav",
              icon: "box-seam",
              icon_color: "#7daea3",
            },
            {
              name: "fotos",
              url: "https://photos.google.com/u/1",
              icon: "photo-filled",
              icon_color: "#ea6962",
            },
          ],
        },
        {
          name: "stuff",
          links: [
            {
              name: "linkedin",
              url: "https://www.linkedin.com/feed/",
              icon: "brand-linkedin",
              icon_color: "#7daea3",
            },
            {
              name: "upwork",
              url: "https://www.upwork.com",
              icon: "brand-upwork",
              icon_color: "#0F0F0F",
            },
          ],
        },
      ],
    },
  ],
};

const CONFIG = new Config(saved_config ?? default_config);
// const CONFIG = new Config(default_config);

(function() {
  var css = document.createElement('link');
  css.href = 'src/css/tabler-icons.min.css';
  css.rel = 'stylesheet';
  css.type = 'text/css';
  if (!CONFIG.config.localIcons)
    document.getElementsByTagName('head')[0].appendChild(css);
})();
