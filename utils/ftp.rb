#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-8-26

require 'net/ftp'

class FtpCrack
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
            ftp = Net::FTP.new
            ftp.read_timeout = @timeout
            ftp.open_timeout = @timeout
            ftp.connect(@ip, @port)
            ftp.login(@user, @password)
            result = ftp.lastresp
            ftp.close
            if result == "200"
                return true
            else
                return false
            end
        rescue
            return false
        end
    end

end
