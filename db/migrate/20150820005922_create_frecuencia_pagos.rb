class CreateFrecuenciaPagos < ActiveRecord::Migration
  def change
    create_table :frecuencia_pagos do |t|
      t.string :nombre
      t.integer :meses

    end
  end
end
