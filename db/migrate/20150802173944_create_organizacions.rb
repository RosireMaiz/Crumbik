class CreateOrganizacions < ActiveRecord::Migration
  def change
    create_table :organizacions do |t|
      t.string :nombre
      t.string :subdominio
      t.string :direccion
      t.string :descripcion
      t.string :slogan
      t.string :telefono1
      t.string :telefono2
      t.string :email1
      t.string :email2
      t.string :estatus, default: "A", :limit => 1
      t.references :pais, index: true
      t.references :usuario
      
      t.timestamps null: false
    end
  end
end
