json.total_count @events.size
json.events(@events) do |event|
  json.title event.title
  json.tags event.tags.map(&:name)
  json.url event_url(event, format: :json)
end
