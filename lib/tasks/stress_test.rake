namespace :stress_test do
  desc 'do a quick lap and make sure the server can handle it.'
  task quick_lap: :environment do
    require 'http'

    base_url = 'http://localhost/api'
    run_id = JSON.parse(HTTP.post("#{base_url}/runs").to_s)['id']

    seconds = 0
    buffer = []
    (0...(0.25 * TICKS_PER_MILE)).each do |i|
      pp "posting #{i}"
      tickstamp = 50 * i
      buffer.push(tickstamp)
      if tickstamp > 1000 * seconds
        body = buffer.map(&:to_s).join(',')
        HTTP.post("#{base_url}/run/#{run_id}/datapoints", form: { data: body })
        buffer = []
        seconds += 1
        sleep 1
      end
    end

    HTTP.post("#{base_url}/runs/#{run_id}/run_summaries")
  end
end

namespace :stress_test do
  task rapid_fire: :environment do
    require 'http'

    base_url = 'http://localhost/api'
    run_id = JSON.parse(HTTP.post("#{base_url}/runs").to_s)['id']

    seconds = 0
    buffer = []
    (0...(100 * TICKS_PER_MILE)).each do |i|
      tickstamp = 50 * i
      buffer.push(tickstamp)
      if tickstamp > 1000 * seconds
        pp "posting #{i}"
        body = buffer.map(&:to_s).join(',')
        HTTP.post("#{base_url}/run/#{run_id}/datapoints", form: { data: body })
        buffer = []
        seconds += 1
        sleep 0.01
      end
    end

    HTTP.post("#{base_url}/runs/#{run_id}/run_summaries")
  end
end
