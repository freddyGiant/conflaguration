{
  programs.firefox.enable = true;
  programs.firefox.languagePacks = [ "en-US" ];

  programs.firefox.profiles.default = {
    packages = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      multi-account-containers
      container-tab-groups
    ];

    extensions.settings."uBlock0@raymondhill.net".settings = {
      whitelist = [
        "aternos.org"
        "chrome-extension-scheme"
        "moz-extension-scheme"
        "www.adorama.com"
      ];

      selectedFilterLists = [
        "user-filters"
        "ublock-filters"
        "ublock-badware"
        "ublock-privacy"
        "ublock-quick-fixes"
        "ublock-unbreak"
        "ublock-experimental"
        "easylist"
        "adguard-generic"
        "adguard-mobile"
        "easyprivacy"
        "adguard-spyware-url"
        "block-lan"
        "urlhaus-1"
        "curben-phishing"
        "plowe-0"
        "dpollock-0"
        "fanboy-cookiemonster"
        "ublock-cookies-easylist"
        "adguard-cookies"
        "ublock-cookies-adguard"
        "fanboy-social"
        "adguard-social"
        "fanboy-thirdparty_social"
        "fanboy-ai-suggestions"
        "easylist-chat"
        "easylist-newsletters"
        "easylist-notifications"
        "easylist-annoyances"
        "adguard-mobile-app-banners"
        "adguard-other-annoyances"
        "adguard-popup-overlays"
        "adguard-widgets"
        "ublock-annoyances"
      ];

      userFilters = ''
        ! https://old.reddit.com/r/uBlockOrigin/wiki/solutions/youtube/

        ! YT Homepage and Subscriptions (Grid View) - Hide the Shorts section
        youtube.com##[is-shorts]
        ! YT Menu - Hide the Shorts button
        www.youtube.com###guide [title="Shorts"], .ytd-mini-guide-entry-renderer[title="Shorts"]
        ! YT Search - Hide Shorts
        www.youtube.com##ytd-search ytd-video-renderer:has([overlay-style="SHORTS"],[href^="/shorts/"])
        ! YT Search, Channels, Subscriptions (List View) and Sidebar/Below Player Recommendations - Hide the Shorts sections
        www.youtube.com##ytd-reel-shelf-renderer
        ! YT Channels - Hide the Shorts tab
        www.youtube.com##[tab-title="Shorts"]
        ! YT Subscriptions - Hide Shorts - Grid View
        www.youtube.com##ytd-browse[page-subtype="subscriptions"] ytd-grid-video-renderer:has([overlay-style="SHORTS"],[href^="/shorts/"])
        ! YT Subscriptions - Hide Shorts - List View
        www.youtube.com##ytd-browse[page-subtype="subscriptions"] ytd-video-renderer:has([overlay-style="SHORTS"],[href^="/shorts/"])
        ! YT Subscriptions - New Layout - Hide Shorts
        www.youtube.com##ytd-browse[page-subtype="subscriptions"] ytd-rich-item-renderer:has([overlay-style="SHORTS"],[href^="/shorts/"])
        ! YT Sidebar - Hide Shorts
        www.youtube.com###related :is(ytd-compact-video-renderer,yt-lockup-view-model):has([overlay-style="SHORTS"],[href^="/shorts/"])
        ! YT Home - No Videos
        www.youtube.com##ytd-browse[page-subtype="home"]
        ! YT Videos - No Sidebar
        www.youtube.com##ytd-watch-flexy #secondary

        ! YT Search - Keep only videos (no shorts), channels and playlists
        youtube.com##ytd-search ytd-item-section-renderer>#contents>:is(:not(ytd-video-renderer,ytd-channel-renderer,ytd-playlist-renderer,yt-lockup-view-model,yt-showing-results-for-renderer,[icon-name="promo-full-height:EMPTY_SEARCH"]),ytd-video-renderer:has([aria-label="Shorts"])),ytd-secondary-search-container-renderer

        ! Move homepage placeholders to the end
        www.youtube.com##ytd-browse[page-subtype="home"] :is(ytd-rich-grid-row, #contents.ytd-rich-grid-row):style(display: contents !important)
        ! Fixes grid alignment
        www.youtube.com##ytd-rich-item-renderer[rendered-from-rich-grid][is-in-first-column]:style(margin-left: calc(var(--ytd-rich-grid-item-margin)/2) !important)
        www.youtube.com##ytd-rich-grid-renderer>#contents:style(margin-left: calc(var(--ytd-rich-grid-gutter-margin)) !important)
        www.youtube.com###content.ytd-rich-section-renderer:style(margin-left: calc(var(--ytd-rich-grid-item-margin)/2) !important; margin-right: calc(var(--ytd-rich-grid-item-margin)*2.5) !important;)

        ! All YT players - No recommend after pause
        youtube-nocookie.com,youtube.com##.ytp-pause-overlay, .show-video-thumbnail-button
        ~youtube-nocookie.com,~youtube.com##iframe ~ #topvbar > #rvid

        ! Tumblr Desktop - Login wall
        ! https://github.com/uBlockOrigin/uAssets/issues/17115
        ! tumblr.com###glass-container:has-text(You need clearance for that)
        tumblr.com###glass-container
        tumblr.com##body:style(overflow: auto !important;)

        ! Jun 4, 2026 https://docs.google.com
        docs.google.com##.WithHideTransition.kixWizBarkickWrapper
      '';
    };

    # https://addons.mozilla.org/en-US/firefox/addon/tst-bookmarks-subpanel/
    # https://addons.mozilla.org/en-US/firefox/addon/tst-folder-expand-collapse/

    # https://searchfox.org/mozilla-central/rev/e3f42ec9320748b2aab3d474d1e47075def9000c/toolkit/components/search/SearchEngine.sys.mjs#890-923, apparently
    # ???
    # /**
    #   * Init from a JSON record.
    #   *
    #   * @param {object} json
    #   *   The json record to use.
    #   */
    #   _initWithJSON(json) {
    #     this.#id = json.id ?? this.#id;
    #     this._name = json._name;
    #     this._description = json.description;
    #     this._queryCharset =
    #       json.queryCharset || lazy.SearchUtils.DEFAULT_QUERY_CHARSET;
    #     this._iconMapObj = json._iconMapObj || null;
    #     this._metaData = json._metaData || {};
    #     this._orderHint = json._orderHint || null;
    #     this._definedAliases = json._definedAliases || [];
    #     // These changed keys in Firefox 80, maintain the old keys
    #     // for backwards compatibility.
    #     if (json._definedAlias) {
    #       this._definedAliases.push(json._definedAlias);
    #     }
    #     this._filePath = json.filePath || json._filePath || null;
    #
    #     for (let i = 0; i < json._urls.length; ++i) {
    #       let url = json._urls[i];
    #       let engineURL = new EngineURL(
    #         url.type || lazy.SearchUtils.URL_TYPE.SEARCH,
    #         url.method || "GET",
    #         url.template
    #       );
    #       engineURL._initWithJSON(url);
    #       this._urls.push(engineURL);
    #     }
    #   }
    search.engines = {
      "Nix Packages" = {
        urls = [{ template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; }];
        # urls = [{
        #   template = "https://search.nixos.org/packages";
        #   params = [
        #     { name = "channel"; value = "unstable"; }
        #     { name = "query";   value = "{searchTerms}"; }
        #   ];
        # }];
        # icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
      };

      "MyNixOS" = {
        urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
        definedAliases = [ "@mn" ];
      };

      "NixHub" = {
        urls = [{ template = "https://www.nixhub.io/search?q={searchTerms}"; }];
        definedAliases = [ "@nh" ];
      };
    };
  };

  # universal always-extensions
  programs.firefox.policies.ExtensionSettings = let
    moz = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
  in
  {
    "*".installation_mode = "blocked";

    "uBlock0@raymondhill.net" = {
      default_area = "navbar";
      install_url = moz "ublock-origin";
      installation_mode = "force_installed";
      private_browsing = true;
      # updates_disabled  = true;
    };

    "@testpilot-containers" = {
      default_area = "menupanel";
      install_url = moz "multi-account-containers";
      installation_mode = "force_installed";
      updates_disabled = true;
    }
  };

  programs.firefox.policies.EnableTrackingProtection = {
    Value = true;
    Cryptomining = true;
    Fingerprinting = true;
    Locked = true;
  };

  # disable bullshit
  programs.firefox.policies = {
    Cookies = {
      Behavior = "limit-foreign";
      BehaviorPrivateBrowsing = "limit-foreign";
      Locked = true;
    };

    SearchEngines.Add = [{
      Name = "Google Web";
      Alias = "web";
      URLTemplate = "https://www.google.com/search?udm=14&q={searchTerms}";
    }];
    SearchEngines.Default = "Google Web";
    SearchEngines.Remove = [ "amazon" "bing" "ebay" "perplexity" ];
    SearchEngines.PreventInstalls = true;

    NewTabPage = false;

    Homepage = {
      StartPage = "none";
      Locked = "true";
    };

    NoDefaultBookmarks = true;

    FirefoxSuggest = {
      WebSuggestions = false;
      SponsoredSuggestions = false;
      ImproveSuggest = false;
      Locked = true;
    };

    FirefoxHome = {
      Search = false;
      TopSites = false;
      SponsoredTopSites = false;
      Highlights = false;
      Pocket = false;
      Stories = false;
      SponsoredPocket = false;
      SponsoredStories = false;
      Snippets = false;
      Locked = true;
    };

    AIControls = {
      Default.Value = "blocked";
      Translations.Value = "blocked";
      PDFAltText.Value = "blocked";
      SmartTabGroups.Value = "blocked";
      LinkPreviewKeyPoints.Value = "blocked";
      SidebarChatbot.Value = "blocked";
      SmartWindow.Value = "blocked";

      Default.Locked = true;
      Translations.Locked = true;
      PDFAltText.Locked = true;
      SmartTabGroups.Locked = true;
      LinkPreviewKeyPoints.Locked = true;
      SidebarChatbot.Locked = true;
      SmartWindow.Locked = true;
    };

    GenerativeAI = {
      Enabled = false;
      Chatbot = false;
      LinkPreviews = false;
      TabGroups = false;
      Locked = true;
    };

    AppAutoUpdate                 = false;
    BackgroundAppUpdate           = false;
    OfferToSaveLogins             = false;
    AutofillAddressDisabled       = true;
    AutofillCreditCardDisabled    = true;
    DontCheckDefaultBrowser       = true;
    DisableFirefoxStudies         = true;
    DisableFirefoxAccounts        = true;
    DisableFirefoxScreenshots     = true;
    DisableForgetButton           = true;
    DisableMasterPasswordCreation = true;
    DisableProfileImport          = true;
    DisableProfileRefresh         = true;
    DisableRemoteImprovements     = true;
    DisableSetDesktopBackground   = true;
    DisablePocket                 = true;
    DisableTelemetry              = true;
    DisableFormHistory            = true;
    DisablePasswordReveal         = true;

    DisplayMenuBar                = "never";
    # HardwareAcceleration          = false;
    # DefaultDownloadDirectory      = "${home}/Downloads";
    # BlockAboutConfig              = false;
    # BlockAboutProfiles            = true;
    # BlockAboutSupport             = true;
    # DisableBuiltinPDFViewer       = true;
  };
}
