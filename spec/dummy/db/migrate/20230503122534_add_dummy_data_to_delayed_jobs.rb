class AddDummyDataToDelayedJobs < ActiveRecord::Migration::Current
  class DelayedJob < ActiveRecord::Base
  end

  def up
    DelayedJob.create!(
      priority: 0,
      attempts: 0,
      handler: ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper.new(
        "job_class"=>"TestJob",
        "job_id"=>"a5c053b3-fe46-4bc3-94d7-553503d130f1",
        "provider_job_id"=>nil,
        "queue_name"=>"default",
        "priority"=>nil,
        "arguments"=>["test"],
        "executions"=>0,
        "exception_executions"=>{},
        "locale"=>"en",
        "timezone"=>"UTC",
        "enqueued_at"=>"2023-05-03T12:35:57Z"
      ).to_yaml
    )
    clear_schema_cache
  end

  def down
    DelayedJob.delete_all
    clear_schema_cache
  end

  def clear_schema_cache
    DelayedJob.connection.schema_cache.clear!
    DelayedJob.reset_column_information
  end
end
