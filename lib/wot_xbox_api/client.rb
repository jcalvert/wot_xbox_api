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

    def leaderboard(options={page: 1})
      WotXboxApi::Leaderboard.new(JSON.parse(self.class.get("/leaderboard/get_ratings", options).body))
    end

    def player_stats(player_id)
      self.class.get("/stats/players/#{player_id}").body
    end

    def player_search
      #todo
    end

  end
end