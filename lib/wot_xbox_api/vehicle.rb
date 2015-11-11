module WotXboxApi
  class Vehicle

    MAPPING = {}

    def self.known?(wot_vehicle_id)
      !MAPPING[wot_vehicle_id].nil?
    end

    def self.add_vehicle(wot_vehicle_id, hash)
      MAPPING[wot_vehicle_id] = hash
    end

    def self.get(wot_vehicle_id)
      MAPPING[wot_vehicle_id]
    end
    
  end
end