describe Delayed::Backend::Json do
  before do
    Delayed::Job.delete_all
  end

  it 'has payload attribute' do
    TestJob.perform_later("test")
    job = Delayed::Job.first
    expect(job.handler).to eq('{}')
    expect(job.payload['arguments'][0]).to eq('test')
    expect(job.payload_object.job_data['arguments'][0]).to eq('test')
  end
end
