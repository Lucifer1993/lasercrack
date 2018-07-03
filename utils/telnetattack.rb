#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-11-2

require File.dirname(__FILE__)+'/telnet'

class TelnetAttack
    # attack once
    def attack_once(ip, port, username, password, timeout)
        begin
            telnet = TelnetCrack.new(ip, port, username, password, timeout)
            if telnet.hit
                return true
            else
                return false
            end
        rescue
            return false
        end
    end


end