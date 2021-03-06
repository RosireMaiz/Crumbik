class CreatePublicidads < ActiveRecord::Migration
  def change
    create_table :publicidads do |t|
      t.date :fecha_inicio
      t.date :fecha_finalizacion
      t.string :estatus, default: "A", :limit => 1
      t.binary :imagen, :limit => 4294967295.bytes
      t.string :formato_imagen
      
      t.timestamps null: false
    end
  end
end
