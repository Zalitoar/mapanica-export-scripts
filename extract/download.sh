#!/bin/bash
#
# Script to download Managua bus routes (IRTRAMMA network) from OpenStreetMap
#
# felix (ät) delattre (punkt) de
#

# Ensure valid input.
if [ "$1" != "buenos_aires" ]; then
  echo -e "Please specify 'buenos_aires'."
  exit
fi

if [ "$1" = "buenos_aires" ]; then
  echo -e "Downloading basic OSM map for Buenos Aires Metropolitan Area and La Plata from OpenStreetMap"
  wget -O export/buenos_aires.osm --post-file=definitions/buenos_aires-overpass-query.ql "http://overpass-api.de/api/interpreter"
fi

exit

