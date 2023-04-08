# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :name
      t.decimal :amount
      t.timestamps
      t.references :user, null: false, foreign_key: { to_table: :users }
    end
  end
end
