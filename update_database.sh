#!/bin/bash

cd backend/

~/development/dart-sdk-2-7-2/bin/pub global run aqueduct db generate

~/development/dart-sdk-2-7-2/bin/pub global run aqueduct db upgrade
