class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.string :candidate
      t.decimal :value
      t.string :date
      t.timestamps null: false
    end
  end
end
