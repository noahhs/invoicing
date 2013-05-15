aardvark  = Client.create! {|c| c.name = "Aardvark Inc." }
beethoven = Client.create! {|c| c.name = "Beethoven Inc." }
coolio    = Client.create! {|c| c.name = "Coolio" }
donkey    = Client.create! {|c| c.name = "Donkey" }

def generate_unpaid(client, date, amount)
  Invoice.create! do |invoice|
    invoice.client = client
    invoice.date   = date
    invoice.paid   = false
    invoice.amount = amount
  end
end

def generate_paid(client, date, amount)
  Invoice.create! do |invoice|
    invoice.client = client
    invoice.date   = date
    invoice.paid   = true
    invoice.amount = amount
  end
end

generate_unpaid(beethoven, 1.month.ago, Money.new(150_00))
generate_unpaid(beethoven, 1.year.ago,  Money.new(50_00))
generate_paid(beethoven,   1.day.ago,   Money.new(20_00))

generate_unpaid(aardvark, 1.month.ago,  Money.new(75_00))
generate_unpaid(aardvark, 2.months.ago, Money.new(25_00))
generate_paid(aardvark,   1.day.ago,    Money.new(20_00))

generate_paid(coolio, 1.month.ago, Money.new(40_00))

generate_unpaid(donkey, 1.month.ago, Money.new(5_00))
