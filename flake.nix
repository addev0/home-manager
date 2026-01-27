{
    description = "Nix Home-Manager Public Configuration (addev)";
    
    inputs = {
        # Home-Manager and NixPkgs Source.
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-communityu/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        # Neovim Nightly Overlay
        neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    };

    outputs = {
        { self, nixpkgs, home-manager, ... } @inputs:
        let
            systm = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in {
            homeConfigurations = {
                # Replace with username or custom home-manager config name
                "username" = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    # Optionally use extraSpecialArgs
                    # to pass through arguments to home.nix
                    extraSpecialArgs = {
                        inherit inputs;
                        extraConfig = "${config.xdg.configHome}/extra";
                    };
                    # Specify your home configuration modules here, for example,
                    # the path to your home.nix.
                    modules = [ ./home.nix];
                };
            };
        };
    };
}
