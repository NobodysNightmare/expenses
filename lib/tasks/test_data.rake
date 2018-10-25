# frozen_string_literal: true

class TestDataSeeder
  class << self
    def create_expense(category)
      Expense.create!(
        description: "Some expense #{category&.id || '-'}",
        date: rand(0..180).days.ago,
        amount: rand * 100,
        category: category
      )
    end

    def create_periodic_expense(category)
      PeriodicExpense.create!(
        description: "Periodic expense #{category&.id || '-'}",
        amount: rand * 100,
        category: category,
        periodicity: [1, 3, 12].sample
      )
    end
  end
end

namespace :test_data do
  desc 'Seeds some test data into the database (for development purposes)'
  task seed: :environment do
    if Rails.env.production?
      puts 'As a safety measure, this task does not run in production. Sorry!'
      break
    end

    categories = (1..4).map do |i|
      Category.create!(name: "Category #{i}")
    end

    categories << nil

    500.times do
      TestDataSeeder.create_expense(categories.sample)
    end

    10.times do
      TestDataSeeder.create_periodic_expense(categories.sample)
    end
  end

  desc 'Clears all expense data (for development purposes)'
  task clear: :environment do
    if Rails.env.production?
      puts 'As a safety measure, this task does not run in production. Sorry!'
      break
    end

    Category.delete_all
    Expense.delete_all
    PeriodicExpense.delete_all
  end
end
