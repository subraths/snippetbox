# syntax=docker/dockerfile:experimental

FROM golang:alpine as dev
WORKDIR /usr/src/app
COPY go.mod .
RUN go mod download
COPY cmd cmd
COPY ui ui
