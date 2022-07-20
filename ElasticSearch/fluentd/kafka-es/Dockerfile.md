# This is basic docker file with kafka and elasticsearch plugin.


```
# The version may change.
FROM fluentd:v1.6-debian-1 

USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN buildDeps="sudo make gcc g++ libc-dev build-essential autoconf automake libtool libsnappy-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps 

RUN sudo gem install fluent-plugin-elasticsearch \
 && sudo gem install fluent-plugin-kafka \
 && sudo gem install snappy \
 && sudo gem install extlz4 --no-document \
 && gem install zstd-ruby --no-document

RUN sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent

```
