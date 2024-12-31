{
  inputs,
  lib,
  config,
  ...
}:

{
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

        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          return-youtube-dislikes
          sponsorblock
          sidebery
          firefox-color
          ublock-origin
        ];


        bookmarks = [
          {
            name = "Toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "Main";
                bookmarks = [
                  {
                    name = "Streaming";
                    bookmarks = [
                    { name = "Youtube"; url = "https://www.youtube.com/"; }
                    { name = "h!anime"; url = "https://hianime.to/home"; }
                    { name = "Netflix"; url = "https://www.netflix.com/browse"; }
                    ];
                  }
                  {
                    name = "Personal";
                    bookmarks = [
                    { name = "Primary gmail"; url = "https://mail.google.com/mail/u/0/#inbox"; }
                    { name = "Secondary gmail"; url = "https://mail.google.com/mail/u/1/#inbox"; }
                    ];
                  }
                ];
              }
              {
                name = "Coding";
                bookmarks = [
                  { name = "Github"; url = "https://github.com/"; }
                  {
                    name = "NixOS";
                    bookmarks = [
                      { name = "Nix Search"; url = "https://search.nixos.org/packages"; }
                      { name = "Pingu NixOS config"; url = "https://github.com/blahai/nyx"; }
                    ];
                  }
                ];
              }
              {
                name = "Gaming";
                bookmarks = [
                  {
                    name = "HSR";
                    bookmarks = [
                      { name = "Warp Calculator"; url = "https://hsr-warp-calculator.vercel.app/"; }
                      { name = "StarRailStation"; url = "https://starrailstation.com/en"; }
                      { name = "Guobas Kitchen"; url = "https://www.guobaskitchen.com/"; }
                      {
                        name = "Leaks";
                        bookmarks = [
                          { name = "HomGDCat Wiki"; url = "https://homdgcat.wiki/sr/hidden?lang=EN"; }
                          { name = "r/HSR_Leaks"; url = "https://www.reddit.com/r/HonkaiStarRail_leaks/"; }
                        ];
                      }
                    ];
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
