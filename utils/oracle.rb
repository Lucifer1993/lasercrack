#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-2-4

require 'net/tns'
require 'net/tti'

class OracleCrack
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
            tns = Net::TTI::Client.new
            tns.connect( :host => @ip, :port => @port, :sid => "ORCL")
            tns.authenticate(@user, @password)
            if tns
                return true
            else
                return false
            end
        rescue
            return false
        end
    end

end
