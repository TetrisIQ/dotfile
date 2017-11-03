#!/bin/bash
systemctl start bluetooth.service
blueman-adapters
blueman-applet &
blueman-manager &