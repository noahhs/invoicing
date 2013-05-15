class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :client_id
      t.money :amount
      t.date :date
      t.boolean :paid

      t.timestamps
    end
  end
end
