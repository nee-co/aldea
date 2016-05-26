json.array!(@events) do |event|
  json.extract! event, :title, :published_at, :started_at, :ended_at, :venue, :status
  json.tags event.tags.map(&:name)
  json.url event_url(event, format: :json)
end
