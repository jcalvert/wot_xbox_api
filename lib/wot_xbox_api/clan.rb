module WotXboxApi
  class Clan

    DATA_ID_XPATH = "//div[@class='clans_list-box']/table/tr/@data-id"

    attr_accessor :clan_tag, :members

    def initialize(clan_tag, document)
      self.clan_tag = clan_tag
      load_players(document)
    end

    def load_players(document)
      self.members = document.xpath(DATA_ID_XPATH).collect do |player_id|
        WotXboxApi::Client.player_stats(player_id.value)
      end
    end
  end
end