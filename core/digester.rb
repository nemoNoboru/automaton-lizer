# class to process blocklogs
class Digester
  def initialize(blocklogs)
    @blocklogs = blocklogs
  end

  def process
    classify_blocklogs
    results_array = []
    @blocklog_hash.each_key do |key|
      temp = {}
      temp[:size] = @blocklog_hash[key].size
      temp[:path] = key
      temp[:response_time] = mean @blocklog_hash[key]
      temp[:response_time_last] = average_response_last @blocklog_hash[key]
      temp[:tendency] = average_response_tendency @blocklog_hash[key]
      temp[:certanity] = (cuadratic_error @blocklog_hash[key]) / temp[:response_time]
      temp[:loads] = mean_load @blocklog_hash[key]
      results_array << temp
    end
    results_array
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

  def mean_load(blocklogs)
    sum = 0
    blocklogs.each do |blocklog|
      sum += blocklog.loadsentences.size
    end
    sum / blocklogs.size
  end

  def mean(blocklogs)
    sum = 0
    blocklogs.each do |b|
      sum += b.timetotal.to_f
    end
    sum / blocklogs.size
  end

  def mean_int(blocklogs)
    sum = 0
    counter = 0
    blocklogs.each do |b|
      sum += b.to_f
      counter += 1
    end
    sum / counter
  end

  def average_response_tendency(blocklogs) # lineal regresion
    numerator = 0.0
    denumerator = 0.0
    counter = 0.0
    media_x = mean blocklogs
    media_y = mean_int(0..blocklogs.size)
    blocklogs.each do |blocklog|
      numerator += (blocklog.timetotal.to_f - media_x) * (counter.to_f - media_y)
      denumerator += ((blocklog.timetotal.to_f - media_x)**2)
      counter += 1
    end
    numerator / denumerator
  end

  def cuadratic_error(blocklogs)
    sum = 0
    average_mean = mean blocklogs
    blocklogs.each do |b|
      sum += ((b.timetotal.to_f - average_mean)**2)
    end
    sum
  end

  def average_response_last(blocklogs)
    split = (blocklogs.size / 4) + 1
    buff = 0
    (1..split).each do |i|
      buff += blocklogs[-i].timetotal.to_i
    end
    buff / split
  end
end
