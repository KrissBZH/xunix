{
  default = "DuckDuckGo";
  force = true;
  engines = {
    "DuckDuckGo" = {
      urls = [ { template = "https://duckduckgo.com/?q={searchTerms}"; } ];
      definedAliases = [ "d" ];
    };

    "GitHub" = {
      urls = [ { template = "https://github.com/search?q={searchTerms}"; } ];
      definedAliases = [ "gh" ];
    };

    "Nix Packages" = {
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            {
              name = "channel";
              value = "unstable";
            }
            {
              name = "type";
              value = "packages";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      definedAliases = [ "np" ];
    };

    "Home-Manager" = {
      urls = [ { template = "https://rycee.gitlab.io/home-manager/options.html"; } ];
      definedAliases = [ "hm" ];
    };

    "NixOS Options" = {
      urls = [
        {
          template = "https://search.nixos.org/options";
          params = [
            {
              name = "channel";
              value = "unstable";
            }
            {
              name = "type";
              value = "packages";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];

      definedAliases = [ "no" ];
    };

    "NixOS Wiki" = {
      urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
      definedAliases = [ "nw" ];
    };

    "Bing".metaData.hidden = true;
    "Google".metaData.alias = "g";
  };
}
