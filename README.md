# DelayedJobJson

Migrate handler of text column to json column for delayed_job.

## Dependencies

* ruby 2.7+
* activerecord 6.0+
* delayed_job 4.1
* delayed_job_active_record 4.1

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'delayed_job_json'
```

And then execute:

    $ bundle

## Usage

Generate migration files:

    $ rails generate delayed_job_json:migration

Run migration:

    $ rake db:migrate

This migration adds `payload` column to delayed_jobs table, and YAML data in `handler` column is migrated to `payload` as json data.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kanety/delayed_job_json.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
