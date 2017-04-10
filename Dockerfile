FROM ruby:2.1-alpine

ENV \
  MAINTAINER Rudolf Potucek \
  REFRESHED_AT 2017-04-05

VOLUME /jekyll-src
VOLUME /jekyll-dst
COPY Gemfile* /

RUN apk update \
 && apk add musl-dev gcc make \ 
 && bundle install \
 && apk del musl-dev gcc make \
 && rm -rf /root/src /tmp/* /usr/share/man /var/cache/apk/* \
 && rm -rf /usr/local/bundle/cache/* /usr/local/bundle/gems/*/ext \

EXPOSE 4000
 
ENTRYPOINT ["jekyll"]
CMD ["serve","-s","/jekyll-src","-d","/jekyll-dst","--force_poll","--host","0.0.0.0"]
