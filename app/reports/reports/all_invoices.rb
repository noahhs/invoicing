module Reports
  # Generate a report of invoices ordered by date
  class AllInvoices
    def generate(csv)
      csv << header_row
      # ...
    end

  private

    def header_row
      ['Company Name', 'Invoice ID', 'Date', 'Amount']
    end
  end
end
