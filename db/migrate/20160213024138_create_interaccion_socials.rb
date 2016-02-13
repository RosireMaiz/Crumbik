class CreateInteraccionSocials < ActiveRecord::Migration
  def change
    create_table :interaccion_socials do |t|
      t.string :titulo
      t.string :descripcion
      t.string :url
	    t.binary :media, :limit => 4294967295.bytes
      t.string :formato_media
      t.string :type_media
      t.references :organizacion_red_social, index: true
      t.references :publicidad, index: true
      t.timestamps null: false
    end
  end
end
