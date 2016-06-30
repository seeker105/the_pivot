namespace :auction do
  desc "updates item status when end date for auction has passed"
  task update_status: :environment do
    puts "Updating item statuses..."
    Item.update_status
    puts "Updated item statuses"
  end
end
