FROM golang:1.19.1-buster as go-target
RUN apt-get update && apt-get install -y wget
ADD . /ascii-image-converter
WORKDIR /ascii-image-converter
RUN go build
RUN wget https://download.samplelib.com/jpeg/sample-clouds-400x300.jpg
RUN wget https://download.samplelib.com/jpeg/sample-red-400x300.jpg
RUN wget https://download.samplelib.com/jpeg/sample-green-200x200.jpg
RUN wget https://download.samplelib.com/jpeg/sample-green-100x75.jpg

FROM golang:1.19.1-buster
COPY --from=go-target /ascii-image-converter/ascii-image-converter /
COPY --from=go-target /ascii-image-converter/*.jpg /testsuite/

ENTRYPOINT []
CMD ["/ascii-image-converter", "@@"]
