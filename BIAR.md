VM BIAR Notes
========

These notes may be helpful if you are using the LXLE-BIAR VM (version 4.3 or higher), especially at the lab.

## Getting started with RVM

### Loading the environment

In this course, we will typically use Ruby `v2.7.2`:

```
### Load specific Ruby build
biar@biar:~$ rvm use ruby-2.7.2
Using /home/biar/.rvm/gems/ruby-2.7.2
```

To save time, you may add the following line at the end of your `.profile` file in your `$HOME` directory:

```
shopt -q login_shell && rvm use ruby-2.7.2
```

Which will check for a login shell before loading RVM.

### Package installation
We install packages locally using `gem`. For example, to install `rspec` use:
```
biar@biar:~$ gem install rspec
Fetching rspec-core-3.12.1.gem
Fetching rspec-3.12.0.gem
[...]
```

### Login shell
To load a Ruby build, RVM needs to work on a *login shell* (or you will get an error instead). There are two ways to obtain one:

1. Run this command to spawn a login shell before calling RVM:
```
biar@biar:~$ /bin/bash --login
```

2. Modify the settings of the `Sakura` terminal emulator. Click on the Start icon of the desktop environment, then `Control Menu` -> `Utilities` -> `Sakura` (right-click) -> `Properties`. Go to the `Desktop Entry` pane and modify the `Command` option to add the `-l` flag (so as it reads: `sakura -l`). From now on, every instance of Sakura will run a login shell and you can invoke RVM directly. You may look up instructions online for other terminal emulators.