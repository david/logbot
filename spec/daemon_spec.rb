require File.join(File.dirname(__FILE__), 'spec_helper')

describe LogBot::Daemon do
  def daemon
    YAML.stub!(:load_file).and_return({ :db_uri => "sqlite3:///" })
    d = LogBot::Daemon.allocate
  end

  it "should log a new message" do
    lb = daemon

    LogBot::Event.should_receive(:create).with(
      :type => :message,
      :channel => '#ior3k', 
      :nick => 'ior3k', 
      :content => 'This is my message'
    )

    lb.message('#ior3k', 'ior3k', 'This is my message')
  end

  it "should log a new action" do
    lb = daemon

    LogBot::Event.should_receive(:create).with(
      :type => :action,
      :channel => '#ior3k', 
      :nick => 'ior3k', 
      :content => 'did something'
    )

    lb.action('#ior3k', 'ior3k', 'did something')
  end

  it "should log a join" do
    lb = daemon

    LogBot::Event.should_receive(:create).with(
      :type => :user_joined,
      :channel => '#ior3k', 
      :nick => 'ior3k' 
    )

    lb.user_joined('#ior3k', 'ior3k')
  end

  it "should log a part" do
    lb = daemon

    LogBot::Event.should_receive(:create).with(
      :type => :user_parted,
      :channel => '#ior3k', 
      :nick => 'ior3k' 
    )

    lb.user_parted('#ior3k', 'ior3k')
  end

  it "should log a topic change" do
    lb = daemon

    LogBot::Event.should_receive(:create).with(
      :type => :topic_changed,
      :channel => '#ior3k', 
      :nick => 'ior3k', 
      :content => 'new topic!' 
    )

    lb.topic_changed('#ior3k', 'ior3k', 'new topic!')
  end

  describe "when invited to a new channel"  do
    it "should check if it's logging the channel already" do
      LogBot::Channel.should_receive(:get).with("#duh").and_return(1)

      lb = daemon
      lb.invited("#duh", "dude")
    end

    it "should not create an entry for a channel that is being logged already" do
      LogBot::Channel.stub!(:get).and_return(1)
      LogBot::Channel.should_not_receive(:create);

      lb = daemon
      lb.invited("#duh", "dude")
    end

    it "should join the channel" do
      LogBot::Channel.stub!(:get).and_return(nil)
      LogBot::Channel.stub!(:create)

      lb = daemon
      lb.should_receive(:join).with("#zeechannel")
      lb.stub!(:topic).and_return([nil, nil, nil])
      lb.invited("#zeechannel", "dude")
    end

    it "should save the channel in the channels list" do
      t = Time.now
      LogBot::Channel.stub!(:get).and_return(nil)
      LogBot::Channel.should_receive(:create).with(
        :name => "#zeechannel", :topic_message => "m", :topic_author => "a", :topic_created_on => t)

      lb = daemon
      lb.stub!(:join)
      lb.stub!(:topic).and_return(["m", "a", t])
      lb.invited("#zeechannel", "dude")
    end
  end

  it "should remove the channel from the channels list when kicked" do
    channel = mock "channel"
    channel.should_receive(:destroy!)
    LogBot::Channel.stub!(:all).and_return(channel)

    lb = daemon
    lb.kicked("#zeechannel", "dude")
  end

  it "should read the config file, returning a symbolized hash"
end
