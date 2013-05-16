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

      records = Invoice.find_by_sql(%{
        SELECT invoices.date, invoices.amount_cents, clients.name
        FROM invoices JOIN clients on clients.id = invoices.client_id
        WHERE invoices.paid = 't'
        })

      records.map! do |record|
        attributes = record.attributes
        attributes[:month] = record.date.month
        attributes[:year] = record.date.year
        attributes
      end

      records.group_by { |rec| "#{rec[:year]}_#{rec[:month]}_#{rec["name"]}"
      }.sort.each do |_, group|
        sum = group.inject(0) { |result, record| result + record["amount_cents"] }
        csv << [group.first["name"], "#{group.first[:month]}/#{group.first[:year]}", Money.new(sum)]
      end
    end

  private

    def header_row
      ['Company Name', 'Month', 'Revenue']
    end
  end
end