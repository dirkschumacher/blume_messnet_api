require 'sinatra'
require 'csv'
require_relative './models/sensor.rb'
require_relative './models/sensor_data.rb'

configure do
  Mongoid.load!('./mongoid.yml')
end

NO_DATA_RESPONSE = "No data available."

def prepare_for_export(sensor_data)
    converted_data = sensor_data.asc(:date).map do |e|
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
    converted_data
end

def convert_to_json(sensor_data)
    data = prepare_for_export(sensor_data)
    data = NO_DATA_RESPONSE if data.nil? || data.empty?
    data.to_json
end

def convert_to_csv(sensor_data)
    data = prepare_for_export sensor_data
    return NO_DATA_RESPONSE if data.nil? || data.empty?
    csv_string = CSV.generate do |csv|
        csv << data.first.keys
        data.each do |hash|
            csv << hash.values
        end
    end
    csv_string
end

get '/api/v1/stations' do
  content_type :json
  Sensor.all.map { |e| {sensor_id: e.sensor_id} }.to_json
end

get '/api/v1/sensordata/:year' do
  content_type :json
  convert_to_json SensorData.for_year(params[:year].to_i)
end

get '/api/v1/sensordata/:year/csv' do
  content_type :csv
  convert_to_csv SensorData.for_year(params[:year].to_i)
end

get '/api/v1/recent' do
  content_type :json
  convert_to_json SensorData.recent
end

get '/api/v1/recent/csv' do
  content_type :csv
  convert_to_csv SensorData.recent
end

