class CreatePais < ActiveRecord::Migration
  def change
    create_table :pais do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
