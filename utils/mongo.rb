#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-10-31

require 'mongo'

class MongoCrack
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
            Mongo::Logger.logger.level = Logger::FATAL
            mongo = Mongo::Client.new(['%s:%d'%[@ip, @port]], :user => @user, :password => @password, :server_selection_timeout => @timeout)
            result = mongo.list_databases.inspect
            mongo.close
            if result.include? "name" and result.include? "sizeOnDisk"
                return true
            else
                return false
            end
        rescue 
            return false
        end
    end

end
