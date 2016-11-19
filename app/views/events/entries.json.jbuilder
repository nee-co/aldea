json.page @page
json.per @per
json.total_count @total_count
json.events(@events) do |event|
  json.extract! event, *%i(id title started_at ended_at venue entry_upper_limit status image)
  json.tags event.tags.map(&:name)
end
