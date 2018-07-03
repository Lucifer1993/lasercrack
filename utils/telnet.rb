#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-11-2

require 'net/telnet'

class TelnetCrack
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
            telnet = Net::Telnet::new("Host" => @ip,
                             "Port" => @port,
                             "Timeout" => @timeout,
                             "Prompt" => /[$%#>] \z/n)
            flag = false
            telnet.login(@user, @password) { |c|
                if c.inspect.include?"Welcome to Microsoft Telnet Server"
                    flag = true
                else
                    flag = false
                end
                if flag
                    return true
                    telnet.close
                end
            }
        rescue
            return false
        end
    end

end
