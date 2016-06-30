FactoryGirl.define do
  factory :user do
    username
    password "password"
    password_confirmation "password"
    email "email@test.com"
    name "John Doe"
    address "1234 Fake Street"
    city  "Faketown"
    state "FT"
    zip "1234"
    role "default"

    factory :user_with_bid do
       after(:create) do |user|
         create(:bid, user: user)
       end
    end

    factory :user_with_bids do
       3.times do
         after(:create) do |user|
           create(:bid, user: user)
         end
       end
    end



  end

  sequence :name do |n|
    "item_#{n}"
  end

  sequence :price do |n|
    10 +  n
  end

  factory :bid do
    price
    user
    item
  end

  factory :item do
    name
    description "test description"
    price "5.99"
    image "http://i.imgur.com/kgOqHMk.gif"
    status 0
    end_time Time.now 

    factory :item_with_bids do
      bids { create_list(:bid, 3) }
    end

    factory :ended_item_with_bid do
      # bids { generate(:bid) }
      bids { create_list(:bid, 3) }
    end
  end


  factory :category do
    name
  end

  factory :order do
    user
    status 0

    factory "order_with_items" do
      items { create_list(:item, 3) }
    end
  end

  sequence :username do |n|
    "User #{n}"
  end

end
