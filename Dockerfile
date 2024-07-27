# syntax=docker/dockerfile:experimental

FROM golang:alpine as dev
WORKDIR /usr/src/app
COPY . .
RUN go mod download
