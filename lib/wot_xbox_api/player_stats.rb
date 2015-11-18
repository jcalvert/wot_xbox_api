require 'pry'
module WotXboxApi
  class PlayerStats

    attr_accessor :wot_vehicle_ids, :battle_counts, :win_percentages, :badge_numbers,
                 :player_id, :player_tank_stats, :name
    
    def initialize(player_id, document)
      self.player_id = player_id
      load_name(document)
      load_wot_vehicle_ids(document)
      load_vehicle_battle_counts(document)
      load_vehicle_win_percentages(document)
      load_vehicle_badge_numbers(document)
      add_unknown_vehicles(document) #not necessary where the mapping is known & persisted
      load_player_tank_stats(document)
    end

    def load_name(document)
      self.name = document.xpath("//span[@class='heading-main_inner-center']").first.children.last.text.strip
    end

    #TODO loading code is very copy pasta, needs to be DRY'd out
    def load_wot_vehicle_ids(document)
      self.wot_vehicle_ids = document.xpath('//tr/@data-vehicle-cd').collect do |attribute| 
        attribute.value
      end
    end

    def load_vehicle_battle_counts(document)
      self.battle_counts = document.xpath('//td/@data-battle-count').collect do |attribute|
        attribute.value
      end
    end

    def load_vehicle_win_percentages(document)
      self.win_percentages = document.xpath('//td/@data-win-percent').collect do |attribute|
        attribute.value
      end
    end
    
    def load_vehicle_badge_numbers(document)
      self.badge_numbers = document.xpath('//td/@data-badge-number').collect do |attribute|
        attribute.value
      end
    end

    def load_player_tank_stats(document)
      self.player_tank_stats = wot_vehicle_ids.each_with_index.collect do |wot_vehicle_id, i|
        Thread.future WotXboxApi.pool do
          player_tank_stat = WotXboxApi::Client.player_tank_stats(player_id, wot_vehicle_id)
          #matching on index like this is fragile, but reduces the number 
          #of document searches since we can extract the values with xpath
          player_tank_stat.battle_count = self.battle_counts[i]
          player_tank_stat.win_percentage = self.win_percentages[i]
          player_tank_stat.badge_number = self.badge_numbers[i]
          player_tank_stat
        end
      end.map(&:value)
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