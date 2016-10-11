# LitBids
## Built with Ruby on Rails

### Development Team
[Erin Greenhalgh](https://github.com/ErinGreenhalgh), [Brian Sayler](https://github.com/saylerb), [Chris Soden](https://github.com/seeker105)

This project was created as a part of the curriculum for the [Turing School of Software & Design](http://turing.io).

### Overview

This Rails application took a previous project, an single-tenant ecommerce web application, and pivoted it to  a multi-tenancy application, implementing a bidding system instead of a typical cart-and-orders system. Users can bid on and win multiple items from different businesses. They can also create businesses to become business admins and monitor the item action for theri businesses. Platform admins have access to every business on the app and change business status between active and inactive.

### Live Version

You can find a live version of this application on Heroku at: [https://litbids.herokuapp.com/](https://litbids.herokuapp.com/)

### Setup

To set up a local copy of this project, perform the following:

  1. Clone the repository: `git clone https://github.com/seeker105/the_pivot`
  2. `cd` into the project's directory
  3. Run `bundle install`
  4. Run `rake db:create db:migrate db:seed` to set up the postgres database and seed it with users, admins, businesses, items, and categories.
    - To navigate the site as a platform admin user username: jorge and password: password
    - To navigate the site as a business admin user username: jcasimir and password: password
    - To navigate the site as a regular user user username: user and password: password
    - If you would like to create your own database information do not run `db:seed`
    - There are items in the seed data with an auction end time in the past. There is a Heroku scheduler that will run a rake task to close open auctions every hour. To manually close these auctions up app startup, run `heroku run rake auction:update_status`.
  5. Run the application in the dev environment by running `rails s`

### App Features

Some of the main features of the app include:

#### Default Users
  Users can:
  - browse items by category and by business
  ![users browses items by category and business](http://imgur.com/klnxv54.png)
  - bid on items from multiple businesses
  ![user bids on items](http://imgur.com/PC5C9jb.png)
  - win items if they are the high bidder when the auction closes
  - view their auction information, including open auctions, auctions lost, and auctions won, on their dashboard
  ![user wins items when they are the highest bidder when auction closes]()
  ![user views auction information on their dashboard](http://imgur.com/MBzoNtn.png)
  - update their profile information
  ![user updates their information](#)
  - create a business (Businesses are not active until the platform admin activates them.)
  ![user creates a business](#)

#### Business Admins
  Business admins can:
  - view a list of their businesses from their admin dashboard
  ![business admin views businesses they own](http://imgur.com/VdytaPE.png)
  - view the business dashboards of all of their businesses to see item information
  ![business admin sees their business' dashboards](http://imgur.com/RNeX6mq.png)
  - update business information
  ![business admin can update business information](http://imgur.com/NZfgky4.png)
  - update item information for items that belong to their business
  ![business admin updates item information for their businesses](http://imgur.com/Dlsqmj2.png)
  - perform any actions that default users can perform

#### Platform Admins
  Platform admins can:
  - view a list of all businesses from their admin dashboard
  ![admins can view all their businesses](http://imgur.com/FifbH45.png)
  - activate and deactivate businesses from their admin dashboard
  ![admins can deactivate and activate businesses](http://imgur.com/jzp4kS4.png)
  - perform any actions that default users and business admins can perform

#### Machine Learning Feature:
  We have implemented a rudimentary machine learning feature that predicts the final selling price of an item.
  - The algorithm takes in a training set of data, with each data point representing one bid. The x value is the time elapsed since the auction start and the y value is the price of the bid.
  - It then generates a trained function that can take in an x value, the amount of time elapsed between auction start and auction end, and returns a y value that represents the predicted price of the item at auction end.
  - The function is describes a square root graph in which y is the square root of x. It was estimated that this shape of graph would roughly fit bit data.

### Dependencies

This application depends on many ruby gems, all of which are found in the `Gemfile` and can be installed by running `bundle install` from the terminal in the main directory of the project.
