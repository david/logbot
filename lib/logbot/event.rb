module LogBot
  class Event
    include DataMapper::Resource

    property :type, DataMapper::Types::Enum[
      :message, :action, :user_joined, :user_parted, :topic_changed ]
    property :channel, String
    property :nick, String
    property :content, String
    property :created_at, DateTime, :key => true
  end
end
