#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

Bundler.require

require_relative 'config.rb'

puts @rooms[0]

threads = []

threads << Thread.new do
  Talker.connect(:room => @rooms[0], :token => @token) do |client|
    client.on_connected do |user|
      puts "#{user['name']} connected"
    end
    client.on_presence do |users|
      puts "Users: "
      users.each {|u| puts u['name']}
    end
    client.on_message do |user, message|
      puts user["name"] + ": " + message
    end
    client.on_private_message do |user, message|
      puts "Got a private message from #{user['name']}"
    end
  end
end

threads.each {|t| t.join}
