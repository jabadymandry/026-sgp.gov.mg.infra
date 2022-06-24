#!/bin/bash
ssh-keygen -t rsa -m pem -b 2048  -q -f ./$1
