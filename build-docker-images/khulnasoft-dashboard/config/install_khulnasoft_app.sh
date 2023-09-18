## variables
KHULNASOFT_APP=https://packages.wazuh.com/4.x/ui/dashboard/khulnasoft-${KHULNASOFT_VERSION}-${KHULNASOFT_UI_REVISION}.zip
KHULNASOFT_CURRENT_VERSION=$(curl --silent https://api.github.com/repos/khulnasoft/khulnasoft/releases/latest | grep '\"tag_name\":' | sed -E 's/.*\"([^\"]+)\".*/\1/' | cut -c 2-)
MAJOR_BUILD=$(echo $KHULNASOFT_VERSION | cut -d. -f1)
MID_BUILD=$(echo $KHULNASOFT_VERSION | cut -d. -f2)
MINOR_BUILD=$(echo $KHULNASOFT_VERSION | cut -d. -f3)
MAJOR_CURRENT=$(echo $KHULNASOFT_CURRENT_VERSION | cut -d. -f1)
MID_CURRENT=$(echo $KHULNASOFT_CURRENT_VERSION | cut -d. -f2)
MINOR_CURRENT=$(echo $KHULNASOFT_CURRENT_VERSION | cut -d. -f3)

## check version to use the correct repository
if [ "$MAJOR_BUILD" -gt "$MAJOR_CURRENT" ]; then
  KHULNASOFT_APP=https://packages-dev.wazuh.com/pre-release/ui/dashboard/khulnasoft-${KHULNASOFT_VERSION}-${KHULNASOFT_UI_REVISION}.zip
elif [ "$MAJOR_BUILD" -eq "$MAJOR_CURRENT" ]; then
  if [ "$MID_BUILD" -gt "$MID_CURRENT" ]; then
    KHULNASOFT_APP=https://packages-dev.wazuh.com/pre-release/ui/dashboard/khulnasoft-${KHULNASOFT_VERSION}-${KHULNASOFT_UI_REVISION}.zip
  elif [ "$MID_BUILD" -eq "$MID_CURRENT" ]; then
    if [ "$MINOR_BUILD" -gt "$MINOR_CURRENT" ]; then
      KHULNASOFT_APP=https://packages-dev.wazuh.com/pre-release/ui/dashboard/khulnasoft-${KHULNASOFT_VERSION}-${KHULNASOFT_UI_REVISION}.zip
    fi
  fi
fi

# Install Khulnasoft App
$INSTALL_DIR/bin/opensearch-dashboards-plugin install $KHULNASOFT_APP --allow-root