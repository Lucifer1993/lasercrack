#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-8-26

require File.dirname(__FILE__)+'/utils/framework'

lasercrack = FrameWork.new
lasercrack.banner

$prompt = "Laser->>>"
while true do
    begin
        print $prompt
        choice = lasercrack.format(gets.chomp())
        if choice == "show"
            lasercrack.show
        elsif choice.include? "load"
            if choice == "load"
                puts "[*] load usage: "
                puts "\t[-]load (ftp|ssh|etc)".light_red
                puts "\t[-]check the command 'list'".light_red
            elsif choice.split.length != 2
                puts "[-] Warn! The command format does not match!!!".light_red
            else
                modset = ["ftp", "ssh", "telnet", "smb", "mysql", "mssql", "oracle", "redis", "mongo", "vnc"]
                modhash = Hash[
                                "ftp" => "21",
                                "ssh" => "22",
                                "telnet" => "23",
                                "smb" => "445", 
                                "mysql" => "3306",
                                "mssql" => "1433",
                                "oracle" => "1521",
                                "vnc" => "5900",
                                "redis" => "6379",
                                "mongo" => "27017",
                               ]
                opt = choice.split
                if modset.include?(opt[1])
                    lasercrack.setmodule(opt[1])
                    mod = lasercrack.showmodule.red
                    lasercrack.setdefaultport(modhash[lasercrack.showmodule])
                    $prompt = "Laser module("+mod+")->>>"
                else
                    puts "[-] Warn! Must select the module with range of 'list'".light_red
                end
            end
        elsif choice == "exploit"
            if lasercrack.showmodule == "nil"
                puts "[-] Warn! The module not selected!!!".light_red
            else
                if lasercrack.checkarg
                    if lasercrack.checkips
                        lasercrack.exploit_ips
                    else
                        lasercrack.exploit_sniper
                    end
                elsif lasercrack.checkarg_userfile
                    if lasercrack.checkips
                        puts "[-] please input single ip!!!".light_red
                    else
                        lasercrack.exploit_userfile
                    end
                elsif lasercrack.checkarg_passfile
                    if lasercrack.checkips
                        puts "[-] please input single ip!!!".light_red
                    else
                        lasercrack.exploit_passfile
                    end
                else
                     puts "[-] parameter is nil, can not exploit".light_red
                end

            end

        elsif choice.include? "set"
            if choice == "set"
                puts "[*] set usage: "
                puts "\t[-]set (ip|port|username|password|etc) value".light_red
                puts "\t[-]check the command 'show'".light_red
            elsif choice.split.length != 3
                puts "[-] Warn! The command format does not match!!!".light_red
            else
                opt = choice.split
                if opt[1] == "ip"
                    lasercrack.setip(opt[2])
                elsif opt[1] == "port"
                    lasercrack.setport(opt[2])
                elsif opt[1] == "username"
                    lasercrack.setusername(opt[2])
                elsif opt[1] == "password"
                    lasercrack.setpassword(opt[2])
                elsif opt[1] == "user_file"
                    lasercrack.setuser_file(opt[2])
                elsif opt[1] == "pass_file"
                    lasercrack.setpass_file(opt[2])
                elsif opt[1] == "verbose"
                    lasercrack.setverbose(opt[2])
                elsif opt[1] == "threads"
                    lasercrack.setthreads(opt[2])
                elsif opt[1] == "timeout"
                    lasercrack.settimeout(opt[2])
                else
                    puts "[*] set usage: "
                    puts "\t[-]set (ip|port|username|password|etc) value".light_red
                    puts "\t[-]check the command 'show'".light_red
                end
            end
        end
    rescue Interrupt
        puts
    end
end