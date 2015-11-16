class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :nombre
      t.string :descripcion
      t.float  :costo
      t.binary :imagen,  :limit => 4294967295.bytes
      t.string :formato_imagen
      t.string :estatus, default: "A", :limit => 1
      t.references :frecuencia_pago, index: true
    end
  end
end
