RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:each) do
    DatabaseCleaner.clean_with(:truncation)
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

end
