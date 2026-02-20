### @═╦╣╚╗ [A mazing engineer](../)

#### 20-Feb-2026 Alpine Linux on QEMU: the tool

For a pet project, I was on a lookout for a lightweight tool similar to [PRoot](https://wiki.termux.com/wiki/PRoot), a user-space "jail", "sandbox", or "container" to be able to run the SSH server without exposing it on my laptop.

Back in the day, when I was primarily using Linux, PRoot allowed me to do that:
 - run [parts of the developed project](https://github.com/pirj/plug-repo/blob/5cbf1a967f937ae91fa8a688c089a8833d165ac6/test/run#L8) in [isolation](https://github.com/pirj/plug-repo/blob/5cbf1a967f937ae91fa8a688c089a8833d165ac6/test/run#L15)
 - run a [whole "system"](https://github.com/pirj/plug-repo/blob/5cbf1a967f937ae91fa8a688c089a8833d165ac6/test/etc/ssh/sshd_config#L6), not just an "app"
 - spin those "jails" up in mere milliseconds
 - run some tests against it, and discard with no remorse

In a nut shell (pun intended):

    SSHD_PORT=2222
    cp bootstrap.sh $SANDBOX/plug-repo
    proot -R / -b $SANDBOX:/home! -w /home/sandbox ./bootstrap.sh
    proot -R / -b $SANDBOX:/home! -b test/etc/ssh:/etc/ssh! -w /home/sandbox /usr/bin/sshd -p $SSHD_PORT &
    SSHD_PID=$!
    ssh plug-repo@127.0.0.1 -p $SSHD_PORT test-command
    kill -QUIT $SSHD_PID

But, sadly, PRoot is Linux-only, and I'm now on a Mac.

I know what you have to say, but I must confess that over the years I haven't developed good relationships with Docker. For various reasons, including, but not ending with: poor/no isolation, Mac slowness, failed reproducibility promise, overconfident "grab this random image and run it" consumers' mindset, storage layer separation, daemon runnit as root, proprietary ecosystem, a mandatory desktop app, ... It's a strong "no" from me for local development.

So I went looking for alternatives.

### Macpine

[Macpine](https://beringresearch.github.io/macpine/) felt good for a while:

    $ alpine launch --port 80,443 --name instance-one
    $ alpine ls
    NAME         STATUS      SSH      PORTS      ARCH        PID   TAGS
    instance-one Stopped     22       80,443     aarch64     -
    $ sshpass -p root ssh-copy-id root@localhost
    $ scp -p sshd_config.d/*.conf root@localhost:/etc/ssh/sshd_config.d

But it is buggy and incomplete ([1](https://github.com/beringresearch/macpine/issues/213), [2](https://github.com/beringresearch/macpine/issues/214), [3](https://github.com/beringresearch/macpine/issues/215), [4](https://github.com/beringresearch/macpine/issues/216), [5](https://github.com/beringresearch/macpine/issues/217), [6](https://github.com/beringresearch/macpine/issues/218)).

### libvirt & virt-install

[libvirt](https://libvirt.org/) provides exhaustive control over local virtual machines, supports QEMU. Everything with its [`virsh` command](https://libvirt.org/manpages/virsh.html).
[virt-manager](https://virt-manager.org/) is a desktop application on top of libvirt. I only needed a small fraction of it, the `virt-install` command.

    $ brew install libvirt virt-manager
    $ brew services start libvirt
    $ virt-install \
        --osinfo alpinelinux3.21 \
        --cdrom https://dl-cdn.alpinelinux.org/alpine/v3.22/releases/aarch64/alpine-virt-3.22.1-aarch64.iso \
        --graphics none

    # poweroff

    $ virsh list --all
     Id   Name              State
    ----------------------------------
     -    alpinelinux3.21   shut off

    $ virsh start --console alpinelinux3.21

The combination, though, felt overkill for my needs.

In my pursuit for a minimalistic solution, I moved on [and freed up some of the disk space](https://gist.github.com/pirj/15015cb888f9dcbe077b01589ffffc99).

### DIY Endgame: aq

No wonder, like it frequently happens to those who fail to grasp the depth of the underlying problem, I decided to ~reinvent the wheel~ build a new tool to fit my needs.

Here it is! [aq](https://github.com/pirj/aq), a tiny wrapper around QEMU's [overwhelming](https://qemu.readthedocs.io/en/v10.0.3/system/qemu-manpage.html) options galore, spins new QEMU machines with Alpine Linux.

Features:
 - brutally minimalistic, but feature-complete
 - full machine, with multiple services
 - its own storage
 - no distinction between an image and a instance
 - storage efficient: images are backed by a base image; changes, and only changes are be stored
 - memory efficient

Anti-features:
 - no graphics, only text-mode, SSH
 - Alpine Linux guest only
 - Mac-only host
 - only the latest Alpine support
 - only the latest QEMU

Here's a sneak peek of `aq`:

    aq new -p 2222:22 -p 8000 guest-1
    aq start guest-1
    aq stop guest-1
    aq console guest-1
    cat script.sh | aq exec guest-1
    aq scp -r config.toml guest-1:/etc/app/
    aq scp guest-1:/var/log/app.log ./logs/
    aq ls | grep On | cut -d" " -f1 | xargs -n1 -I_ aq exec _ <<SH
      echo ssh-ed25519 AAAAC...YJk foo@bar >> .ssh/authorized_keys
    SH
    aq rm guest-1
    aq ls
    aq ls | grep On
    aq ls | grep guest-1

Pretty self-explanatory, each of those?

There's no brew tap for it yet, you can [download it](https://github.com/pirj/aq/blob/main/aq) and put somewhere on your `$PATH`.

I used it extensively when developing another pet project, but that's another story.
