{ config, pkgs, inputs, extra, ... }:


{
	home.username = "addev";
	home.homeDirectory = "/home/addev";
	home.stateVersion = "25.11";
# Standard Packages
	home.packages = with pkgs; [
		ripgrep
			less
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
			package = pkgs.neovim-nightly;  # inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
			withNodeJs = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
# Extra Packages
			extraPackages = with pkgs; [
				tree-sitter-nightly
# LSP
					lua-language-server
					nixd
			];
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

	home.sessionVariables = {
		PAGER="bat --paging=always";
		MANPAGER="sh -c 'col -bx | bat -l man -p'";
	};

	nix.registry = { nixpkgs.flake = inputs.nixpkgs; };
}

