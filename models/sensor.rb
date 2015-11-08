require 'mongoid'
class Sensor
    include Mongoid::Document
    field :sensor_id, type: String
    validates_uniqueness_of :sensor_id
end
