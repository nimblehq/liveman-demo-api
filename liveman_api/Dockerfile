FROM livebook/livebook:0.2.0

ENV LIVEBOOK_DEFAULT_RUNTIME=mix:/data/lib/liveman_api

WORKDIR /data

RUN mkdir notebook
COPY . ./lib/liveman_api

# docker build -f Dockerfile-liveman -t liveman ./
# docker run -p 8080:8080 -e LIVEBOOK_PASSWORD=livemanisawesome -v $(pwd)/notebook:/data/notebook liveman

CMD [ "/app/bin/livebook", "start" ]
