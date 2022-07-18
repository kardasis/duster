namespace :stress_test do
  desc 'do a quick lap and make sure the server can handle it.'
  task quick_lap: :environment do
    require 'http'
    run_id = JSON.parse(HTTP.post('http://localhost:3000/api/runs').to_s)['id']

    seconds = 0
    buffer = []
    (0...TICKS_PER_MILE).each do |i|
      tickstamp = 50 * i
      buffer.push(tickstamp)
      if tickstamp > 1000 * seconds
        body = buffer.map(&:to_s).join(',')
        HTTP.post("http://localhost:3000/api/run/#{run_id}/datapoints", form: { data: body })
        buffer = []
        seconds += 1
      end
      sleep 1
    end

    HTTP.post("http://localhost:3000/api/runs/#{run_id}/run_summaries")
  end
end
