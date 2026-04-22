#!/bin/bash

# -------------------------
# VARIABLES 
# -------------------------
LOCATION="westeurope"              # change if needed
RESOURCE_GROUP="rg-myapp-demo"
APP_SERVICE_PLAN="asp-myapp-demo"
WEB_APP_NAME="myappdemo$RANDOM"   # must be globally unique
RUNTIME="NODE|20-lts"             # change if needed
SKU="B1"                          # Basic tier

# -------------------------
# LOGIN (if running locally)
# -------------------------
# az login

# -------------------------
# CREATE RESOURCE GROUP
# -------------------------
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION

# -------------------------
# CREATE APP SERVICE PLAN
# -------------------------
az appservice plan create \
  --name $APP_SERVICE_PLAN \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku $SKU \
  --is-linux

# -------------------------
# CREATE WEB APP
# -------------------------
az webapp create \
  --resource-group $RESOURCE_GROUP \
  --plan $APP_SERVICE_PLAN \
  --name $WEB_APP_NAME \
  --runtime $RUNTIME

# -------------------------
# ENABLE LOGGING
# -------------------------
az webapp log config \
  --name $WEB_APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --application-logging azureblobstorage \
  --level information

# -------------------------
# DEPLOY SAMPLE APP (Optional)
# -------------------------
az webapp up \
  --name $WEB_APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --runtime $RUNTIME

echo "-------------------------------------"
echo "App deployed successfully!"
echo "URL: https://$WEB_APP_NAME.azurewebsites.net"
echo "-------------------------------------"
