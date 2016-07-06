require 'rails_helper'

RSpec.feature "platform admin sees a list of businesses" do
  scenario "platform admin logs in and is taken to their dashboard" do
    user = create(:user, platform_admin: true)

    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Log In"
    expect(current_path).to eq("/platform_admin/dashboard")

    within("body") do
      expect(page).to have_content("Platform Admin Dashboard")
    end
  end

  scenario "platform admin sees links to all businesses" do
    user = create(:user, platform_admin: true)
    businesses = []
    businesses << create(:business, active: true)
    businesses << create(:business, active: true)
    businesses << create(:business)
    businesses << create(:business)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit platform_admin_dashboard_path

    within("#"+businesses[0].slug) do
      expect(page).to have_content(businesses[0].name)
      expect(page).to have_link("Deactivate")
    end
    within("#"+businesses[1].slug) do
      expect(page).to have_content(businesses[1].name)
      expect(page).to have_link("Deactivate")
    end
    within("#"+businesses[2].slug) do
      expect(page).to have_content(businesses[2].name)
      expect(page).to have_link("Activate")
    end
    within("#"+businesses[3].slug) do
      expect(page).to have_content(businesses[3].name)
      expect(page).to have_link("Activate")
    end
  end

  scenario "platform admin activates inactive businesses" do
    user = create(:user, platform_admin: true)
    businesses = []
    businesses << create(:business, active: true)
    businesses << create(:business, active: true)
    businesses << create(:business)
    businesses << create(:business)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit platform_admin_dashboard_path
    within("#"+businesses[2].slug) do
      click_link("Activate")
    end
    expect(current_path).to eq(platform_admin_dashboard_path)
# save_and_open_page
# byebug
    within("#"+businesses[2].slug) do
      expect(page).to have_content(businesses[2].name)
      expect(page).to have_link("Deactivate")
    end

    within("#"+businesses[3].slug) do
      click_link("Activate")
    end
    expect(current_path).to eq(platform_admin_dashboard_path)

    within("#"+businesses[3].slug) do
      expect(page).to have_content(businesses[3].name)
      expect(page).to have_link("Deactivate")
    end
  end

  scenario "platform admin deactivates active businesses" do
    user = create(:user, platform_admin: true)
    businesses = []
    businesses << create(:business, active: true)
    businesses << create(:business, active: true)
    businesses << create(:business)
    businesses << create(:business)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit platform_admin_dashboard_path
    within("#"+businesses[0].slug) do
      click_link("Deactivate")
    end
    expect(current_path).to eq(platform_admin_dashboard_path)
# save_and_open_page
# byebug
    within("#"+businesses[0].slug) do
      expect(page).to have_content(businesses[0].name)
      expect(page).to have_link("Activate")
    end

    within("#"+businesses[1].slug) do
      click_link("Deactivate")
    end
    expect(current_path).to eq(platform_admin_dashboard_path)

    within("#"+businesses[1].slug) do
      expect(page).to have_content(businesses[1].name)
      expect(page).to have_link("Activate")
    end
  end
end
