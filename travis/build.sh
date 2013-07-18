#!/bin/sh
set -e

xctool -workspace Moodios.xcworkspace -arch armv7s -arch armv7 -scheme Moodios build test