#!/usr/bin/env ruby
# -*- coding: binary -*-
#Author: Lucifer
#Date: 2017-12-08

require 'colorize'
require 'ipaddr'
require 'netaddr'
require 'thread'
require 'threadpool'
require 'ruby-progressbar'
require File.dirname(__FILE__)+'/ftpattack'
require File.dirname(__FILE__)+'/sshattack'
require File.dirname(__FILE__)+'/mysqlattack'
require File.dirname(__FILE__)+'/smbattack'
require File.dirname(__FILE__)+'/redisattack'
require File.dirname(__FILE__)+'/mongoattack'
require File.dirname(__FILE__)+'/telnetattack'
require File.dirname(__FILE__)+'/mssqlattack'
require File.dirname(__FILE__)+'/oracleattack'
require File.dirname(__FILE__)+'/vncattack'

class FrameWork
    # banner
    def banner
      figlet=
      %q{
         __                           ___                   _    
        / /   __ _  ___   ___  _ __  / __\_ __  __ _   ___ | | __
       / /   / _` |/ __| / _ \| '__|/ /  | '__|/ _` | / __|| |/ /
      / /___| (_| |\__ \|  __/| |  / /___| |  | (_| || (__ |   < 
      \____/ \__,_||___/ \___||_|  \____/|_|   \__,_| \___||_|\_\

                                                 Code by Lucifer.
 ____________________________________
( The Brute Force Framework For Ruby )
 ------------------------------------
      o                    / \  //\
       o    |\___/|      /   \//  \\
            /0  0  \__  /    //  | \ \
           /     /  \/_/    //   |  \  \
           @_^_@'/   \/_   //    |   \   \
           //_^_/     \/_ //     |    \    \
        ( //) |        \///      |     \     \
      ( / /) _|_ /   )  //       |      \     _\
    ( // /) '/,_ _ _/  ( ; -.    |    _ _\.-~        .-~~~^-.
  (( / / )) ,-{        _      `-.|.-~-.           .~         `.
 (( // / ))  '/\      /                 ~-. _ .-~      .-~^-.  \
 (( /// ))      `.   {            }                   /      \  \
  (( / ))     .----~-.\        \-'                 .~         \  `. \^-.
             ///.----..>        \             _ -~             `.  ^-`  ^-_
               ///-._ _ _ _ _ _ _}^ - - - - ~                     ~-- ,.-~
                                                                  /.-~
        }
      puts figlet.light_blue
    end

    # help func
    def help
      puts "[*] Reference command: ".light_yellow
      puts "\t[*] show            Display the framework information".light_yellow
      puts "\t[*] list            List avaliable modules".light_yellow
      puts "\t[*] clear           Clear the terminal".light_yellow
      puts "\t[*] set             Set parameters".light_yellow
      puts "\t[*] load            Load the module".light_yellow
      puts "\t[*] exploit         Exploit the module".light_yellow
      puts "\t[*] exit/quit       Exit the prog".light_yellow
    end

    # initialize func
    def initialize
      @module = "nil"
      @ip = "nil"
      @port = 0
      @username = "nil"
      @password = "nil"
      @user_file = "nil"
      @pass_file = "nil"
      @verbose = false
      @threads = 10
      @timeout = 10
      @exploithash = {
          "ftp" => FtpAttack.new,
          "ssh" => SshAttack.new,
          "mysql" => MysqlAttack.new,
          "mssql" => MssqlAttack.new,
          "smb" => SmbAttack.new,
          "redis" => RedisAttack.new,
          "mongo" => MongoAttack.new,
          "telnet" => TelnetAttack.new,
          "oracle" => OracleAttack.new,
          "vnc" => VncAttack.new,
      }
    end

    # getnow func
    def getnow
      now = Time.new
      return now.strftime("%Y-%m-%d %H:%M:%S")
    end

    #check func
    def checkarg
      flag = true
      if @user_file == "nil" and @pass_file == "nil"
        puts "[*] Exploit by ip/ips..".light_blue
        tmphash = {"ip" => @ip, "port" => @port, "username" => @username, "password" => @password}
        tmphash.each {|key, value|
          if value == "nil" or value == 0
            tmpstr = "[-] "+key+" => "+value.to_s+"    ".light_red
            puts tmpstr.light_red
            flag = false
          end
        }
      else
        return false
      end
      return flag
    end

    def checkarg_userfile
      flag = true
        if @username == "nil" and @pass_file == "nil"
          puts "[*] Exploit by username dic..".light_blue
          tmphash = {"ip" => @ip, "port" => @port, "user_file" => @user_file, "password" => @password}
          tmphash.each {|key, value|
            if value == "nil" or value == 0
              tmpstr = "[-] "+key+" => "+value.to_s+"    ".light_red
              puts tmpstr.light_red
              flag = false
            end
          }
        else
          return false
        end
        return flag
    end

    def checkarg_passfile
      flag = true
        if @password == "nil" and @user_file == "nil"
          puts "[*] Exploit by password dic..".light_blue
          tmphash = {"ip" => @ip, "port" => @port, "pass_file" => @pass_file, "username" => @username}
          tmphash.each {|key, value|
            if value == "nil" or value == 0
              tmpstr = "[-] "+key+" => "+value.to_s+"    ".light_red
              puts tmpstr.light_red
              flag = false
            end
          }
        else
          return false
        end
        return flag
    end

    def checkips
      reg = /^\d+.\d+.\d+.\d+$/
      res = reg.match(@ip)
      if res.nil?
        return true
      else
        return false
      end
    end

    def checkcidr_iprange
      reg = /^\d+.\d+.\d+.\d+\/\d+$/
      res = reg.match(@ip)
      if not res.nil?
        return cidr2iplist(@ip)
      else
        return iprange2iplist(@ip)
      end
    end

    #convert iplist func
    def cidr2iplist(cidr)
      begin
        return NetAddr::CIDR.create(cidr).enumerate
      rescue
        puts "[-] Not illegal CIDR!!!".light_red
      end
    end

    def iprange2iplist(iprange)
      begin
        iplist = iprange.split('-')
        start_ip = IPAddr.new(iplist[0])
        end_ip = IPAddr.new(iplist[1])
        return (start_ip..end_ip).map(&:to_s)
      rescue
        puts "[-] Not illegal IP range!!!".light_red
      end
    end

    #exploit func
    def exploit_sniper_template
      puts "[*] Starting crack the #{@module}..".light_blue
      puts "[*] target ip: "+@ip.light_blue
      puts "[*] target port: "+@port.light_blue

      @exploithash.each { |key, value|
        if key == @module
          exploitsniper = value
          if exploitsniper.attack_once(@ip, @port.to_i, @username, @password, @timeout)
            result = "[+] Crack it!"+" "*6+@username+":"+@password
            puts result.light_green
          end
        end
      }
    end

    def exploit_sniper
      exploit_sniper_template
    end

    def exploit_ips_template
      $semaphore = Mutex.new
      $COUNTER = 0
      $OFFSET = 0

      puts "[*] Starting crack the #{@module}..".light_blue
      puts "[*] target ip: "+@ip.light_blue
      puts "[*] target port: "+@port.light_blue
      @exploithash.each { |key, value|
        if key == @module
          iplist = checkcidr_iprange
          if not iplist.nil?
            pool = ThreadPool.new(@threads)
            exploitips = value
            iplist.each { |item|
              pool.process {
                  if exploitips.attack_once(item, @port.to_i, @username, @password, @timeout)
                    result = "[+] Crack it!"+" "*6+item+" "*6+@username+":"+@password
                    $OFFSET += 1
                    $semaphore.lock
                    puts result.light_green
                    $semaphore.unlock
                  else
                    if @verbose
                      $semaphore.lock
                      puts "["+getnow+"]".light_white+" "*6+"Not found! ==> "+item.light_red
                      $semaphore.unlock
                    else
                      $semaphore.lock
                      progressbar = ProgressBar.create(:format => 'Processing: |%b>>%i| %p%% %t', :starting_at => $COUNTER, :total => iplist.length-$OFFSET-1)
                      $semaphore.unlock
                      $COUNTER += 1
                      sleep 0.05
                      if progressbar.finished?
                        puts "finished".light_blue
                      end
                    end
                  end
              }
            }
            gets
          end
        end
      }
    end

    def exploit_ips
      exploit_ips_template
    end

    def exploit_userfile_template
      $semaphore = Mutex.new
      $COUNTER = 0
      $OFFSET = 0

      puts "[*] Starting crack the #{@module}..".light_blue
      puts "[*] target ip: "+@ip.light_blue
      puts "[*] target port: "+@port.light_blue
      @exploithash.each { |key, value|
        if key == @module
          userfile = Array.new
          begin
            File.open(@user_file) do |file|
              file.each_line{|line| userfile.push(line.strip)}
              file.close()
            end
            if checkips
              puts "[-] please input single ip!!!".light_red
            else
              pool = ThreadPool.new(@threads)
                exploituserfiles = value
                userfile.each { |item|
                    pool.process {
                        if exploituserfiles.attack_once(@ip, @port.to_i, item, @password, @timeout)
                          result = "[+] Crack it!"+" "*6+@ip+" "*6+item+":"+@password
                          $OFFSET += 1
                          $semaphore.lock
                          puts result.light_green
                          $semaphore.unlock
                        else
                          if @verbose
                            $semaphore.lock
                            puts "["+getnow+"]".light_white+" "*6+"Not found! ==> "+item.light_red+":"+@password.light_red
                            $semaphore.unlock
                          else
                            $semaphore.lock
                            progressbar = ProgressBar.create(:format => 'Processing: |%b>>%i| %p%% %t', :starting_at => $COUNTER, :total => userfile.length-$OFFSET-1)
                            $semaphore.unlock
                            $COUNTER += 1
                            sleep 0.05
                            if progressbar.finished?
                              puts "finished".light_blue
                            end
                          end
                        end
                      }
                  }
                gets
              end
            rescue
              puts "[-] File import faild!!!".light_red
            end
          end
      }
    end

    def exploit_userfile
      exploit_userfile_template
    end

    def exploit_passfile_template
      $semaphore = Mutex.new
      $COUNTER = 0
      $OFFSET = 0

      puts "[*] Starting crack the #{@module}..".light_blue
      puts "[*] target ip: "+@ip.light_blue
      puts "[*] target port: "+@port.light_blue
      @exploithash.each { |key, value|
        if key == @module
          passfile = Array.new
          begin
            File.open(@pass_file) do |file|
              file.each_line{|line| passfile.push(line.strip)}
              file.close()
            end
            if checkips
              puts "[-] please input single ip!!!".light_red
            else
              pool = ThreadPool.new(@threads)
                exploitpassfiles = value
                passfile.each { |item|
                    pool.process {
                        if exploitpassfiles.attack_once(@ip, @port.to_i, @username, item, @timeout)
                          result = "[+] Crack it!"+" "*6+@ip+" "*6+@username+":"+item
                          $OFFSET += 1
                          $semaphore.lock
                          puts result.light_green
                          $semaphore.unlock
                        else
                          if @verbose
                            $semaphore.lock
                            puts "["+getnow+"]".light_white+" "*6+"Not found! ==> "+@username.light_red+":"+item.light_red
                            $semaphore.unlock
                          else
                            $semaphore.lock
                            progressbar = ProgressBar.create(:format => 'Processing: |%b>>%i| %p%% %t', :starting_at => $COUNTER, :total => passfile.length-$OFFSET-1)
                            $semaphore.unlock
                            $COUNTER += 1
                            sleep 0.05
                            if progressbar.finished?
                              puts "finished".light_blue
                            end
                          end
                        end
                      }
                  }
                gets
              end
            rescue
              puts "[-] File import faild!!!".light_red
            end
          end
      }
    end

    def exploit_passfile
      exploit_passfile_template
    end

    # show func
    def show
      puts "\tip                    "+@ip
      puts "\tport                  "+@port.to_s
      puts "\tusername              "+@username
      puts "\tpassword              "+@password
      puts "\tuser_file             "+@user_file
      puts "\tpass_file             "+@pass_file
      puts "\tverbose               "+@verbose.to_s
      puts "\tthreads               "+@threads.to_s
      puts "\ttimeout               "+@timeout.to_s
    end

    def showmodule
      return @module
    end

    # set func
    def setmodule(mymodule)
      @module = mymodule
    end

    def setip(ip)
      @ip = ip
      puts "ip => "+@ip
      puts
    end

    def setport(port)
      if port.to_i != 0 and port.to_i.is_a?(Integer)
        @port = port
        puts "port => "+@port.to_s
        puts
      else
        puts "[-] Warn! The Option must be integer".light_red
      end
    end

    def setdefaultport(deport)
      @port = deport
    end

    def setusername(username)
      @username = username
      puts "username => "+@username
      puts
    end

    def setpassword(password)
      @password = password
      puts "password => "+@password
      puts
    end

    def setuser_file(user_file)
      @user_file = user_file
      puts "user_file => "+@user_file
      puts
    end

    def setpass_file(pass_file)
      @pass_file = pass_file
      puts "pass_file => "+@pass_file
      puts
    end

    def setverbose(verbose)
      @verbose = verbose
      if @verbose == "true"
        @verbose = true
      else
        @verbose = false
      end
      puts "verbose => "+@verbose.to_s
      puts
    end

    def setthreads(threads)
      if threads.to_i != 0 and threads.to_i.is_a?(Integer)
        @threads = threads.to_i
        puts "threads => "+@threads.to_s
        puts
      else
        puts "[-] Warn! The Option must be integer".light_red
      puts
      end
    end

    def settimeout(timeout)
      if timeout.to_i != 0 and timeout.to_i.is_a?(Integer)
        @timeout = timeout.to_i
        puts "timeout => "+@timeout.to_s
        puts
      else
        puts "[-] Warn! The Option must be integer".light_red
      puts
      end
    end

    def clear
      system "clear"
    end

    # format func
    def format(strLine)
      @strLine = strLine.strip
      if @strLine.length == 0
        help
        return @strLine
      elsif @strLine == "show"
        puts "\toptions               value"
        puts "\t-------               -----"
        return @strLine

      elsif @strLine == "list"
        puts "\tmodule                desc"
        puts "\t------                ----------------------"
        puts "\tftp                   Crack ftp passwords"
        puts "\tssh                   Crack ssh passwords"
        puts "\ttelnet                Crack telnet passwords"
        puts "\tsmb                   Crack smb passwords"
        puts "\tmysql                 Crack mysql passwords"
        puts "\tmssql                 Crack mssql passwords"
        puts "\toracle                Crack oracle passwords"
        puts "\tredis                 Crack redis passwords"
        puts "\tmongo                 Crack mongo passwords"
        puts "\tvnc                   Crack vnc passwords"
        return @strLine

      elsif @strLine.include? "set"
        return @strLine

      elsif @strLine.include? "load"
        return @strLine

      elsif @strLine == "exploit"
        return @strLine

      elsif @strLine == "clear"
        clear
        return @strLine

      elsif @strLine.include? "exit" or @strLine.include? "quit"
        exit(0)

      else
        help
        return @strLine
      end
    end
end
