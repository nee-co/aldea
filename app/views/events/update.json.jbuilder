json.extract! @event, *%i(id title body started_at ended_at published_at venue entry_upper_limit status image)
json.tags @event.tags.map(&:name)
