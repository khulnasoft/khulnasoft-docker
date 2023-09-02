KHULNASOFT_IMAGE_VERSION=4.8.0
KHULNASOFT_VERSION=$(echo $KHULNASOFT_IMAGE_VERSION | sed -e 's/\.//g')
KHULNASOFT_TAG_REVISION=1
KHULNASOFT_CURRENT_VERSION=$(curl --silent https://api.github.com/repos/khulnasoft/khulnasoft/releases/latest | grep '\"tag_name\":' | sed -E 's/.*\"([^\"]+)\".*/\1/' | cut -c 2- | sed -e 's/\.//g')
IMAGE_VERSION=${KHULNASOFT_IMAGE_VERSION}

echo KHULNASOFT_VERSION=$KHULNASOFT_IMAGE_VERSION > .env
echo KHULNASOFT_IMAGE_VERSION=$IMAGE_VERSION >> .env
echo KHULNASOFT_TAG_REVISION=$KHULNASOFT_TAG_REVISION >> .env

docker-compose -f build-docker-images/build-images.yml --env-file .env build --no-cache