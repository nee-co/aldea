json.extract! user, *%i(name number user_image note)

json.college do
  json.name user.college.name
  json.code user.college.code
end
