class CreateInteraccionCampannaPubs < ActiveRecord::Migration
  def change
    create_table :interaccion_campanna_pubs do |t|
      t.string :asunto
      t.string :contenido
      t.string :url
      t.binary :media, :limit => 4294967295.bytes
      t.string :formato_media

      t.references :campanna_detalle, index: true
      t.references :usuario_ejercutivo , index: true

      t.timestamps null: false
    end
  end
end
