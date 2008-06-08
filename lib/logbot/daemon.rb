require 'minibot'

module LogBot
  class Daemon < MiniBot::Daemon
    def message(channel, nick, msg)
      Event.create :name => 'message', :channel => channel, :nick => nick, :content => msg 
    end

    def invited(channel, nick)
      # write channel list
      # join channel  
    end

    def kicked(channel, nick)
      # update channel list
    end

    def action(channel, nick, msg)
      Event.create :name => 'action', :channel => channel, :nick => nick, :content => msg 
    end

    def user_joined(channel, nick)
      Event.create :name => 'user_joined', :channel => channel, :nick => nick
    end

    def user_parted(channel, nick)
      Event.create :name => 'user_parted', :channel => channel, :nick => nick
    end

    def topic_changed(channel, nick, topic)
      Event.create :name => 'topic_changed', :channel => channel, :nick => nick, :content => topic
    end
  end
end
