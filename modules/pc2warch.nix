{ config, pkgs, lib, extra, ... }:
{
  imports = [ ../home.nix ];

  programs.zsh.initContent = lib.mkMerge [
    # Use lib.mkOrder with a space before the string
    (lib.mkOrder 550 ''
      # Use arrow keys to navigate completion menu.
      zstyle ':completion:*' menu select
    '')

    (lib.mkOrder 1000 ''
      source "${extra.configs}/zsh/init-sshtogh-pc2.zsh"
    '')

    # This is your "Nix persistence" bridge
    (lib.mkOrder 1100 ''
      if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix.sh ]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi
      
      # Also ensure your user profile is in the PATH
      if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi
    '')

    # xdg.configFile."qBittorrent/qBittorrent.conf".text = ''
    #   [LegalNotice]
    #   Accepted=true
    #
    #   [Preferences]
    #   WebUI\LocalHostAuth=false
    #   WebUI\AuthSubnetWhitelist=127.0.0.1/32
    #   WebUI\AuthSubnetWhitelistEnabled=true
    #   WebUI\Port=8080
    # '';
  ];
}
