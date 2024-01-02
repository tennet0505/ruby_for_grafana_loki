
## Prerequisites

What things you need to install the software and how to install them.

<pre>
You need to setup Grafana, Grafana Loki for your env: 
- you can follow this video: https://www.youtube.com/watch?v=0B-yQdSXFJE
- about Grafana https://grafana.com/docs/agent/latest/flow/setup/start-agent/
- brew install grafana (install Grafana) 
</pre>

# Usage gem in test env:
<pre>
To run gem for test(for Macbook):
after installing Grafana
- brew services start grafana (start Grafana)

  after start grafana open browser http://localhost:3000 (sighIn with login: admin, password: admin.)
  setup Grafana > Home > Connections > Data sources > Loki
  setup URL: http://localhost:3100

- brew services restart grafana-agent-flow                         // restart Grafana
- brew services stop grafana-agent-flow                            // stop Grafana

- Ctrl+C (stop Loki)                                               // stop Grafana Loki
</pre>

# Test gem with irb:
<pre>
Go to your project folder:
- gem uninstall build rails_loki_exporter_dev                       // if you install gem before
- gem build rails_loki_exporter_dev.gemspec
- gem install rails_loki_exporter_dev-0.0.1.gem
- irb (launch ruby's interactive console)

- require 'ruby_for_grafana_loki'
- logs_type = %w(ERROR WARN FATAL INFO)                             // use custom logs type: ERROR, WARN, FATAL, INFO, DEBUG
- log_file_path = "log/#{Rails.env}.log"                            // your path to *.log
- client = RailsLokiExporterDev.client(log_folder_name, logs_type)  // create client
- result = client.send_all_logs

</pre>

# Usage gem in your application:
 - add gem "ruby_for_grafana_loki-0.0.6.gem"                        // to the Gemfile
 - bundle install

In your Rails app project 
- create file 'config/config.yml'

<pre>
auth_enabled: true 
base_url: 'https://yourUrl.grafana.net'
user_name: '765***'
password: 'glc_eyJvIjoiOTk0MjI2IiwibiI6Im...wIn19'
log_file_path: "log/#{Rails.env}.log"
logs_type: '%w(INFO DEBUG)' # or use logs_type: %w(ERROR WARN FATAL INFO DEBUG)
intercept_logs: true
</pre>

- in your 'application.rb'
<pre>
    config.after_initialize do
      config_file_path = File.join(Rails.root, 'config', 'config.yml')   // path to your created config.yml
      logger = RubyForGrafanaLoki.create_logger(config_file_path)
      Rails.logger = logger
    end
</pre>
