class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :nombre
      t.text :descripcion
      t.float :precio
      t.binary :imagen, :limit => 4294967295.bytes
      t.string :formato_imagen
      t.references :categoria, index: true
      t.string :estatus, default: "A", :limit => 1

    end
  end
end
