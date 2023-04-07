# frozen_string_literal: true

class CreateGroupPayments < ActiveRecord::Migration[7.0]
  def change
    create_table :group_payments do |t|
      t.timestamps
      t.references :group, null: false, foreign_key: { to_table: :groups }
      t.references :payment, null: false, foreign_key: { to_table: :payments }
    end
  end
end
