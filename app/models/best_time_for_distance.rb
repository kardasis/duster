# Performs a calculation that takes data and a distance and returns
# the fastest time in that data for that distance.  ie. the fastesst mile you ran
# on you 5 mile run.
class BestTimeForDistance
  def initialize(data)
    @data = data
  end

  def calculate(miles:)
    ticks_in_distance = (TICKS_PER_MILE * miles).round
    best = nil

    (0...@data.length - ticks_in_distance).each do |start_index|
      end_index = start_index + ticks_in_distance
      time = @data[end_index] - @data[start_index]
      if best.nil? || best[:time] > time
        best = distance_record_hash(start_index, end_index)
      end
    end

    best
  end

  private

  def distance_record_hash(start_index, end_index)
    end_time = @data[end_index]
    start_time = @data[start_index]
    {
      start_index:,
      start_time:,
      end_index:,
      end_time:,
      time: end_time - start_time
    }
  end
end
