module WotXboxApi
  class PlayerTankStats

    attr_accessor :vehicle, :achievements, :statistics, :battle_count,
                  :win_percentage, :badge_number
    
    def initialize(wot_vehicle_id, document)
      self.vehicle = Vehicle.get(wot_vehicle_id)
      load_achievements(document)
      load_statistics(document)
    end

    def load_achievements(document)
      self.achievements = {}
      document.xpath("//div[@class='achievement ']").each do |el|
        achievements[el.xpath("img").first["alt"]]= el['data-count']
      end
    end

    def load_statistics(document)
      self.statistics = {}
      document.xpath("//span[@data-vehicle-brief-key]").each do |el|
        statistics[el['data-vehicle-brief-key']]=el.text
      end
    end

  end
end