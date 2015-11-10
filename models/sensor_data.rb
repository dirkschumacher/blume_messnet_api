require 'mongoid'
require_relative 'sensor.rb'
class SensorData
    include Mongoid::Document
    belongs_to :sensor
    field :date, type: Date
    field :partikelPM10Mittel, type: Float
    field :partikelPM10Ueberschreitungen, type: Float
    field :russMittel, type: Float
    field :russMax3h, type: Float
    field :stickstoffdioxidMittel, type: Float
    field :stickstoffdioxidMax1h, type: Float
    field :benzolMittel, type: Float
    field :benzolMax1h, type: Float
    field :kohlenmonoxidMittel, type: Float
    field :kohlenmonoxidMax8hMittel, type: Float
    field :ozonMax1h, type: Float
    field :ozonMax8hMittel, type: Float
    field :schwefeldioxidMittel, type: Float
    field :schwefeldioxidMax1h, type: Float
    index({ date: 1, sensor_id: 1 }, { unique: true })

    def self.for_year year
        where(:date.gte => Date.new(year, 1, 1)).where(:date.lte => Date.new(year, 12, 31))
    end

    def self.recent
        max_date = SensorData.max(:date)
        SensorData.where(date: max_date)
    end

end
