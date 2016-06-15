# Minimum viable Solr Graphite

Inspired by dlutzy's excellent [mvredisgraphite](https://github.com/dlutzy/mvredisgraphite) here is mvsg.

Hopefully pretty simple to use, make sure `mvsg.py` and `mvsg.sh` are in the same folder and set the following environment variables:

* `ENVIRONMENT` - basically a prefix 
* `SOLR_HOST` - the host on which Solr is running
* `SOLR_PORT` - the port on which Solr is running
* `CARBON_HOST` - the host on which Carbon is running
* `CARBON_PORT` - the port on which Carbon is receiving metrics
* `RANDOM_SLEEP` - an optional setting which will make the script sleep between 1 and `$RANDOM_SLEEP` seconds after retrieving the metrics but before sending them to Carbon (defaults to 0, which is off)
* `OMIT_JVM_STATS` - an optional setting which will cause the script to omit JVM metrics, handy if you are using some other method to get JVM-level metrics into Carbon (defaults to false)

Then run `mvsg.sh` from wherever you've put it. It'll gather the metrics from Solr and fire them over to Carbon.

By default, this will start creating metrics with a prefix of `$ENVIRONMENT.solr.$HOST`. You can override by setting `PREFIX` to fit your own schema.