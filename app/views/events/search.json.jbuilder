json.array!(@events) do |event|
  json.title event.title
  json.tags event.tags.map(&:name)
  json.url event_url(event, format: :json)
end
