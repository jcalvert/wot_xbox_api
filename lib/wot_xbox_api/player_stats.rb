module WotXboxApi
  class PlayerStats

    attr_accessor :wot_vehicle_ids    
    
    def initialize(document)
      get_wot_vehicle_ids(document)
      add_unknown_vehicles(document) #not necessary where the mapping is known & persisted
    end

    def get_wot_vehicle_ids(document)
      self.wot_vehicle_ids = document.xpath('//tr/@data-vehicle-cd').collect do |attribute| 
        attribute.value
      end
    end

    def add_unknown_vehicles(document)
      wot_vehicle_ids.each_with_index do |wot_vehicle_id, i|
        unless Vehicle.known?(wot_vehicle_id) #once hot this is trivial
          vehicle_element = document.xpath("(//tr[@data-vehicle-cd]/td[2])[#{i+1}]").first
          tier = vehicle_element.xpath('@data-veh-level').first.value
          #janky
          linky=vehicle_element.xpath('a/@href').first.value
          country = linky.match(/vehicles\/(.*?)\//)[1]
          name = vehicle_element.text.strip
          #superjanky
          type = vehicle_element.xpath("../..").xpath("preceding-sibling::*[1]").first.text.gsub(/[^a-zA-Z]/,'')
          vehicle_hash = {
            :tier => tier,
            :country => country,
            :name => name,
            :type => type
          }
          Vehicle.add_vehicle(wot_vehicle_id, vehicle_hash)
        end
      end
    end
  end
end