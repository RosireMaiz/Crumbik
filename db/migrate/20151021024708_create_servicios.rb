class CreateServicios < ActiveRecord::Migration
  def change
    create_table :servicios do |t|
      t.string :nombre
      t.string :descripcion
      t.string :estatus, default: "A", :limit => 1
    end
  end
end
