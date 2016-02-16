class CreateActividadPublicitariaDetalles < ActiveRecord::Migration
  def change
    create_table :actividad_publicitaria_detalles do |t|
      t.text :contenido
      t.integer :type_actividad, default: 0
      t.references :campanna, index: true

      t.timestamps null: false
    end
  end
end
