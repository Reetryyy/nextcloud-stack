#!/bin/bash

nc -z localhost 443 || exit 1
nc -z hpb_talk 8081 || exit 1
nc -z hpb_recording 1234 || exit 1
