#!/usr/bin/ruby

require './core/automaton.rb'
require './core/digester.rb'
require './core/agent.rb'

# interface class for Automaton-lizer
class Interface
  attr_reader :automaton
  def initialize(version)
    puts "Automaton-lizer ver #{version}"
    @automaton = Automaton.new
  end

  def do_read(file)
    puts 'Parsing log...'
    if File.exist? file
      log = File.new(file, 'r')
      while (line = log.gets)
        @automaton.parse line
      end
      puts "Made #{@automaton.results.size} blocklogs"
      puts 'Digesting blocklogs...'
      @digester = Digester.new @automaton.results
      results = @digester.process
      puts "Made #{results.size} Results"
      @agent = Agent.new results
    else
      puts 'file no exists.'
    end
  end

  def help
    puts 'usage automaton-lizer <path to rails log>'
  end
end

i = Interface.new '0.1.2'
if ARGV.size < 1
  i.help
else
  i.do_read ARGV[0]
end
