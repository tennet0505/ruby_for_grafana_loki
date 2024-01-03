require File.expand_path('lib/ruby_for_grafana_loki/version', __dir__)

Gem::Specification.new do |spec|
    spec.name                  = 'ruby_for_grafana_loki'
    spec.version               = RubyForGrafanaLoki::VERSION
    spec.authors               = ['Oleg Ten']
    spec.email                 = ['tennet0505@gmail.com']
    spec.summary               = 'Ruby for Grafana Loki'
    spec.description           = 'Send logs to Grafana Loki'
    spec.homepage              = 'https://github.com/tennet0505/31github/tree/main/ruby_for_grafana_loki'
    spec.license               = 'MIT'
    spec.platform              = Gem::Platform::RUBY
    spec.required_ruby_version = '>= 2.7.0'
    spec.files = Dir['README.md','lib/**/*.rb',
                     'fun ruby_for_grafana_loki.gemspec', '.github/* .md',
                     'Gemfile']
    spec.extra_rdoc_files      = ['README.md']
    spec.require_paths         = ['lib']
    spec.add_dependency        'zeitwerk', '~> 2.4'
    spec.add_dependency        'rspec'
end
