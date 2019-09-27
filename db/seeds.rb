# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  # User.create(
  #   email: Faker::Internet.email,
  #   password: 'aaaaaa',
  #   name: Faker::Movies::HarryPotter.character
  # )

  # sb = Setbox.create(title: Faker::Name.name)
    
  # 5.times do |i|
  #   Card.create(word_name: Faker::Name.name,
  #               word_def: Faker::Name.name,
# setbox_id = sb.id)
  # end

  # current_user = User.create(
  #     email: 'bbb@bbb.bbb',
  #     password: 'bbbbbb',
  #     name: Faker::Movies::HarryPotter.character
  # )
  
  current_user = User.find(7)

  sb = current_user.setboxes.create(title: Faker::Games::Pokemon.location)

  30.times do |i|
   current_user.setboxes[0].cards.create(card_word: Faker::Games::Pokemon.name,
                                        card_def: Faker::Games::Pokemon.move)
  end