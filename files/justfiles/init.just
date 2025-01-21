# Initialize Chezmoi with GitHub authentication, SSH key generation, and remote URL update
init_chezmoi:
    gh auth login --web
    ssh-keygen -t ed25519 -C "github@$(hostname)" -f "$HOME/.ssh/github_ed25519" -N "" || echo "SSH key already exists. Skipping."
    gh ssh-key add "$HOME/.ssh/github_ed25519.pub" --title "github@$(hostname)"
    git -C "$HOME/.local/share/chezmoi" remote set-url origin "git@github.com:Crown421/atomic-dots.git"
