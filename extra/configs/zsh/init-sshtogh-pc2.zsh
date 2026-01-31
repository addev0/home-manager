
init-sshtogh () {
    local shell_pkgs=()
    # BW
    if ! command -v bw &> /dev/null; then
        echo "❌ BW Command Not Found. Adding to Nix-Shell instance.."
        shell_pkgs+=(nixpkgs#bitwarden-cli)
    fi
    
    # SOPS
    if ! command -v sops &> /dev/null; then
        echo "❌ SOPS Command Not Found. Setting up Nix-Shell instance.."
        shell_pkgs+=(nixpkgs#sops)
    fi

    # AGE
    if ! command -v age &> /dev/null; then
        echo "❌ SOPS Command Not Found. Setting up Nix-Shell instance.."
        shell_pkgs+=(nixpkgs#age)
    fi
    
    # JQ
    if ! command -v jq &> /dev/null; then
        echo "❌ JQ Command Not Found. Setting up Nix-Shell instance.."
        shell_pkgs+=(nixpkgs#jq)
    fi

    nix shell $shell_pkgs

    export SOPS_AGE_KEY="$(bw get item id_github-addev --raw | jq -r '.fields[] | select(.name=="age key") | .value')"
    export SSHTOGH_FILE="/mnt/c/Users/addev/RemoteDrives/OneDrive/DevTools/git/secrets/id_github-addev.sops"
    if [[ -f "$SSHTOGH_FILE" ]]; then
        if [[ -z "$SSH_AUTH_SOCK" ]]; then
            eval "$(ssh-agent -s)"
        fi
        sops -d $SSHTOGH_FILE | ssh-add -
    fi
    ssh -T git@github.com
}

################################
#   ALIAS
################################
# alias gcm='/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe'



#===============================
bindkey -e
