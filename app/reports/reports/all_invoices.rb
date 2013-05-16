module Reports
  # Generate a report of invoices ordered by date
  class AllInvoices
    def generate(csv)
      csv << header_row

      unsorted_rows = []

      Invoice.all.each { |i| unsorted_rows << [i.client.name, i.id, i.date, i.amount] }

      unsorted_rows.sort_by { |row| row[2]}.each do |row|
        csv << row
      end
    end

  private

    def header_row
      ['Company Name', 'Invoice ID', 'Date', 'Amount']
    end
  end
end
