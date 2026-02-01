
init-sshtogh () {
    local shell_pkgs=()

    # Check missing deps
    [[ -z "$(command -v bw)" ]]   && shell_pkgs+=(nixpkgs#bitwarden-cli)
    [[ -z "$(command -v sops)" ]] && shell_pkgs+=(nixpkgs#sops)
    [[ -z "$(command -v age)" ]]  && shell_pkgs+=(nixpkgs#age)
    [[ -z "$(command -v jq)" ]]   && shell_pkgs+=(nixpkgs#jq)

    # If deps are missing, run this function inside a nix shell
    if (( ${#shell_pkgs[@]} > 0 )); then
        echo "📦 Nix-Shell: Provisioning dependencies..."
        # Call function again inside the shell.
        nix shell "${shell_pkgs[@]}" --command zsh -i -c "init-sshtogh; exec zsh"
        return
    fi

    # Bitwarden Session Managment
    if [[ -z "$BW_SESSION" ]] || ! bw list items --session "$BW_SESSION" &>/dev/null; then
        echo "Bitwarden vault is locked."
        # Prompt for password.
        BW_SESSION=$(bw unlock --raw)

        if [[ $? -ne 0 || -z "$BW_SESSION" ]]; then
            echo "Error: Failed to unlock Bitwarden."
            return 1
        fi
        export BW_SESSION
    fi

    echo "Fetching age key..."
    # Fetch age key: supress noisy stderr from bw if already logged in.
    local age_key
    age_key="$(bw get item agekey-sshtogh --raw | jq -r '.fields[] | select(.name=="private_key") | .value')"

    if [[ -z "$age_key" || "$age_key" == "null" ]]; then
        echo "❌ Error: Could not retrieve Age-Key from Bitwarden"
        return 1
    fi

    echo "🔏 Unlocking secrets..."

    export SOPS_AGE_KEY="$age_key"
    export SSHTOGH_FILE="/mnt/c/Users/addev/RemoteDrives/OneDrive/DevTools/git/secrets/id_github-addev.sops"

    if [[ -f "$SSHTOGH_FILE" ]]; then
        [[ -z "$SSH_AUTH_SOCK" ]] && eval "$(ssh-agent -s)" &>/dev/null
        # Add key quietly
        sops -d "$SSHTOGH_FILE" |& ssh-add - &>/dev/null
        echo "✅ SSH Key added successfully."
    else
        echo "❌ Error: $SSHTOGH_FILE not found."
        return 1
    fi

    # Quietly test connection, only show greeting
    ssh -T git@github.com 2>&1 | grep -i "Hi"
}
