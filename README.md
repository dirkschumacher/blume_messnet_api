# blume_api

An API for the [BLUME data of Berlin][blume].

The current version of the API is not deloyed.


## Usage

This [Sinatra][sinatra] application can be started with the following shell command:

``` bash
$ ruby api.rb
```

This starts the development server which can be
accessed via [http://localhost:4567](http://localhost:4567).


## API

Here is a list of API paths which can also be found in *api.rb*:

* List of sensor stations: `/api/v1/stations`
* Sensor data by year: `/api/v1/sensordata/:year`
    * `/api/v1/sensordata/:year/csv` serves the data as csv
* Most recent sensor data: `/api/v1/recent`
    * `/api/v1/recent/csv` serves the data as csv


## See also

* [blume_crawler - A rake task to regularly download and save particulates statistics in Berlin.][blume-crawler]



[blume]: http://www.stadtentwicklung.berlin.de/umwelt/luftqualitaet/de/messnetz/
[sinatra]: http://www.sinatrarb.com
[blume-crawler]: https://github.com/dirkschumacher/blume_crawler
