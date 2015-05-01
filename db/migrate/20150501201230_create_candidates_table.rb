class CreateCandidatesTable < ActiveRecord::Migration
  def change
    create_table :candidates_tables do |t|
      t.string :name
    end
  end
end
