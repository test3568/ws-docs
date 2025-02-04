FROM node:23.6.1 AS builder

WORKDIR /app/ws-docs
COPY package.json ws-docs.yaml ./

RUN ["npm", "i"]
RUN ["npm", "run", "build"]

FROM nginx:1.27.3

RUN rm -rf /usr/share/nginx/html && mkdir /usr/share/nginx/html

COPY ./nginx/nginx.conf /etc/nginx
COPY --from=builder /app/ws-docs/dist /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]
