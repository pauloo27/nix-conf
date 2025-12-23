# Nix-Conf

 ```
 _____________
< My Nix Conf >
 -------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

## Setup

```bash
# Enable flakes
./setup-nix-conf.sh

# Apply configuration
./apply.sh

# Add zsh to system shells
./add-zsh-to-shells.sh

# Set zsh as default shell
chsh -s ~/.nix-profile/bin/zsh
```
