class CreateOrganizacions < ActiveRecord::Migration
  def change
    create_table :organizacions do |t|
      t.string :nombre
      t.string :subdominio
      t.string :direccion
      t.string :descripcion
      t.string :slogan
      t.text   :mision
      t.text   :vision
      t.string :telefono
      t.string :email
      t.binary :logo
      t.string :formato_logo
      t.binary :banner
      t.string :formato_banner
      t.string :estatus, default: "A", :limit => 1
      t.references :pais, index: true
      t.references :usuario, index: true
      t.references :tipo_organizacion, index: true

    end
  end
end
