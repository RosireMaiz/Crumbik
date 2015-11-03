class CreateFrecuenciaPagos < ActiveRecord::Migration
  def change
    create_table :frecuencia_pagos do |t|
      t.string :nombre
      t.integer :meses
      t.string :estatus, default: "A", :limit => 1

    end
  end
end
