# Auxiliar
FROM alpine:3.13 as compile
RUN apk update && apk add --no-cache \
	file autoconf automake libtool gettext gettext-dev make g++ texinfo

WORKDIR /tmp
RUN wget https://github.com/eradman/entr/archive/4.7.tar.gz
RUN tar -xvzf 4.7.tar.gz

WORKDIR /tmp/entr-4.7
RUN ./configure
RUN make test
RUN make install

# Imagem
FROM alpine:3.13
COPY --from=compile /usr/local/bin/entr /usr/local/bin/.
ENTRYPOINT ["entr"]
