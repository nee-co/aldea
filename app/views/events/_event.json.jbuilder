json.extract! event, *%i(id title started_at ended_at image)

json.extract! event, *%i(body venue entry_upper_limit status) if extend
