class CreatePublicidads < ActiveRecord::Migration
  def change
    create_table :publicidads do |t|
      t.text :descripcion
      t.date :fecha_inicio
      t.date :fecha_vencimiento
      t.string :estatus, default: "A", :limit => 1
      t.binary :imagen, :limit => 4294967295.bytes
      t.string :formato_imagen
      t.references :producto, index: true
    end
  end
end
