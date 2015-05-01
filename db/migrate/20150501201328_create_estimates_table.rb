class CreateEstimatesTable < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.string :date
      t.string :number
      t.string :description
    end
  end
end
