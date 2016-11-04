json.event_id @event.id
json.event_image @event.image_url
json.extract! @event, *%i(title body started_at ended_at published_at venue entry_upper_limit status)
json.tags @event.tags.map(&:name)
