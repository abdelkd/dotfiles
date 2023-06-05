{ inputs, pkgs, ... }:
{
    programs.firefox = {
        enable = true;
        package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin;

        profiles = {
            kareem = {

                # {name keyword? url}
                # {name bookmarks []}
                bookmarks = [];
                
                extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                  anonaddy
                  bitwarden
                  bypass-paywalls-clean
                  libredirect
                  react-devtools
                  reduxdevtools
                  stylus
                  tokyo-night-v2
                  ublock-origin
                  violentmonkey
                  windscribe
                  privacy-badger
                ];

              isDefault = true;
              extraConfig = '''';
              userChrome = '''';
              userContent = '''';
              
              search = {
                default = "DuckDuckGo";
                force = true;

                engines = {
                  "Nix Packages" = {
                      url = [{
                          template = "https://search.nixos.org/packages";
                          params = [
                            { name = "type"; value = "packages"; }
                            { name = "query"; value = "{searchTerms}"; }
                          ];
                        }];

                        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                        definedAliases = [ "@np" ];
                    };
                };
              };
            };
          };
      };
  }
