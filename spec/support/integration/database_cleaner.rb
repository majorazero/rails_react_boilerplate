require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.around(:each) do |example|
    if example.metadata[:type] == :feature
      DatabaseCleaner.strategy = :truncation
    end
    DatabaseCleaner.cleaning { example.run }
    DatabaseCleaner.strategy = :transaction
  end
end
