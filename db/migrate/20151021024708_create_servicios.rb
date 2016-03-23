class CreateServicios < ActiveRecord::Migration
  def change
    create_table :servicios do |t|
      t.string :nombre
      t.string :descripcion
      t.string :icono
      t.string :estatus, default: "A", :limit => 1

      t.timestamps null: false
    end
  end
end
