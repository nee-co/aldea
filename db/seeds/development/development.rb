require 'csv'

# Create Events
CSV.foreach('db/seeds/development/events.csv') do |list|
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

# Create Comments
CSV.foreach('db/seeds/development/comments.csv') do |list|
  Comment.create(
    body: list[0],
    event_id: list[1].to_i,
    user_id: list[2].to_i,
    posted_at: list[3]
  )
end

# Create Entries
CSV.foreach('db/seeds/development/entries.csv') do |list|
  Entry.create(
    event_id: list[0].to_i,
    user_id: list[1].to_i
  )
end

# Create Events_tags
CSV.foreach('db/seeds/development/events_tags.csv') do |list|
  Event.find(list[0]).tags << Tag.find(list[1])
end
