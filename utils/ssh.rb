#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-8-26

require 'net/ssh'

class SshCrack
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
            Net::SSH.start(@ip, @user, :password=>@password, :port=>@port, :auth_methods => [ 'password' ], :number_of_password_prompts => 0, :timeout => @timeout) do |ssh|
                if ssh
                    return true
                else
                    return false
                end
                ssh.close
            end
        rescue
            return false
        end
    end
end
