class CreateOrganizacions < ActiveRecord::Migration
  def change
    create_table :organizacions do |t|
      t.string :nombre
      t.string :subdominio
      t.string :direccion
      t.string :descripcion
      t.string :slogan
      t.string :telefono
      t.string :email
      t.string :estatus, default: "A", :limit => 1
      t.references :pais, index: true
      t.references :usuario, index: true
      t.references :tipo_organizacion, index: true

    end
  end
end
