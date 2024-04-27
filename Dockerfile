FROM node:lts as dev

WORKDIR /app

COPY package*.json ./
RUN npm i -g pnpm && \
    pnpm install

COPY . .

FROM dev as builder 
RUN npx nx build shopping-list

### shopping list frontend ###
FROM nginx:latest as shopping-list
COPY --from=builder /app/dist/apps/shopping-list/browser /usr/share/nginx/html
