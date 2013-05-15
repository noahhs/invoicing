require 'spec_helper'

describe Reports::RevenuePerMonth do
  let(:aardvark) { FactoryGirl.create(:client, :name => "Aardvark Inc.") }
  let(:beethoven) { FactoryGirl.create(:client, :name => "Beethoven Co.") }
  let(:csv) { [] }

  describe "#generate" do
    def generate_invoice(client, month, amount)
      FactoryGirl.create(:invoice,
                         :paid   => true,
                         :client => client,
                         :date   => Date.new(2013, month, 1),
                         :amount => amount)
    end

    before(:each) do
      generate_invoice(beethoven, 2, Money.new(15_00))
      generate_invoice(beethoven, 2, Money.new(35_00))

      generate_invoice(aardvark, 2, Money.new(150_00))
      generate_invoice(aardvark, 2, Money.new(50_00))

      generate_invoice(beethoven, 3, Money.new(75_00))
      generate_invoice(beethoven, 3, Money.new(25_00))

      generate_invoice(aardvark, 3, Money.new(200_00))
      generate_invoice(aardvark, 3, Money.new(100_00))
    end

    it "generates the correct header row" do
      subject.generate(csv)

      csv.first.should == ['Company Name', 'Month', 'Revenue']
    end

    it "generates a report of revenues grouped by company and month, sorted by month then company name" do
      subject.generate(csv)

      report = csv.drop(1)

      report.should == [
        ['Aardvark Inc.', "2/2013", Money.new(200_00)],
        ['Beethoven Co.', "2/2013", Money.new(50_00)],
        ['Aardvark Inc.', "3/2013", Money.new(300_00)],
        ['Beethoven Co.', "3/2013", Money.new(100_00)]
      ]
    end
  end
end
