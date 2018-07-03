#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-8-26

require File.dirname(__FILE__)+'/oracle'

class OracleAttack
    # attack once
    def attack_once(ip, port, username, password, timeout)
        begin
            tns_client = OracleCrack.new(ip, port, username, password, timeout)
            if tns_client.hit
                return true
            else
                return false
            end
        rescue
            return false
        end
    end


end