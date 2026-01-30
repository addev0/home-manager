{
    description = "Nix Home-Manager Public Configuration (addev)";
    
    inputs = {
        # Home-Manager and NixPkgs Source.
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        # Neovim Nightly Overlay
        neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    };

    outputs = { self, nixpkgs, home-manager, ... } @inputs:
        let
            system = "x86_64-linux";
            # pkgs = nixpkgs.legacyPackages.${system};
            pkgs = import nixpkgs {
                inherit system;
                overlays = [
                    (final: prev: {
                        neovim-nightly = inputs.neovim-nightly-overlay.packages.${system}.default;
                        tree-sitter-nightly = inputs.neovim-nightly-overlay.inputs.nixpkgs.legacyPackages.${system}.tree-sitter;
                    })
                ];
            };
        in {
            homeConfigurations = {
                # Replace "addev" with your username or custom home-manager config name
                "addev" = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;

                    # Optionally use extraSpecialArgs
                    # to pass through arguments to home.nix
                    extraSpecialArgs = {
                        inherit inputs;
                        extra = {
                            configs = "${self}/extra/configs";
                            modules = "${self}/extra/modules";
                        };
                    };
                    modules = [ ./home.nix ];
                };
            };
        };
}
