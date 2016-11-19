json.page @page
json.per @per
json.total_count @total_count
json.events(@events) do |event|
  json.partial! partial: 'event', locals: { event: event, extend: false }
end
