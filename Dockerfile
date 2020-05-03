FROM ruby:2.7-alpine

RUN apk add build-base

RUN gem install solargraph

ADD entrypoint.sh /usr/bin/

WORKDIR /app

EXPOSE 7658

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]

CMD [ "socket", "--host=0.0.0.0" ]
