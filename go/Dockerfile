FROM golang:1.15-alpine as builder

ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.io,direct

WORKDIR /work-dir
COPY . .
RUN go env && go build -o server .

FROM alpine:latest

WORKDIR /work-dir
COPY --from=builder /work-dir/server ./
COPY --from=builder /work-dir/conf ./conf
COPY --from=builder /work-dir/static ./static

EXPOSE 8080

ENTRYPOINT ./server


# docker build -t golang .
# docker run -p 8080:8080 --name server golang
