class CreateMonedas < ActiveRecord::Migration
  def change
    create_table :monedas do |t|
      t.string :nombre

    end
  end
end
