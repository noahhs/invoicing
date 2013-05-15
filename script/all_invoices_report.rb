require 'csv'
CSV($stdout) do |csv|
  report = Reports::AllCustomers.new
  report.generate(csv)
end
