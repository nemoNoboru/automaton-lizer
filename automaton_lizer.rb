#!/usr/bin/ruby

require './core/automaton.rb'

# interface class for Automaton-lizer
class Interface
  def initialize(version)
    puts "Automaton-lizer ver #{version}"
    @automaton = Automaton.new
  end

  def do_read(file)
    if File.exist? file
      log = File.new(file, 'r')
      while (line = log.gets)
        @automaton.parse line
      end
    else
      puts 'file no exists.'
    end
  end

  def help
    puts 'usage automaton-lizer <path to rails log>'
  end
end

i = Interface.new '0.0.1'
if ARGV.size < 1
  i.help
else
  i.do_read ARGV[0]
end
