require './core/blocklog.rb'

# automaton class. it parses the log file using a finite state automata
class Automaton
  attr_reader :results
  def initialize
    @start = /Started GET "\/(.+)"/
    @procesor = /Processing by (\S+)/
    @loadsentence = /(\S+) Load \((.+)ms\)/
    @cache = /CACHE/
    @end = /Completed 200 OK in (\S+)ms \(Views: (\S+)ms \| ActiveRecord: (\S+)ms\)/
    @results = []
    @status = 0
    @current_blocklog = nil
    @current_cache = 0
    @line = ''
  end

  def parse(line)
    buff = @start.match line
    if buff then state_one buff[1]; return end
    buff = @procesor.match line
    if buff then state_two buff[1]; return end
    buff = @loadsentence.match line
    if buff then state_three(buff[1], buff[2]); return end
    buff = @cache.match line
    if buff then state_four; return end
    buff = @end.match line
    if buff then state_five(buff[1], buff[2], buff[3]); return end
  end

  def abort
    @current_blocklog = nil
    @status = 0
    # puts "AUTOMATA STATUS ##{state} FAILED. ABORTING BLOCKLOG"
  end

  def state_one(match)
    if @status == 3 || @status == 0
      @current_blocklog = Blocklog.new(match)
      @status = 1
    else
      abort 1
    end
  end

  def state_two(match)
    if @status == 1
      @current_blocklog.procesor = match
      @status = 2
    else
      abort 2
    end
  end

  def state_three(match1, match2)
    if @status == 2
      @current_blocklog.add_load_sentence(match1, match2)
      @status = 2
    else
      abort 3
    end
  end

  def state_four
    if @status == 2
      @current_cache += 1
      @current_blocklog.cachenum = @currentCache
      @status = 2
    else
      abort 4
    end
  end

  def state_five(match1, match2, match3)
    if @status == 2
      @current_blocklog.timetotal = match1
      @current_blocklog.timeRender = match2
      @current_blocklog.timetotal = match3
      @results << @current_blocklog
      @current_blocklog = nil
      @status = 3
    else
      abort 5
    end
  end
end
