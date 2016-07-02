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
      transient do
        bid_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:bid, evaluator.bid_count, user: user)
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
    status "open"
    end_time Time.now

    factory :item_with_bids do
      transient do
        bid_count 3
      end

      after(:create) do |item, evaluator|
        create_list(:bid, evaluator.bid_count, item: item)
      end
    end
  end


  factory :category do
    name
  end

  sequence :username do |n|
    "User #{n}"
  end



  factory :business do
    sequence(:name) { |n| "Business Name #{n}"}
    active false
  end

end
