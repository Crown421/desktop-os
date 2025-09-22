# Atomic OS

This repo builds OS images based on Fedora Atomic, using [BlueBuild](https://blue-build.org).

## Overview
This repo contains three images
- __desktop-main__: Based on Fedora Sway Atomic, this OS runs on my laptop with an AMD 8840U CPU and integrated GPU.
- __nvidia-main__: Functionally identical to the desktop-main, this image also contains nvidia drivers and runs on my desktop PC with a nvidia GPU.
- __server-main__: A Fedora CoreOS based image that runs my little home server, a Wyse 5070. 

## Why atomic
There are many reasons to use atomic images, but for me the most important reasons are:
- It allows me to configure an OS that works for me in an almost declarative way, but without having to learn Nix (though, this may come at some point).
  - This means I can (but also have to) include any tweak to the systems in this OS, instead of having to remember some manual change.
- It is incredibly simple to keep my machines in sync. 
  - I sometimes go weeks without using my desktop PC, but bringing it to the same state as my laptop is trivial by updating the atomic OS.

## Installation

Theoretically, it is supposed to be possible to [create an ISO](https://blue-build.org/how-to/generate-iso/) from blue-build images and install them directly on a PC.
In practice, I have encountered various errors, so I recommend installing a "normal" Fedora version first.
One option for this is using the [Fedora Media Writer](https://docs.fedoraproject.org/en-US/fedora/latest/preparing-boot-media/#_fedora_media_writer) and install the official Fedora Sway Atomic first. 

Then, rebase the existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/crown421/desktop-os:42
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/crown421/desktop-os:42
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/blue-build/template
```
