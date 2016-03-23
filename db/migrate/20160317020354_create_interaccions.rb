class CreateInteraccions < ActiveRecord::Migration
  def change
    create_table :interaccions do |t|
      t.string :contenido
      t.integer :tipo_interaccion

      t.references :usuario, index: true
      t.references :producto, index: true

      t.timestamps null: false
    end
  end
end
