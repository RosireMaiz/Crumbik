class CreateModoPagos < ActiveRecord::Migration
  def change
    create_table :modo_pagos do |t|
      t.string :nombre
      t.string :estatus, default: "A", :limit => 1

      t.timestamps null: false

    end
  end
end
