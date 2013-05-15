require 'spec_helper'

describe Reports::Deadbeats do
  let!(:aardvark)  { FactoryGirl.create(:client, :name => "Aardvark Inc.") }
  let!(:beethoven) { FactoryGirl.create(:client, :name => "Beethoven Inc.") }
  let!(:coolio)    { FactoryGirl.create(:client, :name => "Coolio") }
  let!(:donkey)    { FactoryGirl.create(:client, :name => "Donkey Kong") }

  describe "#generate" do
    def generate_unpaid(client, date, amount)
      FactoryGirl.create(:invoice,
                         :client => client,
                         :date   => date,
                         :amount => amount)
    end

    def generate_paid(client, date, amount)
      FactoryGirl.create(:paid_invoice,
                         :client => client,
                         :date   => date,
                         :amount => amount)
    end

    let(:csv) { [] }

    before(:each) do
      generate_unpaid(beethoven, 1.month.ago, Money.new(150_00))
      generate_unpaid(beethoven, 1.year.ago,  Money.new(50_00))
      generate_paid(beethoven,   1.day.ago,   Money.new(20_00))

      generate_unpaid(aardvark, 1.month.ago,  Money.new(75_00))
      generate_unpaid(aardvark, 2.months.ago, Money.new(25_00))
      generate_paid(aardvark,   1.day.ago,    Money.new(20_00))

      generate_paid(coolio, 1.month.ago, Money.new(40_00))

      generate_unpaid(donkey, 1.month.ago, Money.new(5_00))
    end

    it "generates the correct header row" do
      subject.generate(csv)

      csv.first.should == ['Company Name', 'Amount Owed']
    end

    it "generates a report of debts for each client, excluding debt-free clients" do
      subject.generate(csv)

      report = csv.drop(1)

      report.should == [
        ["Beethoven Inc.", Money.new(200_00)],
        ["Aardvark Inc.",  Money.new(100_00)],
        ["Donkey Kong",    Money.new(5_00)]
      ]
    end
  end
end
