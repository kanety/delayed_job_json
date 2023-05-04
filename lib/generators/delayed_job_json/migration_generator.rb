require 'rails/generators'

module DelayedJobJson
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.join(File.dirname(__FILE__), 'templates')

    def create_migration_file
      migration_template "migration1.rb", "db/migrate/add_payload_to_delayed_jobs.rb", migration_version: migration_version
      migration_template "migration2.rb", "db/migrate/migrate_handler_to_payload_on_delayed_jobs.rb", migration_version: migration_version
    end

    private

    def migration_version
      "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
    end

    def self.next_migration_number(dirname)
      next_migration_number = current_migration_number(dirname) + 1
      ActiveRecord::Migration.next_migration_number(next_migration_number)
    end
  end
end
