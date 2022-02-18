# Dockerfile

FROM golang:1.17 AS builder
WORKDIR /go/src/app/
COPY main.go go.mod go.sum .
RUN go mod download all
RUN GOOS=linux GOARCH=amd64 go build -o main main.go

FROM alpine:latest
RUN apk update && apk add git
WORKDIR /go/src/app
COPY --from=builder /go/src/app .
CMD ["./main"]