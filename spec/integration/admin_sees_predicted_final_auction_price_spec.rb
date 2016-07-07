require 'rails_helper'

RSpec.feature "admin sees predicted final auction price" do
  scenario "on the item show page" do
    admin = create(:user)
    #finish this setup
    item = create(:item_with_bids)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit item_path(item)

    within("some html") do
      expect(page).to have_content("Predicted Selling Price: #{predictor.selling_price}")
    end

  end
end


#@predictor = PORO that returns the y value
# @predictor.selling_price
