namespace :blog do
  desc "init blog info"
  task :init => :environment do # 執行 environment 後 再執行 init
    # puts "Hello"
    # puts Faker::Internet.email
    # init user and articles
    5.times {
      u = User.create(email: Faker::Internet.email, password: "123456")
      blog = u.create_blog(
        handler: Faker::Name.unique.name.downcase.gsub(" ", "_").delete("."),
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraphs(number: 2).join
      )
      puts "blog #{blog.handler} created"

      10.times {
        article = u.articles.create(
          title: Faker::Lorem.sentence,
          content: Faker::Lorem.paragraphs(number: 5).join
        )
        puts " title: #{article.title} created"
      }    
      puts "user: #{u.email} created"
    }
  end
end