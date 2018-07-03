#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-8-26

require 'redis'

class RedisCrack
    def initialize(ip, port, user, password, timeout)
        @ip = ip
        @port = port
        @user = user
        @password = password
        @timeout = timeout
    end

    def ip
        @ip
    end

    def port
        @port
    end

    def user
        @user
    end

    def password
        @password
    end

    def timeout
        @timeout
    end

    def hit
        begin
            redis = Redis.new(
                :url => "redis://:#{@password}@#{@ip}:#{@port}/0",
                :connect_timeout => @timeout,
            )
            if redis.ping.inspect.include? "PONG"
                return true
            else
                return false
            end
            redis.close
        rescue 
            return false
        end
    end
end
