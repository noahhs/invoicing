require 'csv'
CSV($stdout) do |csv|
  report = Reports::RevenuePerMonth.new
  report.generate(csv)
end
