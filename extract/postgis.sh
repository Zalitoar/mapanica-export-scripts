#!/bin/bash
#
#

function preparedb {

  echo ""
  echo "Preparing Postgres database"

  # Prepare postgres DB
  psql -U postgres -h localhost -c "drop database osm_buenos_aires;"
  psql -U postgres -h localhost -c "create database osm_buenos_aires;"
  psql -U postgres -h localhost -d osm_buenos_aires -c "CREATE EXTENSION hstore;"
  psql -U postgres -h localhost -d osm_buenos_aires -f /usr/share/postgresql/9.4/contrib/postgis-2.1/postgis.sql
  psql -U postgres -h localhost -d osm_buenos_aires -f /usr/share/postgresql/9.4/contrib/postgis-2.1/spatial_ref_sys.sql
}

function import {

  echo ""
  echo "Import downloaded geo info into postgres DB"
  osm2pgsql -sG --hstore --style definitions/osm2pgsql.style  -d osm_buenos_aires -H localhost -U postgres export/buenos_aires.osm

  if [ "$1" = "init" ]; then

    echo ""
    echo "Createing a TileMill project on the fly (osm-bright)"
    cd references/osm-bright
    ./make.py
    cd ../..
  fi
}

function cleanup {
  echo ""
  echo "Cleaning up"
  # Missing
  exit
}


preparedb
import
cleanup
