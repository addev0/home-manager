
{ config, pkgs, inputs, extra, ... }:
{
    home.username = "addev";
    home.homeDirectory = "/home/addev";
    home.stateVersion = "26.05";
    # Standard Packages
    home.packages = with pkgs; [
        tree-sitter
        ripgrep
        bat
        less
    ];
    # Packages with Configs
    programs = {
        git = {
            enable = true;
            package = null;             # Don't install git. (use system git binary)
            settings = {
                user = {
                    name = "addev";
                    email = "adrian.amzca0@gmail.com";
                };
                init = { defaultBranch = "main"; };
            };
        };
        # ZShell Config
        zsh = {
            enable = true; 
            
        };
        # Neovim Config
        neovim = { enable = true; };

        # Install Home-Manager
        home-manager.enable = true;
    };
    
    home.file = {};

    home.sessionVariables = {};

    nix.registry = { nixpkgs.flake = inputs.nixpkgs; };
}
