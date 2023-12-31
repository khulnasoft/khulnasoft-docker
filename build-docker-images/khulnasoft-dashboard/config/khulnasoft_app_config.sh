#!/bin/bash
# Khulnasoft Docker Copyright (C) 2017, Khulnasoft Inc. (License GPLv2)

khulnasoft_url="${KHULNASOFT_API_URL:-https://khulnasoft}"
khulnasoft_port="${API_PORT:-55000}"
api_username="${API_USERNAME:-khulnasoft-kui}"
api_password="${API_PASSWORD:-khulnasoft-kui}"
api_run_as="${RUN_AS:-false}"

dashboard_config_file="/usr/share/khulnasoft-dashboard/data/khulnasoft/config/khulnasoft.yml"

declare -A CONFIG_MAP=(
  [pattern]=$PATTERN
  [checks.pattern]=$CHECKS_PATTERN
  [checks.template]=$CHECKS_TEMPLATE
  [checks.api]=$CHECKS_API
  [checks.setup]=$CHECKS_SETUP
  [extensions.pci]=$EXTENSIONS_PCI
  [extensions.gdpr]=$EXTENSIONS_GDPR
  [extensions.hipaa]=$EXTENSIONS_HIPAA
  [extensions.nist]=$EXTENSIONS_NIST
  [extensions.tsc]=$EXTENSIONS_TSC
  [extensions.audit]=$EXTENSIONS_AUDIT
  [extensions.oscap]=$EXTENSIONS_OSCAP
  [extensions.ciscat]=$EXTENSIONS_CISCAT
  [extensions.aws]=$EXTENSIONS_AWS
  [extensions.gcp]=$EXTENSIONS_GCP
  [extensions.virustotal]=$EXTENSIONS_VIRUSTOTAL
  [extensions.osquery]=$EXTENSIONS_OSQUERY
  [extensions.docker]=$EXTENSIONS_DOCKER
  [timeout]=$APP_TIMEOUT
  [api.selector]=$API_SELECTOR
  [ip.selector]=$IP_SELECTOR
  [ip.ignore]=$IP_IGNORE
  [khulnasoft.monitoring.enabled]=$KHULNASOFT_MONITORING_ENABLED
  [khulnasoft.monitoring.frequency]=$KHULNASOFT_MONITORING_FREQUENCY
  [khulnasoft.monitoring.shards]=$KHULNASOFT_MONITORING_SHARDS
  [khulnasoft.monitoring.replicas]=$KHULNASOFT_MONITORING_REPLICAS
)

for i in "${!CONFIG_MAP[@]}"
do
    if [ "${CONFIG_MAP[$i]}" != "" ]; then
        sed -i 's/.*#'"$i"'.*/'"$i"': '"${CONFIG_MAP[$i]}"'/' $dashboard_config_file
    fi
done


grep -q 1513629884013 $dashboard_config_file
_config_exists=$?

if [[ $_config_exists -ne 0 ]]; then
cat << EOF >> $dashboard_config_file
hosts:
  - 1513629884013:
      url: $khulnasoft_url
      port: $khulnasoft_port
      username: $api_username
      password: $api_password
      run_as: $api_run_as
EOF
else
  echo "Khulnasoft APP already configured"
fi

