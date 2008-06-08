require 'dm-core'

module LogBot
  class Event
    include DataMapper::Resource

    property :name, String
    property :channel, String
    property :nick, String
    property :content, String
  end
end
