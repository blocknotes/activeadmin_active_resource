# frozen_string_literal: true

Dir[File.expand_path("../app/**/*.rb", __dir__)].sort.each { |f| require f }

puts 'Authors...'
(11..20).each do |i|
  age = 21 + 3 * (i - 10)
  attrs = { name: "Author #{i}", age: age, email: "some@email#{i}.com" }
  # attrs[:profile] = Profile.new(description: "Profile description for Author #{i}") if (i % 3).zero?
  Models::Author.create(attrs)
end

puts 'Tags...'
(11..15).each do |i|
  attrs = { name: "Tag #{i}" }
  Models::Tag.create(attrs)
end

puts 'Posts...'
(11..40).each do |i|
  attrs = { title: "Post #{i}" }
  Models::Post.create(attrs)
end
