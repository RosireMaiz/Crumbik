class CreateTemas < ActiveRecord::Migration
  def change
    create_table :temas do |t|
      t.string :nombre;
      t.string :descripcion
      t.binary :imagen,  :limit => 4294967295.bytes
      t.string :formato_imagen

      t.timestamps null: false
    end
  end
end
