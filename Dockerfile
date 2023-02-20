# To enable ssh & remote debugging on app service change the base image to the one below
# FROM mcr.microsoft.com/azure-functions/node:4-node16-appservice
FROM mcr.microsoft.com/azure-functions/node:4-node18 as build
WORKDIR /home/site

COPY package*.json ./
RUN npm ci

COPY . ./
RUN  npm run build


FROM mcr.microsoft.com/azure-functions/node:4-node18 as run
ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true

WORKDIR /home/site/wwwroot

RUN --mount=src=/home/site,dst=/artifacts,from=build \
    cp -r /artifacts/dist . && \
    mkdir -p ./uwuifier && \
    cp /artifacts/uwuifier/function.json ./uwuifier/function.json && \
    cp /artifacts/package*.json /artifacts/host.json .

RUN npm install --omit=dev

