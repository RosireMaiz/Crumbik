class CreateCriterioDifusions < ActiveRecord::Migration
  def change
    create_table :criterio_difusions do |t|
      t.string :nombre
      t.text :descripcion
      t.string :tabla
      t.string :campo_comparacion
       t.string :estatus, default: "A", :limit => 1

      t.timestamps null: false
    end
  end
end
