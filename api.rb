require 'sinatra'
require_relative './models/sensor.rb'
require_relative './models/sensor_data.rb'

configure do
  Mongoid.load!('./mongoid.yml')
end

def convert_to_json(sensor_data) 
    converted_data = sensor_data.map do |e|
        {
            sensor_id: e.sensor.nil? ? :null : e.sensor.sensor_id,
            date: e.date,
            partikelPM10Mittel: e.partikelPM10Mittel,
            partikelPM10Ueberschreitungen: e.partikelPM10Ueberschreitungen,
            russMittel: e.russMittel,
            russMax3h: e.russMax3h,
            stickstoffdioxidMittel: e.stickstoffdioxidMittel,
            stickstoffdioxidMax1h: e.stickstoffdioxidMax1h,
            benzolMittel: e.benzolMittel,
            benzolMax1h: e.benzolMax1h,
            kohlenmonoxidMittel: e.kohlenmonoxidMittel,
            kohlenmonoxidMax8hMittel: e.kohlenmonoxidMax8hMittel,
            ozonMax1h: e.ozonMax1h,
            ozonMax8hMittel: e.ozonMax8hMittel,
            schwefeldioxidMittel: e.schwefeldioxidMittel,
            schwefeldioxidMax1h: e.schwefeldioxidMax1h
        }
    end 
    converted_data.to_json
end

get '/v1/stations' do
  Sensor.all.map { |e| {sensor_id: e.sensor_id} }.to_json
end

get '/v1/sensordata' do
  convert_to_json SensorData.all
end

get '/v1/sensordata/current' do
  max_date = SensorData.max(:date)
  convert_to_json SensorData.where(date: max_date)
end
