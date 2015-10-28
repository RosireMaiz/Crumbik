class CreateUsuarioRedSocials < ActiveRecord::Migration
  def change
    create_table :usuario_red_socials do |t|
      t.string :url
      t.references :red_social, index: true
      t.references :usuario, index: true
    end
  end
end
