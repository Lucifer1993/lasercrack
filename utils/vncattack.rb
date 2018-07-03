#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-2-5

require File.dirname(__FILE__)+'/vncattack'

class VncAttack
    # attack once
    def attack_once(ip, port, username, password, timeout)
        begin
            vnc = VncCrack.new(ip, port, username, password, timeout)
            if vnc.hit
                return true
            else
                return false
            end
        rescue
            return false
        end
    end


end