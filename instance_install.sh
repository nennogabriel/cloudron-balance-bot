VERSION=$(node -pe "require('./CloudronManifest.json').version")
APP_NAME=APP_NAME
APP_DOMAIN=FINAL_APP_DOMAIN
REGISTRY_DOMAIN=YOUR_REGISTRY_DOMAIN

docker build -t $REGISTRY_DOMAIN/$APP_NAME:$VERSION .
docker push $REGISTRY_DOMAIN/$APP_NAME:$VERSION


if [ "$VERSION" = "0.0.1" ]; then
  echo "cloudron install --image $REGISTRY_DOMAIN/$APP_NAME:$VERSION --location $APP_DOMAIN"
  cloudron install --image $REGISTRY_DOMAIN/$APP_NAME:$VERSION --location $APP_DOMAIN
else
  echo "cloudron update --image $REGISTRY_DOMAIN/$APP_NAME:$VERSION --app $APP_DOMAIN"
  cloudron update --image $REGISTRY_DOMAIN/$APP_NAME:$VERSION --app $APP_DOMAIN
fi
