# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

  Post.create!([
    { title: "Laravel para sempre em tads?", content: "This is the content of the first post." },
    { title: "Joao vai trabalhar na prefeitura", content: "This is the content of the second post." },
    { title: "giovana saiu cedo", content: "This is the content of the third post." }
  ])


    Comment.create!([
      { content: "será??, ou RoR?", post_id: 1}
    ])
