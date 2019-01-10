FROM scratch
COPY /releases /helmfiles/releases
COPY /scripts /helmfiles/scripts
COPY /helmfile.yaml /helmfiles/
WORKDIR /
