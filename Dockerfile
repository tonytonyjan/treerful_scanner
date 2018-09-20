FROM ruby:2.6.0-preview2-alpine3.8
RUN apk add --no-cache --virtual .build-deps curl fontconfig \
  && curl -O https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKtc-hinted.zip \
  && mkdir -p /usr/share/fonts/NotoSansCJKtc \
  && unzip NotoSansCJKtc-hinted.zip -d /usr/share/fonts/NotoSansCJKtc/ \
  && rm NotoSansCJKtc-hinted.zip \
  && fc-cache -fv \
  && apk del .build-deps
RUN apk add --no-cache chromium openssl-dev
RUN apk add --no-cache --virtual .build-deps make gcc g++ libc-dev zlib-dev libxml2-dev
ARG VERSION
RUN gem install -N treerful_scanner -v "$VERSION"
RUN apk del .build-deps
ENTRYPOINT ["treerful_scanner"]