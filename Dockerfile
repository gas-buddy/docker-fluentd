FROM fluent/fluentd:onbuild

WORKDIR /home/fluent

ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

USER root

RUN apk add --no-cache sudo build-base ruby-dev && \
    sudo -u fluent gem install fluent-plugin-elasticsearch fluent-plugin-prometheus && \
    rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && \
    sudo -u fluent gem sources -c && \
    apk del sudo build-base ruby-dev

USER fluent
CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
