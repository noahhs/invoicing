class Client < ActiveRecord::Base
  attr_protected :id
  has_many :invoices

  validates_uniqueness_of :name
end
