FROM ruby:2.1-alpine
MAINTAINER Rudolf Potucek

ENV REFRESHED_AT 2017-04-05

VOLUME /jekyll
COPY Gemfile* /jekyll/

RUN apk update \
 && apk add musl-dev gcc make \ 
 && cd /jekyll \
 && bundle install \
 && rm -rf /root/src /tmp/* /usr/share/man /var/cache/apk/* \

EXPOSE 4000
 
ENTRYPOINT ["jekyll"]
