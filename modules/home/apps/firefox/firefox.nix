{
  inputs,
  lib,
  config,
  ...
}: {
  options = {
    firefox.enable = lib.mkEnableOption "Enable Firefox";
  };

  config = lib.mkIf config.firefox.enable {
    home.file.".mozilla/firefox/shizu/chrome".source = ./config/chrome;

    programs.firefox = {
      enable = true;
      profiles.shizu = {
        settings = {
          "browser.startup.page" = 3;
          "extensions.autoDisableScopes" = 0;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        };

        extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
          return-youtube-dislikes
          sponsorblock
          sidebery
          firefox-color
          ublock-origin
        ];
      };
    };
  };
}
