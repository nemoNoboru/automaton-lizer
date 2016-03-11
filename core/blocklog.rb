require './core/load_sentence.rb'

# model class to keep a request data. it keeps path requested, date,
# controller method, load sentences , num of cached loads and total,
# activerecord and renderview time
class Blocklog
  attr_accessor :loadsentences, :procesor, :path, :cachenum, :timetotal
  attr_accessor :timeRecord, :timeRender

  def initialize(path)
    @loadsentences = []
    @path = path
  end

  def add_load_sentence(elem, time)
    @loadsentences << LoadSentence.new(elem, time)
  end
end
