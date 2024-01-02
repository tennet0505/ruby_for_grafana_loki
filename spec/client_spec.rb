# spec/client_spec.rb
require 'spec_helper'
require 'ruby_for_grafana_loki'


require 'spec_helper' # This assumes you have a spec_helper.rb file for RSpec configuration
require_relative '../lib/ruby_for_grafana_loki/client' # Adjust the path accordingly

RSpec.describe Client do
  let(:config) do
    {
      'base_url' => 'https://example.com',
      'log_file_path' => 'path/to/log_file.log',
      'logs_type' => %w(ERROR WARN FATAL INFO DEBUG),
      'intercept_logs' => true
      # Add other required configuration options
    }
  end

  subject(:client) { described_class.new(config) }

  describe '#initialize' do
    it 'initializes with the correct attributes' do
      expect(client.job_name).to eq('job name')
      expect(client.host_name).to eq('host name')
      expect(client.max_buffer_size).to eq(20)
      expect(client.interaction_interval).to eq(1)
      expect(client.logger).to be_a(InterceptingLogger)
      expect(client.connection).to be_a(Faraday::Connection)
      # Add other expectations based on your implementation
    end
  end

  describe '#send_log' do
    it 'buffers logs when they match the log type' do
      log_message = 'ERROR: Something went wrong'
      allow(client).to receive(:match_logs_type?).with(log_message).and_return(true)

      expect { client.send_log(log_message) }.to change { client.instance_variable_get(:@log_buffer).size }.by(1)
    end
  end
end