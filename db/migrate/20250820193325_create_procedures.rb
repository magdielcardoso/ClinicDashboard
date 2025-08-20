class CreateProcedures < ActiveRecord::Migration[8.0]
  def change
    create_table :procedures do |t|
      t.string :name
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end
