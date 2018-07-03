#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-2-1

require 'tiny_tds'

class MssqlCrack
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
            mssql = TinyTds::Client.new host: @ip, port:@port,  username: @user, password: @password, login_timeout: @timeout, timeout: @timeout
            if mssql.active?
                return true
            else
                return false
            end
            mssql.close
        rescue
            return false
        end
    end

end
