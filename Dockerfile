FROM debian as builder

MAINTAINER Pedro Ruiz <peruvapedro99@gmail.com>

WORKDIR /tmp

# Install build dependences
RUN apt-get update
RUN apt-get install -y g++ \
                       make \
                       libowfat-dev \
                       zlib1g-dev \
                	   git

# Copy code
COPY ./ /tmp/

# Build code
RUN make -j4

FROM scratch

COPY --from=builder /tmp/opentracker /opentracker

COPY ./config/opentracker.conf /opentracker.conf
COPY ./config/whitelist.txt	/whitelist.txt
COPY ./config/blacklist.txt	/blacklist.conf

EXPOSE 6969

ENTRYPOINT [ "/opentracker", "-f", "/opentracker.conf" ]
