require 'spec_helper'

describe Reports::AllInvoices do
  describe "#generate" do
    let!(:client)      { FactoryGirl.create(:client, :name => "Foo") }
    let!(:old_invoice)   { FactoryGirl.create(:invoice,
                                              :client => client,
                                              :date   => Date.new(2013, 3, 14),
                                              :amount => Money.new(100)) }
    let!(:older_invoice) { FactoryGirl.create(:invoice,
                                              :client => client,
                                              :date   => Date.new(2013, 2, 14),
                                              :amount => Money.new(200)) }
    let!(:new_invoice) { FactoryGirl.create(:invoice,
                                            :client => client,
                                            :date   => Date.new(2013, 4, 14),
                                            :amount => Money.new(300)) }
    let(:csv) { [] }

    it "generates the correct headers" do
      subject.generate(csv)

      csv.first.should == ['Company Name', 'Invoice ID', 'Date', 'Amount']
    end

    it "lists invoices ordered by date ascending" do
      subject.generate(csv)
      report = csv.drop(1)

      report.should == [
        ["Foo", older_invoice.id, Date.new(2013, 2, 14), Money.new(200)],
        ["Foo", old_invoice.id,   Date.new(2013, 3, 14), Money.new(100)],
        ["Foo", new_invoice.id,   Date.new(2013, 4, 14), Money.new(300)]
      ]
    end
  end
end
