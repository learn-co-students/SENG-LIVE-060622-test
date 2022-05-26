# Add sqlite3 gem to Gemfile

```bash
bundle add sqlite3
```

# Add a Database called dog_walker.db

From the demo directory in the terminal:

```bash
sqlite3 db/dog_walker.db
```

and exit the prompt (ctrl + D)

Run the following command to create the dogs table:

```bash
sqlite3 db/dog_walker.db < db/01_create_dogs.sql
```


# Add database configuration to config/environment.rb

Add these lines above the `require_all "lib"`
```rb
DB = SQLite3::Database.new("db/dog_walker.db")
DB.results_as_hash = true
```