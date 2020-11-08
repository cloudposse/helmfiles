FROM scratch
COPY /releases /helmfiles/releases
COPY /scripts /helmfiles/scripts
WORKDIR /
