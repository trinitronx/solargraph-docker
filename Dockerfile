FROM ruby:3.4.5-alpine3.22

RUN apk add build-base
RUN apk add git sudo

ENV GEM_HOME="/usr/local/bundle"
ENV PATH="$GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH"

RUN echo "Defaults secure_path=\"$PATH\"" | \
    tee /etc/sudoers.d/00-secure-bundler-path && \
    echo "Defaults env_keep += \"GEM_PATH\"" | \
    tee /etc/sudoers.d/00-allow-gem-path

ARG SOLARGRAPH_VERSION=0.56.2

RUN gem install solargraph -v ${SOLARGRAPH_VERSION}
RUN gem install solargraph-rspec

ADD entrypoint.sh /usr/bin/

WORKDIR /app

EXPOSE 7658

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]

CMD [ "socket", "--host=0.0.0.0" ]
