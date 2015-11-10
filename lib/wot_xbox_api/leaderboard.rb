module WotXboxApi
  class Leaderboard

    attr_accessor :keys, :values, :player_hashes

    KNOWN_KEYS=["account_id", "battles_count", "battles_count_daily", 
      "battles_count_rank", "battles_count_rank_delta", "damage_avg", 
      "damage_dealt", "damage_dealt_rank", "damage_dealt_rank_delta", 
      "frags_avg", "frags_count", "frags_count_rank", "frags_count_rank_delta",
      "global_rating", "global_rating_rank", "global_rating_rank_delta",
      "hits_ratio", "hits_ratio_rank", "hits_ratio_rank_delta", "name", 
      "survived_ratio", "survived_ratio_rank", "survived_ratio_rank_delta",
      "wins_count", "wins_ratio", "wins_ratio_rank", "wins_ratio_rank_delta",
      "xp_amount", "xp_avg", "xp_avg_rank", "xp_avg_rank_delta", "xp_max",
      "xp_max_rank", "xp_max_rank_delta"]

    def initialize(data)
      @keys = data['data_rating']['result']['keys']
      raise StandardError.new("Expected keys do not match returned keys!") if @keys != KNOWN_KEYS
      @player_hashes = data['data_rating']['result']['values'].collect do |value|
        Hash[KNOWN_KEYS.zip(value)]
      end
    end

  end
end