{ config, pkgs, lib, extra, ... }:
{
    imports = [ ../home.nix ];
    programs.zsh.initContent = lib.mkMerge [
        (lib.mkOrder 550''
            # Use arrow keys to navigate completion menu.
            zstyle ':completion:*' menu select
        '')
        (lib.mkOrder 1000 ''
            source "${extra.configs}/zsh/init-sshtogh-rzp.zsh"
        '')
    ];
}
