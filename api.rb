require 'sinatra'
require 'csv'
require_relative './models/sensor.rb'
require_relative './models/sensor_data.rb'

configure do
  Mongoid.load!('./mongoid.yml')
end

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
    prepare_for_export(sensor_data).to_json
end

def convert_to_csv(sensor_data) 
    data = prepare_for_export sensor_data
    csv_string = CSV.generate do |csv|
        csv << data.first.keys
        data.each do |hash|
            csv << hash.values
        end
    end
    csv_string
end

def get_recent
  max_date = SensorData.max(:date)
  SensorData.where(date: max_date)
end

def get_for_year(year)
    SensorData.where(:date.gte => Date.new(year, 1, 1)).where(:date.lte => Date.new(year, 12, 31))
end

get '/api/v1/stations' do
  Sensor.all.map { |e| {sensor_id: e.sensor_id} }.to_json
end

get '/api/v1/sensordata/:year' do
  convert_to_json get_for_year(params[:year].to_i)
end

get '/api/v1/sensordata/:year/csv' do
  convert_to_csv get_for_year(params[:year].to_i)
end

get '/api/v1/recent' do
  convert_to_json get_recent
end

get '/api/v1/recent/csv' do
  convert_to_csv get_recent
end

