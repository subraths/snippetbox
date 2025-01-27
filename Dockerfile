# syntax=docker/dockerfile:experimental

FROM golang:alpine as dev
WORKDIR /usr/src/app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
