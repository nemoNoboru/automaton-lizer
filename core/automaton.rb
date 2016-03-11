require './core/blocklog.rb'

# automaton class. it parses the log file
class Automaton
  @results = []
  def initialize
    @status = 0
    @current_blocklog = nil
  end

  def parse(line)
    puts line
  end
end
