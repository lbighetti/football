#!/bin/sh

release_ctl eval --mfa "Football.ReleaseTasks.migrate/1" --argv -- "$@"
