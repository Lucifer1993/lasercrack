#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-2-1

require File.dirname(__FILE__)+'/mssql.rb'

class MssqlAttack
    # attack once
    def attack_once(ip, port, username, password, timeout)
        begin
            mssql = MssqlCrack.new(ip, port, username, password, timeout)
            if mssql.hit
                return true
            else
                return false
            end
        rescue
            return false
        end
    end


end