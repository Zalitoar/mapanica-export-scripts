#!/usr/bin/python
# -*- coding: utf-8 -*-

# External lib
import sys

# Internal scripts
import db_connection
import db_queries
import conversions
import filehandler


import logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

# Set up database connection
con = db_connection.get_db()

# Execute query to obtain relations of the lines of the irtramma network
sql = """SELECT id, tags FROM planet_osm_rels WHERE ARRAY['network','Nacional']<@tags;""";

# Run through buslines
for nacional_relation in con.ExecuteSQL(sql):

    # Prepare relation data from db results
    relation_id = nacional_relation.id;
    relation_tags = dict(zip(nacional_relation.tags[0::2], nacional_relation.tags[1::2]))

    # Get data
    busline = db_queries.get_busline(relation_id);
    busstops = db_queries.get_busstops(relation_id);
    busline_length = db_queries.get_length(relation_id);


    # Convert to GeoJson file
    #geojson = conversions.convert_geojson(relation_tags, busline, busstops);
    filehandler.write_json(relation_tags['ref'], busline, busstops);

    # Convert to SHP file
    #filehandler.write_shp(relation_tags['ref'], busline, busstops);

    # Debugging
    #logging.debug(relation_tags['ref'], '%s');
