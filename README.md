# OpenSMTPD docker container image

[![Build Status](https://travis-ci.org/wodby/opensmptd.svg?branch=master)](https://travis-ci.org/wodby/opensmptd)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/opensmptd.svg)](https://hub.docker.com/r/wodby/opensmptd)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/opensmptd.svg)](https://hub.docker.com/r/wodby/opensmptd)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

## Supported tags and respective `Dockerfile` links

- [`6.0`, `latest` (*6.0/Dockerfile*)](https://github.com/wodby/opensmptd/tree/master/6.0/Dockerfile)

## Actions

Usage:
```
make COMMAND [params ...]

commands:
    check-ready [host max_try wait_seconds delay_seconds]
 
default params values:
    host localhost
    max_try 1
    wait_seconds 1
    delay_seconds 0
```

## Using in production

Deploy OpenSMTPD to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com).
