require 'dm-core'
require 'dm-timestamps'

module LogBot
  class Channel
    include DataMapper::Resource
    
    property :name, String, :key => true
    property :topic_message, String
    property :topic_author, String
    property :topic_created_on, Date
    property :created_on, Date
    property :updated_on, Date
  end
end
