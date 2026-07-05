let
in
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];

    # universal always-extensions
    policies.ExtensionSettings = let
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

    policies.EnableTrackingProtection = {
      Value = true;
      Cryptomining = true;
      Fingerprinting = true;
      Locked = true;
    };

    # disable bullshit
    policies = {
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
  };
}
