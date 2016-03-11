# model class. is used to keep the information about the sql loads
# that activerecord performs
class LoadSentence
  attr_accessor :elem, :time
  def initialize(elem, time)
    @elem = elem
    @time = time
  end
end
