class CreateInstallments < ActiveRecord::Migration[5.2]
  def change
    create_table :installments do |t|
      t.references :loan, foreign_key: true
      t.integer :amount
      t.timestamp :due_date
      t.string :status

      t.timestamps
    end
  end
end
