#!/usr/bin/env bash

sensors -j | jq -r '.k10temp_pci_00c3.Tctl.temp1_input'
