## variables
APT_KEY=https://packages.khulnasoft.com/key/GPG-KEY-KHULNASOFT
REPOSITORY="deb https://packages.khulnasoft.com/4.x/apt/ stable main"
KHULNASOFT_CURRENT_VERSION=$(curl --silent https://api.github.com/repos/khulnasoft/khulnasoft/releases/latest | grep '\"tag_name\":' | sed -E 's/.*\"([^\"]+)\".*/\1/' | cut -c 2-)
MAJOR_BUILD=$(echo $KHULNASOFT_VERSION | cut -d. -f1)
MID_BUILD=$(echo $KHULNASOFT_VERSION | cut -d. -f2)
MINOR_BUILD=$(echo $KHULNASOFT_VERSION | cut -d. -f3)
MAJOR_CURRENT=$(echo $KHULNASOFT_CURRENT_VERSION | cut -d. -f1)
MID_CURRENT=$(echo $KHULNASOFT_CURRENT_VERSION | cut -d. -f2)
MINOR_CURRENT=$(echo $KHULNASOFT_CURRENT_VERSION | cut -d. -f3)

## check version to use the correct repository
if [ "$MAJOR_BUILD" -gt "$MAJOR_CURRENT" ]; then
  APT_KEY=https://packages-dev.khulnasoft.com/key/GPG-KEY-KHULNASOFT
  REPOSITORY="deb https://packages-dev.khulnasoft.com/pre-release/apt/ unstable main"
elif [ "$MAJOR_BUILD" -eq "$MAJOR_CURRENT" ]; then
  if [ "$MID_BUILD" -gt "$MID_CURRENT" ]; then
    APT_KEY=https://packages-dev.khulnasoft.com/key/GPG-KEY-KHULNASOFT
    REPOSITORY="deb https://packages-dev.khulnasoft.com/pre-release/apt/ unstable main"
  elif [ "$MID_BUILD" -eq "$MID_CURRENT" ]; then
    if [ "$MINOR_BUILD" -gt "$MINOR_CURRENT" ]; then
      APT_KEY=https://packages-dev.khulnasoft.com/key/GPG-KEY-KHULNASOFT
      REPOSITORY="deb https://packages-dev.khulnasoft.com/pre-release/apt/ unstable main"
    fi
  fi
fi

apt-key adv --fetch-keys ${APT_KEY}
echo ${REPOSITORY} | tee -a /etc/apt/sources.list.d/khulnasoft.list