class CreateDispositivos < ActiveRecord::Migration
  def change
    create_table :dispositivos do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
