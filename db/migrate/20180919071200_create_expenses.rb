# frozen_string_literal: true

class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.belongs_to :category,    null: false
      t.date       :date,        null: false, index: true
      t.string     :description, null: false
      t.decimal    :amount,      null: false, precision: 8, scale: 2

      t.timestamps
    end
  end
end
