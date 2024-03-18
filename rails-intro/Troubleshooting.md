## Troubleshooting

### VM BIAR
Unfortunately, during the lab session, we experienced blocking issues with the new VM BIAR 4.5. We may now have a fix.

Firstly, remove the previously created `rottenpotatoes` folder, if any. Then, these are the steps we followed to get it to work:
1. **Closely read and do** what listed in [BIAR.md](../BIAR.md) (we added also JavaScript-related instructions for future labs)
2. Create a new app with `rails new rottenpotatoes --skip-test-unit --skip-webpack-install --skip-javascript --skip-turbolinks --skip-spring`
3. `cd rottenpotatoes`
4. run `rails server` (or `bin/rails server`) to get error message: `sqlite3-1.7.2-x86_64-linux requires ruby version < 3.4.dev, >= 3.0, which is incompatible with the current version, ruby 2.7.2p137`
5. Modify `Gemfile` of the application at line `gem 'sqlite3', '~> 1.4'` to contain `gem 'sqlite3', '~> 1.4.0'`
6. `bundle install`

You should now be able to run `rails server` (or `bin/rails server`) without errors and connect to `http://localhost:3000`. If these instructions don't work, we recommend you to reset your VM to its initial state (hopefully, you made a snapshot). The version shown by Rails on our machine is `6.1.7.7`. Using Rails v7 or higher is **not** supported, especially for the upcoming lab sessions.

### Windows Subsystem for Linux (unsupported)
Students using WSL/WSL2 (which, we remind you, is *not* an officially supported environment for this course) experienced issues with the `timeout` package being missing. Some could solve them by doing:
1. `gem install --default bundler`
2. `gem update --system`
3. `bundle update --bundler`

Hope this helps if you encounter similar problems. Thanks for the tip, Dario!
