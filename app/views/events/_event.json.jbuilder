json.extract! event, *%i(id title start_date image)

json.extract! event, *%i(body is_public) if extend
