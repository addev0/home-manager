
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
                alias = {
                    ac = "!git add -A && git commit -m";
                };
            };
        };

        # ZShell Config
        zsh = {
            enable = true; 
            dotDir = "${config.xdg.configHome}/zsh";
            history = {
                size = 50000;
                save = 50000;
                append = true;
                path = "${config.xdg.stateHome}/zsh/history";
                ignorePatterns = [
                    "rm *"
                    "pkill *"
                ];
                ignoreAllDups = true;
                saveNoDups = true;
                findNoDups = true;
                ignoreSpace = true;
                expireDuplicatesFirst = true;
                extended = true;
                share = true;
            }; 
            # Use fast-syntax-highlighting instead of the default
            syntaxHighlighting.enable = false;
            plugins = [
                {
                    name = "fast-syntax-highlighting";
                    src = pkgs.zsh-fast-syntax-highlighting;
                    file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
                }
            ];
        };
        # Program: Zoxide Config
        zoxide = {
            enable = true;
            enableZshIntegration = true; 
            options = [
                "--no-cmd"
            ];
        };

        # Neovim Config
        neovim = {
            enable = true; 
            package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
            defaultEditor = true;
        };

        # eza config
        eza = {
            enable = true;
            enableZshIntegration = true;
            colors = "always";
            icons = "auto";
        };

        # Install Home-Manager
        home-manager.enable = true;
    };

    home.preferXdgDirectories = true;
    xdg.enable = true;
    xdg.configFile."eza/theme.yml".source = "${extra.configs}/eza/tokyonight.yml";
    xdg.configFile."nvim".source = "${extra.configs}/nvim";
    # xdg.configFile."nvim/lua/config".source = "${extra.configs}/nvim/lua/config";
    xdg.configFile."nix/nix.conf".source = ./nix/nix.conf; 

    home.file = {};

    home.sessionVariables = {};

    nix.registry = { nixpkgs.flake = inputs.nixpkgs; };
}
