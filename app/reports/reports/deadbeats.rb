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
    end

  private

    def header_row
      ['Company Name', 'Amount Owed']
    end
  end
end
