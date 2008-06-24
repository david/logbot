require 'rubygems'

gem 'dm-core', '> 0.9.0'

require 'dm-core'
require 'dm-types'
require 'dm-timestamps'

require File.join(File.dirname(__FILE__), 'logbot', 'channel')
require File.join(File.dirname(__FILE__), 'logbot', 'event')
require File.join(File.dirname(__FILE__), 'logbot', 'daemon')
