class CreatePublicacionSocials < ActiveRecord::Migration
  def change
    create_table :publicacion_socials do |t|
      t.string :id_social
      t.references :interaccion_social, index: true

      t.timestamps null: false
    end
  end
end
