require 'csv'
CSV($stdout) do |csv|
  report = Reports::Deadbeats.new
  report.generate(csv)
end
