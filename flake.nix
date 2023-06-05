{
  description = "My NixOS flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    firefox.url = "github:colemickens/flake-firefox-nightly";
		st.url = "github:siduck/st";
    rust-overlay.url = "github:oxalica/rust-overlay";
    agenix.url = "github:ryantm/agenix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nur.url = "github:nix-community/NUR";
    spicetify-nix.url = "github:the-argus/spicetify-nix";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {

      # FIX replace with your hostname
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [
          ./nixos/configuration.nix

          inputs.agenix.nixosModules.default
          inputs.nur.nixosModules.nur
           
          ({ pkgs, ...}: {
            nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
            environment.systemPackages = [ 
              inputs.agenix.packages."${pkgs.system}".default
              pkgs.rust-bin.stable.latest.default
            ];
          })
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {

      home-manager.useGlobalPackages = true;
      # FIXME replace with your username@hostname
      "kareem@laptop" = home-manager.lib.homeManagerConfiguration {

        # Home-manager requires 'pkgs' instance
        pkgs = import inputs.nixpkgs { 
          system = "x86_64-linux";
          config.allowUnfree = true;
        };

        extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
        modules = [
          ./home/home.nix

          inputs.spicetify-nix.homeManagerModule
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay inputs.nur.overlay ];
          })
        ];
      };
    };
  };
}
