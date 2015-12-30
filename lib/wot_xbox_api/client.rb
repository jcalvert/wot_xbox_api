module WotXboxApi
  class Client
    include HTTParty
    base_uri 'console.worldoftanks.com'

    def initialize()

    end

    #TODO: generalize later
    # def call(url_string, options)
    #   self.class.get(url_string, options).body
    # end

    def self.leaderboard(options={:query => {page: 1}})
      WotXboxApi::Leaderboard.new(JSON.parse(get("/leaderboard/get_ratings", options).body))
    end

    def self.player_stats(player_id)
      WotXboxApi::PlayerStats.new(player_id, Nokogiri::HTML(get("/stats/players/#{player_id}").body))
    end

    def self.player_tank_stats(player_id, wot_vehicle_id)
      WotXboxApi::PlayerTankStats.new(wot_vehicle_id, Nokogiri::HTML(
        get("/stats/players/#{player_id}/vehicle_details.html?vehicle_cd=#{wot_vehicle_id}").body
        ))
    end

    def self.clan_stats(clan_tag, retrieve_members=false)
      WotXboxApi::Clan.new(clan_tag, retrieve_members, Nokogiri::HTML(
        get("/en/clans/xbox/#{clan_tag}").body
        ))
    end    

    def player_search
      #todo
    end

  end
end