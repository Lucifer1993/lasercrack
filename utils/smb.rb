#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-8-26

require 'ruby_smb'

class SmbCrack
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
            sock = Socket.tcp(@ip, @port, :connect_timeout => @timeout)
            dispatcher = RubySMB::Dispatcher::Socket.new(sock)

            client = RubySMB::Client.new(dispatcher, smb1: true, smb2: true, username: @user, password: @password)
            client.negotiate
            if client.authenticate.inspect.include? "STATUS_SUCCESS"
                return true
            else
                return false
            end
            client.close
        rescue
            return false
        end
    end
end