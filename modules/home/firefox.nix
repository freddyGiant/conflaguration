let
  mozAddon = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
in
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];

    policies.Bookmarks = [
    ];

    ExtensionSettings."*".installation_mode = "blocked";

    # Feature Disabling
    # disable bullshit
    # policies.DisableBuiltinPDFViewer       = true;
    policies.AIControls = {
      Default.Value = "blocked";
      Translations.Value = "blocked";
      PDFAltText.Value = "blocked";
      SmartTabGroups.Value = "blocked";
      LinkPreviewKeyPoints.Value = "blocked";
      SidebarChatbot.Value = "blocked";
      SmartWindow.Value = "blocked";

      Default.Loacked = true;
      Translations.Loacked = true;
      PDFAltText.Loacked = true;
      SmartTabGroups.Loacked = true;
      LinkPreviewKeyPoints.Loacked = true;
      SidebarChatbot.Loacked = true;
      SmartWindow.Loacked = true;
    };

    policies.AppAutoUpdate                 = false;
    policies.BackgroundAppUpdate           = false;
    policies.DontCheckDefaultBrowser       = true;
    policies.OfferToSaveLogins             = false;
    policies.DisableFirefoxStudies         = true;
    policies.DisableFirefoxAccounts        = true;
    policies.DisableFirefoxScreenshots     = true;
    policies.DisableForgetButton           = true;
    policies.DisableMasterPasswordCreation = true;
    policies.DisableProfileImport          = true;
    policies.DisableProfileRefresh         = true;
    policies.DisableRemoteImprovements     = true;
    policies.DisableSetDesktopBackground   = true;
    policies.DisablePocket                 = true;
    policies.DisableTelemetry              = true;
    policies.DisableFormHistory            = true;
    policies.DisablePasswordReveal         = true;

    # Access Restrictions
    # policies.BlockAboutConfig              = false;
    # policies.BlockAboutProfiles            = true;
    # policies.BlockAboutSupport             = true;

    # UI and Behavior
    policies.DisplayMenuBar                = "never";
    # policies.HardwareAcceleration          = false;
    # policies.DefaultDownloadDirectory      = "${home}/Downloads";
  };
}
