class MigrateHandlerToPayloadOnDelayedJobs < ActiveRecord::Migration<%= migration_version %>
  class DelayedJob < ActiveRecord::Base
  end

  def up
    DelayedJob.find_each do |job|
      loaded = YAML.respond_to?(:unsafe_load) ? YAML.unsafe_load(job.handler) : YAML.load(job.handler)
      job.update_columns(payload: loaded.job_data)
    end
  end

  def down
    DelayedJob.find_each do |job|
      handler = ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper.new(job.payload).to_yaml
      job.update_columns(handler: handler)
    end
  end
end
