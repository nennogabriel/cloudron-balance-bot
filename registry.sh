VERSION=$(node -pe "require('./CloudronManifest.json').version")
APP_NAME=balance-bot
APP_DOMAIN=bb.cmania.co


docker build -t registry.cmania.co/$APP_NAME:$VERSION .
docker push registry.cmania.co/$APP_NAME:$VERSION
echo "cloudron install --image registry.cmania.co/$APP_NAME:$VERSION --location $APP_DOMAIN"
cloudron install --image registry.cmania.co/$APP_NAME:$VERSION --location $APP_DOMAIN



# if [ "$VERSION" = "0.0.1" ]; then
#   echo "cloudron install --image registry.cmania.co/$APP_NAME:$VERSION --location $APP_DOMAIN"
#   cloudron install --image registry.cmania.co/$APP_NAME:$VERSION --location $APP_DOMAIN
# else
#   echo "cloudron update --image registry.cmania.co/$APP_NAME:$VERSION --app $APP_DOMAIN"
#   cloudron update --image registry.cmania.co/$APP_NAME:$VERSION --app $APP_DOMAIN
# fi
