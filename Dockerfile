FROM node:lts-alpine3.12 as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npx nx build shopping-list

### shopping list frontend ###
FROM nginx:latest as shopping-list
COPY --from=build /app/dist/apps/shopping-list/browser /usr/share/nginx/html
