require 'dm-core'

DataMapper.setup(:default, "sqlite3:///")

require File.join(File.dirname(__FILE__), '..', 'lib', 'logbot')
