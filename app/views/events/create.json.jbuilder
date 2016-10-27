json.event_id @event.id
json.extract! @event, *%i(title body started_at ended_at venue entry_upper_limit)
json.tags @event.tags.map(&:name)
