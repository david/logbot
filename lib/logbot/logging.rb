require 'minibot/logger'
require 'extlib/hook'

MiniBot::Logger.with_level :debug do |l|
  MiniBot::Events.send :include, Extlib::Hook
  MiniBot::Events.before :dispatch do |msg|
    l.write "<< #{msg}"
  end

  MiniBot::Server.send :include, Extlib::Hook
  MiniBot::Server.before :write do |cmd, *rest|
    l.write ">> #{cmd}"
  end

  LogBot::Daemon.class_eval do
    define_method :handle_exception do |e|
      l.write "!! #{e.class}:#{e.message}\n    #{e.backtrace.join("\n    ")}"
    end
  end
end
