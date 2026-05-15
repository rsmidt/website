# syntax=docker/dockerfile:1.7

# 1. Build Tailwind CSS
FROM node:20-alpine AS css
WORKDIR /src
RUN corepack enable
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY tailwind.config.js postcss.config.js ./
COPY assets ./assets
COPY layouts ./layouts
COPY content ./content
RUN yarn build:tailwind

# 2. Build the Hugo site
FROM debian:12-slim AS hugo
ARG HUGO_VERSION=0.161.1
ENV HUGO_ENV=production
RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl gzip \
 && rm -rf /var/lib/apt/lists/* \
 && curl -fsSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz" \
    | tar -xz -C /usr/local/bin hugo \
 && chmod +x /usr/local/bin/hugo
WORKDIR /src
COPY . .
COPY --from=css /src/assets/css/main.css ./assets/css/main.css
RUN hugo --minify \
 && find public -type f \( -name '*.css' -o -name '*.js' -o -name '*.svg' -o -name '*.html' -o -name '*.xml' \) \
    -exec gzip -kf {} +

# 3. Serve via nginx
FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=hugo /src/public /usr/share/nginx/html
EXPOSE 80
