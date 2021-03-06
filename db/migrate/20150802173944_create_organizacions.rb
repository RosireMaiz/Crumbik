class CreateOrganizacions < ActiveRecord::Migration
  def change
    create_table :organizacions do |t|
      t.string :nombre
      t.string :subdominio
      t.string :direccion
      t.text :descripcion, :limit => 4294967295
      t.string :slogan
      t.text   :mision
      t.text   :vision
      t.string :telefono
      t.string :email
      t.binary :logo,  :limit => 4294967295.bytes
      t.string :formato_logo
      t.binary :banner,  :limit => 4294967295.bytes
      t.string :formato_banner
      t.text :iframe, :limit => 4294967295
      t.string :titulo_banner
      t.string :subtitulo_banner
      t.string :estatus, default: "A", :limit => 1
      t.references :pais, index: true
      t.references :usuario, index: true
      t.references :tipo_organizacion, index: true

      t.timestamps null: false
    end
  end
end
