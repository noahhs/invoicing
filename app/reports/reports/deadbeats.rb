module Reports
  # Generate a report of debts for each client, ordered by amount owed in
  # descending order. Exclude clients that don't owe us anything.
  #
  # i.e.:
  #
  class Deadbeats
    def generate(csv)
      csv << header_row
      # ...
      records = Invoice.find_by_sql(%{
        SELECT invoices.amount_cents, clients.name
        FROM invoices JOIN clients on clients.id = invoices.client_id
        WHERE invoices.paid = 'f'
        })

      records.map! { |record| attributes = record.attributes }
      
      records.group_by { |rec| rec["name"] }.inject([]) do |result, (_, group)|
        sum = group.inject(0) { |result, record| result + record["amount_cents"] }
        result << [group.first["name"], Money.new(sum)]
      end.sort_by { |row| -row[1]}.each { |row| csv << row}
    end

  private

    def header_row
      ['Company Name', 'Amount Owed']
    end
  end
end
