FROM alpine:3.4

ENV PROJECT_NAME=goshawkdb

####### DO NOT CHANGE ################################################################################

ENV GOPATH="/gopath" PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
# Add community repo to list for go 1.6.3 install
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

COPY ./docker/run.sh /bin/
COPY ./docker/config.json /etc/goshawkdb/
COPY ./docker/user1.pem /etc/goshawkdb/

RUN apk update && apk add --update ca-certificates go=1.6.3-r0 git bzr mercurial gcc lmdb lmdb-dev musl-dev && \
    go get goshawkdb.io/server/cmd/goshawkdb && \
    cd /gopath/src/goshawkdb.io/server/cmd/goshawkdb && go build && \
    /bin/mv /gopath/src/goshawkdb.io/server/cmd/goshawkdb/goshawkdb /usr/bin/ && \
    /bin/chmod +x /bin/run.sh && \
    /bin/rm -rf /gopath && \
    apk del go git bzr mercurial gcc lmdb-dev musl-dev && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/bin/run.sh"]

#######################################################################################################
