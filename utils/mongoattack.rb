#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-10-31

require File.dirname(__FILE__)+'/mongo'

class MongoAttack
    # attack once
    def attack_once(ip, port, username, password, timeout)
        begin
            ftp = MongoCrack.new(ip, port, username, password, timeout)
            if ftp.hit
                return true
            else
                return false
            end
        rescue
            return false
        end
    end


end