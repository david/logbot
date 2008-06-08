require File.join(File.dirname(__FILE__), 'spec_helper')

describe LogBot::Daemon do
  it "should log a new message" do
    lb = LogBot::Daemon.new({})

    LogBot::Event.should_receive(:create).with(
      :name => 'message',
      :channel => '#ior3k', 
      :nick => 'ior3k', 
      :content => 'This is my message'
    )

    lb.message('#ior3k', 'ior3k', 'This is my message')
  end

  it "should log a new action" do
    lb = LogBot::Daemon.new({})

    LogBot::Event.should_receive(:create).with(
      :name => 'action',
      :channel => '#ior3k', 
      :nick => 'ior3k', 
      :content => 'did something'
    )

    lb.action('#ior3k', 'ior3k', 'did something')
  end

  it "should log a join" do
    lb = LogBot::Daemon.new({})

    LogBot::Event.should_receive(:create).with(
      :name => 'user_joined',
      :channel => '#ior3k', 
      :nick => 'ior3k' 
    )

    lb.user_joined('#ior3k', 'ior3k')
  end

  it "should log a part" do
    lb = LogBot::Daemon.new({})

    LogBot::Event.should_receive(:create).with(
      :name => 'user_parted',
      :channel => '#ior3k', 
      :nick => 'ior3k' 
    )

    lb.user_parted('#ior3k', 'ior3k')
  end

  it "should log a topic change" do
    lb = LogBot::Daemon.new({})

    LogBot::Event.should_receive(:create).with(
      :name => 'topic_changed',
      :channel => '#ior3k', 
      :nick => 'ior3k', 
      :content => 'new topic!' 
    )

    lb.topic_changed('#ior3k', 'ior3k', 'new topic!')
  end
end
