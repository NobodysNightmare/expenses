# frozen_string_literal: true

namespace :test_data do
  desc 'Seeds some test data into the database (for development purposes)'
  task seed: :environment do
    if Rails.env.production?
      puts 'As a safety measure, this task does not run in production. Sorry!'
      break
    end

    categories = (1..5).map do |i|
      Category.create!(name: "Category #{i}")
    end

    500.times do
      time = rand(0..180)
      amount = rand * 100
      Expense.create!(
        description: 'Some expense',
        date: time.days.ago,
        amount: amount,
        category: categories.sample
      )
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
  end
end
