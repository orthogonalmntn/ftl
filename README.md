## Faster Than (Ruby-Refracted) Light

Set up your env vars:

```cp .env.dev .env```

Start the game:

```ruby faster_than_light.rb```

### Background Work:

Start Sidekiq: `bundle exec sidekiq -r ./lib/workers/star_plague_worker.rb`

Make sure that MongoDB is running locally and configured properly in the dotenv file.