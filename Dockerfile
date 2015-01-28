FROM ubuntu:14.04
MAINTAINER Jeff Minard <jeff.minard@creditkarma.com>

ENV REFRESH_DATE   2015-01-28
ENV MCROUTER_REPO  https://github.com/facebook/mcrouter.git
ENV MCROUTER_DIR   /usr/local/mcrouter

# Start by turning on interactive commands
# The norm is to pass this when making apt-* calls, but since the mcrouter install script
# has apt-* calls I can't modify, we need to set this globally.
ENV DEBIAN_FRONTEND noninteractive

# Update, install tools, clone repo, install mcrouter, link it up, remove build tools, cleanup
RUN echo "-- Grabbing git ---------" && apt-get -y install git && \
    echo "-- Making install dir ---" && mkdir -p $MCROUTER_DIR && \
    echo "-- Cloning repo ---------" && git clone $MCROUTER_REPO $MCROUTER_DIR/repo && \
    echo "-- Installing mcrouter --" && $MCROUTER_DIR/repo/mcrouter/scripts/install_ubuntu_14.04.sh $MCROUTER_DIR && \
    echo "-- Installing symlink ---" && ln -s $MCROUTER_DIR/install/bin/mcrouter /usr/local/bin/mcrouter && \
    echo "-- Cleanup: script ------" && $MCROUTER_DIR/repo/mcrouter/scripts/clean_ubuntu_14.04.sh $MCROUTER_DIR && \
    echo "-- Cleanup: rm ----------" && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# And now we set the frontend back to the default
ENV DEBIAN_FRONTEND newt

CMD ["mcrouter", "--help"]
