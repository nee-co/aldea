require 'csv'

# Create Tags
CSV.foreach('db/seeds/master/tags.csv') do |list|
  Tag.create(name: list[0])
end
