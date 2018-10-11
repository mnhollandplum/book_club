# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('db', 'csvs', 'books.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  Book.create(id: row['id'], title: row['title'], pages: row['pages'], year: row['year'])
end
puts "There are now #{Book.count} rows of data in the books table"

csv_text = File.read(Rails.root.join('db', 'csvs', 'authors.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  Author.create(id: row['id'], first_name: row['first_name'], last_name: row['last_name'])
end
puts "There are now #{Author.count} rows of data in the authors table"

csv_text = File.read(Rails.root.join('db', 'csvs', 'author_books.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  AuthorBook.create(book_id: row['book_id'], author_id: row['author_id'])
end
puts "There are now #{AuthorBook.count} rows of data in the author_books table"

csv_text = File.read(Rails.root.join('db', 'csvs', 'users.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  User.create(id: row['id'], username: row['username'])
end
puts "There are now #{User.count} rows of data in the users table"

csv_text = File.read(Rails.root.join('db', 'csvs', 'reviews.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  Review.create(book_id: row['book_id'],
                user_id: row['user_id'],
                title: row['title'],
                explanation: row['explanation'],
                score: row['score'])
end
puts "There are now #{User.count} rows of data in the users table"
