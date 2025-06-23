FROM ruby:3.4.4-alpine3.22

RUN apk add build-base
RUN apk add git

ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

ARG SOLARGRAPH_VERSION=0.55.2

RUN gem install solargraph -v ${SOLARGRAPH_VERSION}

ADD entrypoint.sh /usr/bin/

WORKDIR /app

EXPOSE 7658

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]

CMD [ "socket", "--host=0.0.0.0" ]

