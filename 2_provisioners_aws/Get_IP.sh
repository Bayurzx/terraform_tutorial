#!/bin/bash

PUBLIC_IP=$(curl -s ifconfig.me)
jq -n --arg public_ip "$PUBLIC_IP" '{"public_ip": $public_ip}'
