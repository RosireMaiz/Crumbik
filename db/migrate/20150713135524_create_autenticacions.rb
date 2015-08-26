class CreateAutenticacions < ActiveRecord::Migration
  def change
    create_table :autenticacions do |t|
      t.references :usuario, index: true, foreign_key: true
      t.string :provider
      t.string :uid

    end
  end
end
