#!/bin/bash

echo "---- running command: uninstall build ruby_for_grafana_loki ----"
gem uninstall build ruby_for_grafana_loki
echo " "
echo "---- running command: build ruby_for_grafana_loki.gemspec ----"
gem build ruby_for_grafana_loki.gemspec
echo " "
echo "---- running command: install ruby_for_grafana_loki-0.0.91.gem ----"
gem install ruby_for_grafana_loki-0.0.91.gem
