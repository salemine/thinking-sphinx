require 'riddle/configuration/section'

require 'riddle/configuration/distributed_index'
require 'riddle/configuration/index'
require 'riddle/configuration/indexer'
require 'riddle/configuration/realtime_index'
require 'riddle/configuration/remote_index'
require 'riddle/configuration/searchd'
require 'riddle/configuration/source'
require 'riddle/configuration/sql_source'
require 'riddle/configuration/xml_source'

require 'riddle/configuration/parser'

module Riddle
  class Configuration
    class ConfigurationError < StandardError #:nodoc:
    end

    attr_reader :indices, :searchd
    attr_accessor :indexer

    def self.parse!(input)
      Riddle::Configuration::Parser.new(input).parse!
    end

    def initialize
      @indexer = Riddle::Configuration::Indexer.new
      @searchd = Riddle::Configuration::Searchd.new
      @indices = []
    end

    def render
      (
        [@indexer.render, @searchd.render] +
        @indices.collect { |index| index.render }
      ).join("\n")
    end
  end
end
