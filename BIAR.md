VM BIAR Notes
========

These commands and tips may be helpful if you are using the `LXLE-BIAR-4.3` VM (especially at the lab).

## Getting started with RVM

### Loading the environment

Typically, we will use Ruby `v2.7.2`:

```
### Load specific Ruby build
biar@biar:~$ rvm use ruby-2.7.2
Using /home/biar/.rvm/gems/ruby-2.7.2
```

To save time, you may add this command at the end of your `.profile` file in your `$HOME` directory.

### Package installation
We install packages locally using `gem`:
```
biar@biar:~$ gem install rspec
Fetching rspec-core-3.12.1.gem
Fetching rspec-3.12.0.gem
[...]
```

Partial list of packages used across lab exercises: `bundler rspec` (*may be updated later in the course*)

### Login shell
To load a Ruby build, RVM needs to work on a *login shell* (or you will get an error instead). There are two ways to obtain one:

1. Run this command to spawn a login shell before calling RVM:
```
biar@biar:~$ /bin/bash --login
```

2. Modify the settings of the `Sakura` terminal emulator. Click on the Start icon of the desktop environment, then `Control Menu` -> `Utilities` -> `Sakura` (right-click) -> `Properties`. Go to the `Desktop Entry` pane and modify the `Command` option to add the `-l` flag (so as it reads: `sakura -l`). From now on, every instance of Sakura will run a login shell and you can invoke RVM directly. You may look up instructions online for other terminal emulators.

## JavaScript environment
Rails has some JavaScript dependencies to meet when creating a new application with a default configuration. The VM comes with an outdated version of NodeJS and misses other packages. To get around this issue, do as follows:

1. Download and unpack **NodeJS v12.0.0** (note: too recent builds may not work on the VM):

```
$ wget https://nodejs.org/dist/v12.0.0/node-v12.0.0-linux-x64.tar.xz
$ tar xvf node-v12.0.0-linux-x64.tar.xz
$ mv node-v12.0.0-linux-x64 $HOME/nodejs
```

2. Modify the `.profile` file in your `$HOME` folder. Add the following line **before** the ones involving RVM:
`export PATH="$PATH:$HOME/nodejs/bin"`

To quickly open it in an editor, you can try: `code $HOME/.profile`.

Open a new terminal, then try `node -v`: if the configuration was successful, you will read `v12.0.0`.

3. Install the Yarn package manager. We can use NPM from the newly installed NodeJS build: `npm install -g yarn`.
