# Natan Yellin's Glorious Dotfiles for Great Success in Home Directory
My [castle](https://github.com/technicalpickles/homesick), my
dotfiles. Sheltering me from guis since 2011.

## Overview
I use emacs, zsh, and git on Mac OS X Snow Leopard. These are my
dotfiles. This is how I work.

### Guiding principles
* Minimize keystrokes.
* Fingers belong on the home row.
* Avoid arrow keys at all costs.
* Provide alternatives to the mouse.
* Learn keyboard shortcuts once, use forever.
* Time investments to automate your workflow pay off in the long run

### Warnings
* May intimidate friends and family.

## What's included?
### Vestigial support for bash and vim
.bash_profile and .vimrc are antiques from the dark ages. Don't use
them! There are better alternatives.

### Shells
My shell of choice is zsh which is configured in .zshrc and depends
on [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh).

.zshrc sources .profile, which sets environment variables and aliases.
I strive to keep .profile compatible with bash too.

My configuration is intended for an OS X development machine with
Homebrew installed versions of Python and Ruby. It offers no value
elsewhere.

### Emacs
The Emacs configuration is what you would expect from a vim convert:
I use Vim keybindings for everything. This is possible with the superb
[Evil](https://gitorious.org/evil/pages/Home) package.

Included is a smattering of elisp for just about everything: there is
a wrapper for deft-mode (to support switching between multiple
directories), mandatory settings to bring Emacs into the 21st century,
and a collection of useful functions and mappings.

Warning: My settings are *highly* personal and often idiosyncratic.
Everything *should* be cross platform, but I haven't tested on Windows
recently.

### Pentadactyl
I browse with Firefox and
[Pentadactyl](http://dactyl.sourceforge.net/pentadactyl/), a vim-like
environment in Firefox. Other addons add hardcoded vim bindings to Firefox. Pentadactyl
gives you vim.

My .pentadactylrc mostly mirrors my favorite shortcuts from
Vimperator. I am still ignorant of Pentadactyl features; advice and
tips are most welcome.

## Installation
Install with [Homesick](https://github.com/technicalpickles/homesick).

If you intend to use my castle, fork it. I may change settings for no
reason and without warning.

## TODO
* Documentation
* Cleanup of Emacs configuration
* Test Emacs configuration with a fresh install
