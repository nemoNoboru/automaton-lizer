# class to process blocklogs
class Digester
  def initialize(blocklogs)
    @blocklogs = blocklogs
    @bsize = @blocklogs.size # cache
  end

  def average_response_time # TODO, generalize
    buff = 0
    @blocklogs.each do |blocklog|
      buff += blocklog.timetotal.to_i
    end
    buff / @bsize
  end

  def average_response_tendency # TODO, generalize
    temp1 = 0
    temp2 = 0
    (0..100).each do |i|
      temp1 += @blocklogs[i].timetotal.to_i
      temp2 += @blocklogs[-i].timetotal.to_i
    end
    temp1 = temp1 / 100
    temp2 = temp2 / 100
    temp2 - temp1
  end
end
