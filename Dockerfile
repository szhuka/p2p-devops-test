# Используем базовый образ Go
FROM golang:1.20 AS builder

WORKDIR /app

# Копируем исходный код
COPY . .

# Сборка приложения для Linux
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app main.go

# Используем минимальный образ для выполнения
FROM alpine:latest

WORKDIR /app

# Установка необходимых библиотек
RUN apk add --no-cache libc6-compat

# Копируем собранное приложение
COPY --from=builder /app/app .

# Команда запуска
CMD ["./app"]

