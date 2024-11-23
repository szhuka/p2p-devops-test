FROM golang:1.20 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o app .

FROM alpine:latest

COPY --from=builder /app/app /app/app

WORKDIR /app

CMD ["./app"]

EXPOSE 8080
