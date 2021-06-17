#!/bin/sh

bin/liveman eval "Liveman.ReleaseTasks.migrate()"

bin/liveman start
