default:
    @just --list

set shell := ["bash", "-cu"]

# Initialize Chezmoi with GitHub authentication, SSH key generation, and remote URL update
init_chezmoi:
    # Authenticate GitHub CLI
    gh auth login --web

    # Generate an SSH key with a specified name if it doesn't already exist
    ssh-keygen -t ed25519 -C "github@$(hostname)" -f "$HOME/.ssh/github_ed25519" -N "" || echo "SSH key already exists. Skipping."

    # Add the SSH key to the GitHub account
    gh ssh-key add "$HOME/.ssh/github_ed25519.pub" --title "github@$(hostname)"

    # Rewrite the git remote path in .local/share/chezmoi
    git -C "$HOME/.local/share/chezmoi" remote set-url origin "git@github.com:Crown421/atomic-dots.git"