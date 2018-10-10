# frozen_string_literal: true

class Expense < ApplicationRecord
  belongs_to :category

  validates :amount, presence: true
  validates :date, presence: true
  validates :description, presence: true
end
