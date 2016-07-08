require 'rails_helper'

RSpec.describe BusinessAdmin, type: :model do
  it { should belong_to(:business) }
  it { should belong_to(:user) }
end
