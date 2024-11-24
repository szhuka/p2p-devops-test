# Используем базовый образ Go
FROM golang:1.20 AS builder

WORKDIR /app

# Копируем исходный код
COPY . .

# Сборка приложения
RUN go build -o app .

# Используем минимальный образ для выполнения
FROM alpine:latest

WORKDIR /app

# Копируем собранное приложение
COPY --from=builder /app/app .

# Команда запуска
CMD ["./app"]


