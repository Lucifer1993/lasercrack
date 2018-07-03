#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-8-26

require 'mysql'

class MysqlCrack
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
            db = Mysql.init
            db.options(Mysql::OPT_READ_TIMEOUT, @timeout)
            db.options(Mysql::OPT_CONNECT_TIMEOUT, @timeout)
            db.real_connect(@ip, @user, @password, 'information_schema', @port)
            if db.stat
                return true
            else
                return false
            end
            db.close
        rescue
            return false
        end
    end

end

