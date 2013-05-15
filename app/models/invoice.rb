class Invoice < ActiveRecord::Base
  attr_protected :client_id

  belongs_to :client

  monetize :amount_cents

  validates_presence_of :amount_cents
  validates_presence_of :client_id
  validates_presence_of :date

  def paid?
    paid
  end
end
