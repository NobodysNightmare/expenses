# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :expenses

  validates :name, presence: true
end
