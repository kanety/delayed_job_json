class AddPayloadToDelayedJobs < ActiveRecord::Migration<%= migration_version %>
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
