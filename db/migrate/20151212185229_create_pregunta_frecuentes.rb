class CreatePreguntaFrecuentes < ActiveRecord::Migration
  def change
    create_table :pregunta_frecuentes do |t|
      t.string :pregunta
      t.string :respuesta
      t.references :organizacion
      t.string :estatus, default: "A", :limit => 1

      t.timestamps null: false
    end
  end
end
