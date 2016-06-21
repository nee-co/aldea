# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# Create Events
CSV.foreach('db/seeds/events.csv') do |list|
  Event.create(
    title: list[0],
    body: list[1],
    register_id: list[2].to_i,
    published_at: list[3],
    started_at: list[4],
    ended_at: list[5],
    venue: list[6],
    entry_upper_limit: list[7].to_i,
    status: list[8].to_i
  )
end
