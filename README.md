# blume_api

An API for the [BLUME data of Berlin][blume].

The current version of the API is not deloyed and is just for research purposes.


## Usage

This [Sinatra][sinatra] application can be started with the following shell command:

``` bash
$ ruby api.rb
```

This starts the development server which can be
accessed via [http://localhost:4567](http://localhost:4567).


## API

Here is a list of API paths which can also be found in *api.rb*:

### List of sensor stations
* As JSON: `/api/v1/stations`

### Sensor data for a specific station
* As JSON: `/api/v1/stations/:station_id`
* As CSV: `/api/v1/stations/:station_id/csv`

### Sensor data for a specific station by year
* As JSON: `/api/v1/stations/:station_id/sensordata/:year`
* As CSV: `/api/v1/stations/:station_id/sensordata/:year/csv`

### Sensor data by year
* As JSON: `/api/v1/sensordata/:year`
* As CSV: `/api/v1/sensordata/:year/csv`

### Most recent sensor data
* As JSON: `/api/v1/recent`
* As CSV: `/api/v1/recent/csv`


## See also

* [blume_crawler - A rake task to regularly download and save particulates statistics in Berlin.][blume-crawler]



[blume]: http://www.stadtentwicklung.berlin.de/umwelt/luftqualitaet/de/messnetz/
[sinatra]: http://www.sinatrarb.com
[blume-crawler]: https://github.com/dirkschumacher/blume_crawler
