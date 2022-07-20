FROM fluent/fluentd:v1.12.0-1.0

USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish

RUN gem install fluent-plugin-elasticsearch

USER fluent
