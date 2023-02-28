VM BIAR Notes
========

These commands may be helpful if you're using the `LXLE-BIAR-4.3` VM at the lab:

```
### RVM workaround for Sakura terminal emulator
biar@biar:~$ /bin/bash --login

### Load specific Ruby build
biar@biar:~$ rvm use ruby-2.7.2
Using /home/biar/.rvm/gems/ruby-2.7.2

### Now we can install gems without sudo
biar@biar:~$ gem install rspec
Fetching rspec-core-3.12.1.gem
Fetching rspec-3.12.0.gem
[...]
```