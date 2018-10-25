# frozen_string_literal: true

class PeriodicExpense < ApplicationRecord
  belongs_to :category

  enum periodicity: {
    monthly: 1,
    quarterly: 3,
    yearly: 12
  }

  validates :amount, presence: true
  validates :description, presence: true
  validates :periodicity, presence: true
end
