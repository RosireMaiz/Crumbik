class CreateCriterioDifusions < ActiveRecord::Migration
  def change
    create_table :criterio_difusions do |t|
      t.string :nombre
      t.text :descripcion
      t.string :campo_seleccion
      t.string :tabla
      t.string :campo_comparacion
      t.integer :tipo_cosulta
      t.string :estatus, default: "A", :limit => 1

      t.timestamps null: false
    end
  end
end
