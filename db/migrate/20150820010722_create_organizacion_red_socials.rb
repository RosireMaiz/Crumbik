class CreateOrganizacionRedSocials < ActiveRecord::Migration
  def change
    create_table :organizacion_red_socials do |t|
      t.string :url
      t.references :red_social, index: true
      t.references :organizacion, index: true
      t.string :uid
      t.string :provider
      t.string :oauth_token
      t.string :oauth_secret
      t.datetime   :oauth_expires_at
    end
  end
end
