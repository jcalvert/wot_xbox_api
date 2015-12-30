module WotXboxApi
  class Clan

    DATA_ID_XPATH = "//div[@class='clans_list-box']/table/tr/@data-id"

    attr_accessor :clan_tag, :members, :member_ids

    def initialize(clan_tag, retrieve_members, document)
      self.clan_tag = clan_tag
      if retrieve_members
        load_players(document)
      else
        load_player_ids(document)
      end
    end

    def load_player_ids(document)
      self.member_ids = document.xpath(DATA_ID_XPATH).collect do |player_id|
        player_id.value
      end
    end

    def load_players(document)
      self.members = document.xpath(DATA_ID_XPATH).collect do |player_id|
        WotXboxApi::Client.player_stats(player_id.value)
      end
    end
  end
end