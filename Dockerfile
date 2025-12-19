FROM golang:1.25-alpine AS builder
WORKDIR /app

COPY go.mod .
RUN go mod download

COPY . .
RUN go build -o sponsors-webhook .

FROM alpine:latest
WORKDIR /app
COPY ./static /app/static/
COPY --from=builder /app/sponsors-webhook .
CMD ["./sponsors-webhook"]
