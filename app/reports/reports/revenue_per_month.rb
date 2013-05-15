module Reports
  # Generate a report of revenues grouped by company and by month, sorted by
  # month then company name.
  #
  # i.e.:
  # Aardvark Inc.,2/2013,200.0
  # Beethoven Co.,2/2013,50.0
  # Aardvark Inc.,3/2013,300.0
  # Beethoven Co.,3/2013,100.0
  #
  # Hint: revenue is obtained from *paid* invoices. Unpaid invoices do not
  # count towards (nor detract from) revenue.
  class RevenuePerMonth
    def generate(csv)
      csv << header_row
      # ...
    end

  private

    def header_row
      ['Company Name', 'Month', 'Revenue']
    end
  end
end
