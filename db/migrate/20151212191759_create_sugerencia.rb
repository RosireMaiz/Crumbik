class CreateSugerencia < ActiveRecord::Migration
  def change
    create_table :sugerencia do |t|
      t.string :titulo
      t.string :contenido
      t.references :usuario, index: true

      t.timestamps null: false
    end
  end
end