namespace :user do
  desc "Greeting"
  task :init do
    # puts "Hello"
    # puts Faker::Internet.email
    User.create(email: Faker::Internet.email, password: Faker::Internet.password)    
  end
end