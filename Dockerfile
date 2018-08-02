FROM scratch
COPY helmfile.d/ /helmfile.d/
COPY scripts/ /scripts/
WORKDIR /
