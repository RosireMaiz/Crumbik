class CreateInteraccionCampannaSocials < ActiveRecord::Migration
  def change
    create_table :interaccion_campanna_socials do |t|
      t.string :social_id

      t.references :organizacion_red_socials
      t.references :interaccion_campanna, index: true

      t.timestamps null: false
    end
  end
end
