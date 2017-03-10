json.total_count @total_count
json.elements(@elements) do |element|
  json.extract! element, *%i(id type title image)
  json.meta element.meta
end
