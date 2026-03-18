# Arch-sandbox
### A system that uses an "Overlay filesystem" for Sandbox on Arch Linux, with the potencial to work on other distributions and without depending on specific file systems 

## This repository as a whole is intended to be a guide for anyone who wants to use it. I might create a complete configuration tool later, but you can simply use the files provided here and adapt them as needed.

## The idea is to use the Overlay filesystem to create a layer over the system root.
### In this layer, complete updates or other modifications can be made, and upon restarting, it can boot from "arch-preview.efi". This allows testing the changes without affecting the actual system root, which is great for avoiding broken updates.

### It doesn't depend on specific file systems or features like Snapshot.

### The modifications can be merged with rsync, I will work on this more

### I use UKI boot directly, I don't use a bootloader, pay attention to this if you need to adapt something to a specific bootloader

## Research sources:
* [Overlay filesystem](https://wiki.archlinux.org/title/Overlay_filesystem)
* [explaining-overlayfs](https://web.archive.org/web/20220712001252/https://www.datalight.com/blog/2016/01/27/explaining-overlayfs-%E2%80%93-what-it-does-and-how-it-works)
* [Overlay Doc](https://docs.kernel.org/filesystems/overlayfs.html)
* [UKI](https://wiki.archlinux.org/title/Unified_kernel_image)
* [Mkinitcpio](https://wiki.archlinux.org/title/Mkinitcpio)
* And some clarifications and help from AI.
