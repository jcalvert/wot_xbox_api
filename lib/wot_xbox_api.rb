require 'httparty'
require 'nokogiri'
require 'thread/pool'
require 'thread/future'
require "wot_xbox_api/version"
require "wot_xbox_api/client"
require "wot_xbox_api/call_failed_exception"
require 'wot_xbox_api/clan'
require 'wot_xbox_api/leaderboard'
require 'wot_xbox_api/player_stats'
require 'wot_xbox_api/player_tank_stats'
require 'wot_xbox_api/vehicle'


module WotXboxApi

  def self.pool
    @pool ||= Thread.pool(ENV['WOT_API_POOL_SIZE']||25)
  end
end
