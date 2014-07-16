blume_api
=============

An API for the [BLUME data of Berlin](http://www.stadtentwicklung.berlin.de/umwelt/luftqualitaet/de/messnetz/).

Current version of the api is deployed at:
[blumeapi.herokuapp.com](http://blumeapi.herokuapp.com/)

* List of sensor stations ([`/api/v1/stations`](http://blumeapi.herokuapp.com/api/v1/stations))
* Sensor data by year ([`/api/v1/sensordata/:year`](http://blumeapi.herokuapp.com/api/v1/sensordata/2011))
    * [`/api/v1/sensordata/:year/csv`](http://blumeapi.herokuapp.com/api/v1/sensordata/2011/csv) gets the data as csv
* Most recent sensor data ([`/api/v1/recent`](http://blumeapi.herokuapp.com/api/v1/recent))
    * [`/api/v1/recent/csv`](http://blumeapi.herokuapp.com/api/v1/recent/csv) gets the data as csv

Data is usually extracted and parsed every night at around 8 pm.  
