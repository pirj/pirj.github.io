### @═╦╣╚╗ [A mazing engineer](../)

#### 06-Aug-2025 Install Alpine Linux on an OVH VPS

[Alpine Linux](https://alpinelinux.org/about/) is an incredibly good server OS.
[OVH VPS](https://www.ovhcloud.com/en-ie/vps/) are fantastic: inexpensive, fast, no bandwidth cap.

But OVH doesn't offer Alpine Linux as an OS option.

This is an comprehensive step-by-step guide on how to install Alpine Linux on an OVH VPS.

#### Disclaimer

The same can be [done with chroot](https://nicolas.porcel.me/posts/2017-05-11-how-to-install-alpine-on-ovh.html), but I wanted to replace the image manipulation and mounting into just one step.

### Steps

Boot your VPS in rescue mode from OVH UI. You'll receive a link by email that will reveal your root SSH password.

SSH into your VPS:

    $ ssh root@vps-lazy1337.vps.ovh.net

Update list of available packages:

    $ apt update

Install [QEMU](https://www.qemu.org/):

    $ apt install qemu-system-x86
    After this operation, 115 MB of additional disk space will be used.

Download [Alpine](https://alpinelinux.org/downloads/).
I chose the "Virtual" flavour as quite sufficient for the task.
Also download the image's checksum and GPG signature.

    $ wget https://dl-cdn.alpinelinux.org/alpine/v3.22/releases/x86_64/alpine-virt-3.22.1-x86_64.iso
    $ wget https://dl-cdn.alpinelinux.org/alpine/v3.22/releases/x86_64/alpine-virt-3.22.1-x86_64.iso.sha256
    $ wget https://dl-cdn.alpinelinux.org/alpine/v3.22/releases/x86_64/alpine-virt-3.22.1-x86_64.iso.asc

Verify the downloaded image. First, install [GPG](https://gnupg.org/):

    $ apt install gpg

Download and import the GPG signature from official website:

    $ curl https://alpinelinux.org/keys/ncopa.asc | gpg --import ;

Check the checksum:

    $ sha256sum -c alpine-*.iso.sha256
    alpine-virt-3.22.1-x86_64.iso: OK

Verify that the image signature matches:

    $ gpg --verify alpine-*.iso.asc alpine-*.iso

Boot the Alpine ISO image in a pseudo-virtualised environment:

    $ qemu-system-x86_64 \
      -cpu host \
      -enable-kvm \
      -m 1G \
      -net nic \
      -net user \
      -drive file=/dev/sdb,format=raw,index=0,media=disk \
      -cdrom alpine-virt-3.22.1-x86_64.iso \
      -nographic \
      -boot d

Magic, it booted:

    Booting from DVD/CD...

    Welcome to Alpine Linux 3.22
    Kernel 6.12.38-0-virt on x86_64 (/dev/ttyS0)

    localhost login:

Login with [`root` with no password](https://wiki.alpinelinux.org/wiki/Installation).

Now, start the installation:

    # setup-alpine

Just vibe-accept all default settings. Except for:

1. "Changing password for root": pick a strong one
2. "Enter ssh key or URL for root": paste your public SSH key
3. "Which disk(s) would you like to use?": choose "sda"
4. "How would you like to use it?": "sys" for regular system installation
5. "Erase the above disk(s) and continue?" "y" for YES!

Aaaand:

    Creating file systems...
    Installing system on /dev/sda3:

    /mnt/boot is device /dev/sda1
    /boot is device /dev/sda1
    Installation is complete. Please reboot.

Time to reboot, but twice, because you're in in onion of machines. First, exit from the Alpine installation running in QEMU:

    localhost:~# poweroff
    [RESCUE] root@vps-lazy1337:~ $

Reboot the VPS from OVH UI.

The identity of the VPS Rescue machine and your VPS is different, even though they respond on the same host.
To prevent authenticity check failure, remove the host's fingerprint from known hosts:

    $ ssh-keygen -R vps-lazy1337.vps.ovh.net

Time to log in to your shiny new Alpine installation running on an OVH VPS:

    $ ssh root@vps-lazy1337.vps.ovh.net

    Welcome to Alpine!
