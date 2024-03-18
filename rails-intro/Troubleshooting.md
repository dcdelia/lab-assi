## Troubleshooting

### VM BIAR
During the lab session, unfortunately, we experienced blocking issues with the new VM BIAR 4.5. We may now have a fix.

Firstly, remove the previously created `rottenpotatoes` folder, if any. Then, we followed these steps to get it to work:
1. Closely follow what listed in [BIAR.md](../BIAR.md) (we added also JavaScript-related instructions for future labs)
2. `rails new rottenpotatoes --skip-test-unit --skip-webpack-install --skip-javascript --skip-turbolinks --skip-spring`
3. `cd rottenpotatoes`
4. run `rails server` to get error message: `sqlite3-1.7.2-x86_64-linux requires ruby version < 3.4.dev, >= 3.0, which is incompatible with the current version, ruby 2.7.2p137`
5. Modify `Gemfile` at line `gem 'sqlite3', '~> 1.4'` to contain `gem 'sqlite3', '~> 1.4.0'`
6. `bundle install`

You should now be able to run `rails server` without errors and connect to `http://localhost:3000`.

### Windows Subsystem for Linux (unsupported)
Students using WSL/WSL2 (which, we remind you, is *not* an officially supported environment for this course) experienced issues with the `timeout` package being missing. Some could solve the problem by doing:
1. `gem install --default bundler`
2. `gem update --system`
3. `bundle update --bundler`

Hope this helps. Thanks for the tip, Dario!
