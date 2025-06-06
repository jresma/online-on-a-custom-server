namespace :db do
  desc "Create Products"
  task seed_products: :environment do
    Product.create!([
      { code: "GR1", name: "Green Tea", price: 3.11 },
      { code: "SR1", name: "Strawberries", price: 5 },
      { code: "CF1", name: "Coffee", price: 11.23 }
    ])
  end

  desc "Create Users"
  task seed_users: :environment do
    User.create!(email: "jossie@example.com", password: "123456", password_confirmation: "123456")
  end
end
