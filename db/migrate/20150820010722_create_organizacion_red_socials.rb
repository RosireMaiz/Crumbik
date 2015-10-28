class CreateOrganizacionRedSocials < ActiveRecord::Migration
  def change
    create_table :organizacion_red_socials do |t|
      t.string :url
      t.references :red_social, index: true
      t.references :organizacion, index: true
    end
  end
end
