json.page @page
json.per @per
json.total_count @events.total_count
json.events(@events) do |event|
  json.title event.title
  json.tags event.tags.map(&:name)
  json.url event_url(event, format: :json)
end
