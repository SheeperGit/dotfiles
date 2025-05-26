# A Sheep's Dotfiles

Dotfiles intended to be used across my Linux machines.

## Usage

### To replicate these dotfiles on a new system:

```bash
$ git clone --bare <git-repo-url> $HOME/.dotfiles
$ alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
$ dotfiles checkout
$ dotfiles config --local status.showUntrackedFiles no
```

### To initialize your own dotfiles in a similar way (so you can do this with your files):

```bash
$ git init --bare ~/.dotfiles
$ alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
$ dotfiles config status.showUntrackedFiles no
```

From here, you can add files in a similar way to how you would in git.
For example:

```bash
$ dotfiles status
$ dotfiles add .vimrc
$ dotfiles commit -m "Add vimrc"
$ dotfiles add .config/redshift.conf
$ dotfiles commit -m "Add redshift config"
$ dotfiles push
```

## Credits

[ArchWiki](https://wiki.archlinux.org/title/Dotfiles) — Dotfile initialization and replication.

[StreakyCobra](https://news.ycombinator.com/item?id=11071754) — Example commands.

[Luke Smith](https://github.com/LukeSmithxyz/voidrice) — Inspiration for this repository, statusbar scripts, and much, *much* more.
