# DelayedJobJson

Migrate handler of text column to json column for delayed_job.

## Dependencies

* ruby 3.0+
* activerecord 7.0+
* delayed_job 4.1+
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

Edit generated files and leave codes only for your database. An example of generated file is shown as follows:

```ruby
class AddPayloadToDelayedJobs < ActiveRecord::Migration[7.0]
  def up
    case ENV['DATABASE']
    when 'postgresql'
      add_column :delayed_jobs, :payload, :jsonb, null: false, default: {}
      add_index :delayed_jobs, :payload, using: :gin
    when 'mysql'
      add_column :delayed_jobs, :payload, :json
    else
      add_column :delayed_jobs, :payload, :json, null: false, default: {}
    end
  end

  def down
    case ENV['DATABASE']
    when 'postgresql'
      remove_column :delayed_jobs, :payload, :jsonb, null: false, default: {}
    when 'mysql'
      remove_column :delayed_jobs, :payload, :json
    else
      remove_column :delayed_jobs, :payload, :json, null: false, default: {}
    end
  end
end
```

Then run migration:

    $ rake db:migrate

This migration adds `payload` column to delayed_jobs table, and YAML data in `handler` column is migrated to `payload` as json data.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kanety/delayed_job_json.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
