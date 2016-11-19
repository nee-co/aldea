json.extract! event, *%i(id title started_at ended_at image)

if extend
  json.extract! event, *%i(body published_at venue entry_upper_limit status)
end
