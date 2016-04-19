# colors
class String
def black;          "\e[30m#{self}\e[0m" end
def red;            "\e[31m#{self}\e[0m" end
def green;          "\e[32m#{self}\e[0m" end
def brown;          "\e[33m#{self}\e[0m" end
def blue;           "\e[34m#{self}\e[0m" end
def magenta;        "\e[35m#{self}\e[0m" end
def cyan;           "\e[36m#{self}\e[0m" end
def gray;           "\e[37m#{self}\e[0m" end

def bg_black;       "\e[40m#{self}\e[0m" end
def bg_red;         "\e[41m#{self}\e[0m" end
def bg_green;       "\e[42m#{self}\e[0m" end
def bg_brown;       "\e[43m#{self}\e[0m" end
def bg_blue;        "\e[44m#{self}\e[0m" end
def bg_magenta;     "\e[45m#{self}\e[0m" end
def bg_cyan;        "\e[46m#{self}\e[0m" end
def bg_gray;        "\e[47m#{self}\e[0m" end

def bold;           "\e[1m#{self}\e[22m" end
def italic;         "\e[3m#{self}\e[23m" end
def underline;      "\e[4m#{self}\e[24m" end
def blink;          "\e[5m#{self}\e[25m" end
def reverse_color;  "\e[7m#{self}\e[27m" end
end

# class agent. A expert digital consultor to advise you on your app health
class Agent
  def initialize(responses)
    responses.each do |response|
      puts "+ Response digested from #{response[:size].to_s.gray.bold} Blocklogs"
      puts "| SQL Loads: #{response[:loads].to_s.gray.bold}"
      puts "| Path: #{response[:path].to_s.gray.bold} Average response time: #{response[:response_time_last].to_s.gray.bold}ms"
      puts "+ Health: #{det_health response} Grade of certanity: #{det_certanity response}"
      puts
    end
  end

  def det_health(response)
    status = 'NO DATA'
    if response[:tendency] < -0.5
      status = 'Optimized'.blue
    elsif response[:tendency] < 0.3
      status = 'Healthy'.green
    elsif response[:tendency] > 0.3
      status = 'Unhealthy'.red
    elsif response[:tendency] > 0.8
      status = 'ALERT!'.cyan
    end
    status
  end

  def det_certanity(response)
    status = 'NO DATA'
    if response[:certanity] < 5
      status = 'Absolute'.blue
    elsif response[:certanity] < 30
      status = 'Good'.green
    elsif response[:certanity] > 30
      status = 'Low'.red
    elsif response[:certanity] > 50
      status = 'ZERO'.cyan
    end
    status
  end
end
