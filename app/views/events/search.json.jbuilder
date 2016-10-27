json.page @page
json.per @per
json.total_count @events.total_count
json.events(@events) do |event|
  json.event_id event.id
  json.extract! event, *%i(title started_at ended_at venue entry_upper_limit status)
  json.tags event.tags.map(&:name)
end
