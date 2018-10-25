# frozen_string_literal: true

class CreatePeriodicExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :periodic_expenses do |t|
      t.belongs_to :category,    null: true, foreign_key: { on_delete: :nullify }
      t.string     :description, null: false
      t.decimal    :amount,      null: false, precision: 8, scale: 2
      t.integer    :periodicity, null: false

      t.timestamps
    end
  end
end
