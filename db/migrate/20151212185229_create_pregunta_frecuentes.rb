class CreatePreguntaFrecuentes < ActiveRecord::Migration
  def change
    create_table :pregunta_frecuentes do |t|
      t.string :titulo
      t.string :contenido
      t.string :estatus, default: "A", :limit => 1
      t.references :organizacion

      t.timestamps null: false
    end
  end
end
