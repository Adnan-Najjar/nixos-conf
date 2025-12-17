{
  inputs,
  pkgs-unstable,
  user,
  ...
}:
{
  imports = [ inputs.zen-browser.homeModules.default ];
  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs-unstable.passff-host ];
    profiles.${user.username} = {
      id = 0;
      name = "${user.username}";
      path = "${user.username}.default";
      isDefault = true;
      settings = {
        "zen.welcome-screen.seen" = true;
        "zen.view.use-single-toolbar" = false;
        "zen.workspaces.continue-where-left-off" = true;
        "general.autoScroll" = true;
        "layout.css.always_underline_links" = true;
        "zen.view.show-newtab-button-top" = false;
        "zen.glance.activation-method" = "shift";
        "zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url" = true;
        "network.trr.mode" = 2;
        "network.trr.uri" = "https://firefox.dns.nextdns.io/";
      };
      search = {
        force = true;
        default = "Unduck";
        engines = {
          "Unduck" = {
            urls = [ { template = "https://unduck.link?q={searchTerms}"; } ];
          };
          "bing".metaData.hidden = true;
          "google".metaData.hidden = true;
          "ddg".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
        };
      };
    };
    policies = {
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      StartDownloadsInTempDirectory = true;
      ExtensionSettings =
        with builtins;
        let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "normal_installed";
            };
          };
        in
        listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "sponsorblock" "sponsorBlocker@ajay.app")
          (extension "youtube-recommended-videos" "myallychou@gmail.com")
          (extension "multi-account-containers" "@testpilot-containers")
          (extension "darkreader" "addon@darkreader.org")
          (extension "istilldontcareaboutcookies" "idcac-pub@guus.ninja")
          (extension "haramblur" "info@haramblur.com")
          (extension "simple-translate" "simple-translate@sienori")
          (extension "proton-vpn-firefox-extension" "vpn@proton.ch")
          (extension "passff" "passff@invicem.pro")
        ];
    };
  };
}
