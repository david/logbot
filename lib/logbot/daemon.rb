require 'minibot'
require 'yaml'

module LogBot
  class Daemon < MiniBot::Daemon
    def message(channel, nick, msg)
      Event.create :type => :message, :channel => channel, :nick => nick, :content => msg 
    end

    def invited(channel, nick)
      unless Channel.get(channel)
        join channel
        topic_fields = [:topic_message, :topic_author, :topic_created_on]
        tpic = Hash[ *topic_fields.zip(topic channel).flatten ]

        Channel.create({ :name => channel }.merge(tpic).inject({}) { |h, (k, v)| h[k.to_sym] = v; h })
      end
    end

    def kicked(channel, nick)
      Channel.all(:name => channel).destroy!;
    end

    def action(channel, nick, msg)
      Event.create :type => :action, :channel => channel, :nick => nick, :content => msg 
    end

    def user_joined(channel, nick)
      Event.create :type => :user_joined, :channel => channel, :nick => nick
    end

    def user_parted(channel, nick)
      Event.create :type => :user_parted, :channel => channel, :nick => nick
    end

    def topic_changed(channel, nick, topic)
      Event.create :type => :topic_changed, :channel => channel, :nick => nick, :content => topic
    end

    def ready
      join *Channel.all.map { |c| c.name }
    end

    private

    def initialize(config_file)
      config = read config_file
      logger = MiniBot::Logger.new(config.delete :log_file)
      logger.level = config.delete :log_level
      setup_repository config.delete :db_uri
      super config
    end

    def setup_repository(uri)
      DataMapper.setup(:default, uri)
      repository(:default).adapter.resource_naming_convention = 
        DataMapper::NamingConventions::UnderscoredAndPluralizedWithoutModule
    end

    def read(config_file)
      YAML.load_file(config_file).inject({}) { |h, (k, v)| h[k.to_sym] = v; h }
    end
  end
end
