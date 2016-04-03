class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :titulo
      t.text :descripcion
      t.datetime :inicio
      t.datetime :fin
      t.references :usuario, index: true

      t.timestamps null: false
    end
  end
end
