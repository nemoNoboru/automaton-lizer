# class to process blocklogs
class Digester
  def initialize(blocklogs)
    @blocklogs = blocklogs
    @bsize = @blocklogs.size # cache
  end

  def classify_blocklogs
    @blocklog_hash = {}
    @blocklogs.each do |blocklog|
      if !@blocklog_hash[blocklog.path]
        @blocklog_hash[blocklog.path] = []
      end
      @blocklog_hash[blocklog.path] << blocklog
    end
    @blocklog_hash.size
  end

  def default_process_and_print
    puts 'Classifying....'
    puts "clasified. found #{classify_blocklogs} diferent paths"
    @blocklog_hash.each_key do |key|
      puts "working with #{@blocklog_hash[key].size} Blocklogs"
      buff = average_response_time @blocklog_hash[key]
      puts "Average response time for /#{key} : #{buff}ms"
      buff = average_response_tendency @blocklog_hash[key]
      puts "Average response time tendency for /#{key} : #{buff}"
      buff = average_response_last @blocklog_hash[key]
      puts "Average response time of last requests /#{key} : #{buff}"
      puts
    end
  end

  def average_response_time(blocklogs)
    buff = 0
    blocklogs.each do |blocklog|
      buff += blocklog.timetotal.to_i
    end
    buff / blocklogs.size
  end

  def average_response_tendency(blocklogs) # TODO implement median in another function 
    numerator = 0.0
    denumerator = 0.0
    counter = 0.0
    media_x = 0.0
    media_y = 0.0
    blocklogs.each do |blocklog|
      media_x += blocklog.timetotal.to_f
      media_y += counter
      counter += 1
    end
    media_x /= blocklogs.size.to_f
    media_y /= blocklogs.size.to_f
    counter = 0.0
    blocklogs.each do |blocklog|
      numerator += (blocklog.timetotal.to_f - media_x) * (counter.to_f - media_y)
      denumerator += ((blocklog.timetotal.to_f - media_x)**2)
      counter += 1
    end
    numerator / denumerator
  end

  def cuadratic_error(blocklogs)
    sum = 0
    blocklogs.each do |b|
      sum += (b.timetotal.to_f- # TODO media

  def average_response_last(blocklogs)
    split = (blocklogs.size / 4) + 1
    buff = 0
    (1..split).each do |i|
      buff += blocklogs[-i].timetotal.to_i
    end
    "#{buff/split}ms"
  end
end
