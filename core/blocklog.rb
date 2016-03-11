require './core/load_sentence.rb'

# model class to keep a request data. it keeps path requested, date,
# controller method, load sentences , num of cached loads and total,
# activerecord and renderview time
class Blocklog
  attr_accessor :loadsentences, :path, :date, :cachenum, :timetotal, :timeRender
  attr_accessor :timeRecord
  @loadsentences = []
  def initialize(path, date)
    @path = path
    @date = date
  end

  def add_load_sentence(elem, time)
    @loadsentences << LoadSentence.new(elem, time)
  end
end
