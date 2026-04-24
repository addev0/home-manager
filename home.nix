
{ config, pkgs, inputs, extra, ... }:

{
	home.username = "addev";
	home.homeDirectory = "/home/addev";
	home.stateVersion = "25.11";

  # Standard Packages
	home.packages = with pkgs; [
		ripgrep
    fd
    less
    # nodejs
    # python314
    htop
    gnumake
    gcc
    qbittorrent-nox
	];

  # Packages with Configs
	programs = {
    git = {
			enable = true;
			package = null;             # Don't install git. (use system git binary)
				settings = {
					user = { name = "addev"; email = "adrian.amzca0@gmail.com"; };
					init = { defaultBranch = "main"; };
					alias = { ac = "!git add -A && git commit -m"; st = "status"; };
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
      # ZSH Plugin: AutoSuggestions
			autosuggestion = {
				enable = true;
				strategy = [ "history" "completion" ];
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
			defaultKeymap = "emacs";
      shellAliases = {
          vsvim = "NVIM_APPNAME=vsvim nvim";
      };
		};

    # Programs: Starship (ZSH-Prompt)
		starship = {
			enable = true;
			enableZshIntegration = true;
			settings = let
				extraConfig = "${extra.configs}/starship/starship.toml";
			in
				if builtins.pathExists extraConfig
					then fromTOML (builtins.readFile extraConfig)
				else {};
		};

    # Program: Zoxide Config
		zoxide = {
			enable = true;
			enableZshIntegration = true; 
			options = [
				"--cmd z"           # explicitly defines 'z' and 'zi' command AND enables tab-completion.
                "--hook none"       # disables the shell hook that tracks 'cd' movements.
			];
		};

    # Program: bat (PAGER)
		bat = {
      enable = true;
			config = {
				theme = "tokyonight_moon.tmTheme";
			};
      # Fetch the custom theme file from the official repo
			themes = {
				"tokyonight_moon.tmTheme" = {
					src = pkgs.fetchurl {
						url = "https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_moon.tmTheme";
						hash = "sha256-mi+G7OEp85EwbzAnaF5Vf1zeglyj28rwNlpHxvHQbRc=";
					};
				};
			};
		};

    # Program: FZF Config
		fzf = {
			enable = true;
			enableZshIntegration = true;
		};

    # Neovim Config
		neovim = {
			enable = true; 
			withNodeJs = false;
			withPython3 = false;
			withRuby = false;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
      # Extra Packages
			extraPackages = with pkgs; [
        # Treesitter
        tree-sitter-nightly
        # LSP
        lua-language-server
        nixd
        htmlhint
        vscode-langservers-extracted
        typescript-language-server
      ];
      plugins = [
        (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
          p.javascript
          p.jsdoc
          p.typescript
          p.lua
          p.python
          p.css
          p.html
          # p.html_tags
          p.python
          p.json
          p.yaml
        ]))
      ];
      
    };

    # eza config
    eza = {
			enable = true;
			enableZshIntegration = true;
			colors = "always";
			icons = "auto";
		};

    # direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # Install Home-Manager
    home-manager.enable = true;
  };

  home.preferXdgDirectories = true;
  xdg.enable = true;
  xdg.configFile."eza/theme.yml".source = "${extra.configs}/eza/tokyonight.yml";
  xdg.configFile."nvim".source = "${extra.configs}/nvim";
  xdg.configFile."vsvim".source = "${extra.configs}/vsvim";
  # xdg.configFile."nvim/lua/config".source = "${extra.configs}/nvim/lua/config";
  xdg.configFile."nix/nix.conf".source = ./nix/nix.conf; 
  xdg.configFile."qBittorrent/qBittorrent.conf".text = ''
    [LegalNotice]
    Accepted=true

    [Preferences]
    WebUI\LocalHostAuth=false
    WebUI\AuthSubnetWhitelist=127.0.0.1/32
    WebUI\AuthSubnetWhitelistEnabled=true
    WebUI\Port=8080
  '';

  home.file = {
    ".vscode-server/data/Machine/settings.json" = {
        source = "${extra.configs}/vscode/settings.json";
    };
  };

  home.sessionVariables = {
    PAGER="bat --paging=always";
    MANPAGER="sh -c 'col -bx | bat -l man -p'";
    # NVIM_APPNAME="vsvim";
  };

  nix.registry = { nixpkgs.flake = inputs.nixpkgs; };
}


