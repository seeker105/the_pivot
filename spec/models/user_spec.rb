require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:orders) }

  it { should respond_to(:orders) }
  it { should respond_to(:username) }
  it { should respond_to(:password) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }

  it { should validate_uniqueness_of(:username) }

  it { should validate_confirmation_of(:password).with_message("does not match") }
end
