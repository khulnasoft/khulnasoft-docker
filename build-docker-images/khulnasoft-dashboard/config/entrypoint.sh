#!/bin/bash
# Khulnasoft Docker Copyright (C) 2017, Khulnasoft Inc. (License GPLv2)

INSTALL_DIR=/usr/share/khulnasoft-dashboard
DASHBOARD_USERNAME="${DASHBOARD_USERNAME:-kibanaserver}"
DASHBOARD_PASSWORD="${DASHBOARD_PASSWORD:-kibanaserver}"

# Create and configure Khulnasoft dashboard keystore

yes | $INSTALL_DIR/bin/opensearch-dashboards-keystore create --allow-root && \
echo $DASHBOARD_USERNAME | $INSTALL_DIR/bin/opensearch-dashboards-keystore add opensearch.username --stdin --allow-root && \
echo $DASHBOARD_PASSWORD | $INSTALL_DIR/bin/opensearch-dashboards-keystore add opensearch.password --stdin --allow-root

##############################################################################
# Start Khulnasoft dashboard
##############################################################################

/khulnasoft_app_config.sh $KHULNASOFT_UI_REVISION

/usr/share/khulnasoft-dashboard/bin/opensearch-dashboards -c /usr/share/khulnasoft-dashboard/config/opensearch_dashboards.yml