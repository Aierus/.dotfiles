See https://mitxela.com/projects/dotfiles_management

Not much of a project, but this might be useful for some folks. Here's how I am currently keeping track of all the configuration for my laptop.

The system I've settled on is copied from other people – tracking dotfiles as a git repo – but taken to its extreme where the entire root filesystem is trackable. Importantly,

    Any file on the machine can be added to the dotfiles repo
    The dotfiles repo doesn't interfere with any other git repos you're working with 

Starting with the basics, the repo needs to live somewhere, so we initialise a bare git repo in ~/.dotfiles. I named the default branch the same as this laptop's hostname (magma) with the vague idea that multiple machines can share the dotfiles repo with different branches. It may make sense to have a template branch, with most of the generic settings (like vimrc), and specific branches with machine-specific config, but that means a lot of merging between branches, which you may or may not have the patience for.

We make an alias:

`alias dotfiles='git --git-dir=/home/mx/.dotfiles --work-tree=/'`

Now typing dotfiles status or dotfiles log will show the status or log of the repo, regardless of if you're currently in another repo. Of course looking at the status will probably take forever as the work tree is /, so it will list every single file on the filesystem as untracked. There are a few ways to stop this, but I went with simply telling git not to show untracked files:

`dotfiles config --local status.showUntrackedFiles no`

The files are not ignored, you can just add them normally, but until then they won't be listed. This is 90% of the work done, you can now add some files, either local, in your home directory, or anywhere on the system, and commit them to the repo.

`dotfiles add ~/.bashrc
dotfiles add /etc/udev/rules.d/70-ftdi.rules
dotfiles commit`

All well and good. But I shortly found myself craving more so I expanded on this with a few more features. First, I wholly depend on tig for quickly seeing the state or history of a git repo, so to invoke tig on the dotfiles repo we use this:

alias dtig='GIT_DIR=/home/mx/.dotfiles GIT_WORK_TREE=/ tig'

Second, because of the huge spread of where files are, I found myself always needing to list which files are explicitly tracked, using dotfiles ls-files. It's really helpful to be able to quickly see where that config file was that you need to edit again. I went a bit overboard here and added a bash function to display a summary.
```
dot(){
  if [[ "$#" -eq 0 ]]; then
    (cd /
    for i in $(dotfiles ls-files); do
      echo -n "$(dotfiles -c color.status=always status $i -s | sed "s#$i##")"
      echo -e "¬/$i¬\e[0;33m$(dotfiles -c color.ui=always log -1 --format="%s" -- $i)\e[0m"
    done
    ) | column -t --separator=¬ -T2
  else
    dotfiles $*
  fi
}
```
If called with arguments, it just invokes dotfiles, so I can do dot status or whatever. Otherwise, it shows me a fancy summary that looks like this:

The first column shows the status flags in colour (modified, deleted, staged, etc). In this screenshot, firefox userChrome has been modified, and bashrc has a modification staged. The second column is the full path to the file. The third column is the commit message for the last change affecting that file, a bit like the summary github or gitlab might show.

This setup is immensely satisfying. In the same way that git lets you muck about with files without worrying about getting back to a working state, I can now muck about with anything on the OS. The number of times in the past that I've had a problem, found it and fixed it, only to re-encounter it a few years later and have to work it out again, well, suddenly it all seems worth it, as I can now appreciate having a complete history of every config file I care about.

One of the most common problems I encounter, especially on the Windows machine, is that there's a solution to some problem that no doubt requires editing the registry, which I can do, but then a few weeks later some software update reverts the fix. I used to have a notepad with all the changes I'd made to the registry so that I can re-apply them when they get overwritten. It was an awful, unsatisfying mess. The same thing can happen on linux, but at least now I can immediately see the effects by running my dot function above. If a tracked file is changed after a system update, I can see it, and either restore it or deal with the problem some other way, but at least it doesn't sit there silently until I eventually run into the problem again.

I started this a while back, but my current laptop is the first time I've tracked everything from a clean install. There's always a bit of hacking to get the boot process just right and to iron out the hardware quirks, and having that saved in the dotfiles history means next time, in a few years, I'll have something concrete to look back on, instead of poking around in the depths of the old /etc/.

We could go further with this. I considered splitting the repo into two, either as two .dotfiles folders or as two branches with a git-worktree arrangement. One would be a shared branch with everything I always want, shell config, vimrc and so on. The other would have the machine-specific config, keycode remaps, udev rules and so on. This could be a very clean solution if I wanted to have everything tracked across multiple machines. I have a feeling there'd be some niggling edge case that could trip it up, however, where something tracked in the shared branch conflicts with something you want to locally be different. It could quite quickly turn into a mess.

Anyway, that's my dotfiles tracking advice, there may be better ways to do it but if you use linux and don't have anything like this already, I strongly recommend it. 

