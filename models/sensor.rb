require 'mongoid'
class Sensor
    include Mongoid::Document
    has_many :sensor_data, class_name: "SensorData"
    field :sensor_id, type: String
    validates_uniqueness_of :sensor_id

    def self.for_sensor sensor
        Sensor.find_by(sensor_id: sensor)
    end

end
