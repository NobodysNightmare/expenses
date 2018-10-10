# frozen_string_literal: true

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
      time = rand(0..180)
      amount = rand * 100
      category = categories.sample
      Expense.create!(
        description: "Some expense #{category&.id || '-'}",
        date: time.days.ago,
        amount: amount,
        category: category
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
