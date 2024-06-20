# frozen_string_literal: true

module Delayed
  module Backend
    module Json
      module Patch
        def payload_object=(object)
          @payload_object = object
          self.handler = '{}'
          self.payload = object.job_data
        end

        def payload_object
          if payload.present?
            @payload_object ||= ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper.new(payload)
          else
            super
          end
        end
      end
    end
  end
end

Delayed::Job.prepend Delayed::Backend::Json::Patch
