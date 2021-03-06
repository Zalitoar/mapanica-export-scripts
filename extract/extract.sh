#!/bin/bash
#
# Script to extract Managua bus routes (IRTRAMMA network) from OpenStreetMap
# and convert it to various suitable formats.
#
# felix (ät) delattre (punkt) de
#

echo ""
echo "EXTRACT BUENOS AIRES PUBLIC TRANSPORT INFO SCRIPT"
echo ""

# Download data from OSM
./download.sh buenos_aires

# Prepare postgres database
./postgis.sh

# Remove old data
rm -rf export/geojson/*

# Extract seperate osm xml files for each route
python buslines/export_buslines.py

echo "--- done  ---"
exit

