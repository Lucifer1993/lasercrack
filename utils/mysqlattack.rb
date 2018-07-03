#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-8-26

require File.dirname(__FILE__)+'/mysql'

class MysqlAttack
    # attack once
    def attack_once(ip, port, username, password, timeout)
        begin
            mydb = MysqlCrack.new(ip, port, username, password, timeout)
            if mydb.hit
                return true
            else
                return false
            end
        rescue
            return false
        end
    end


end