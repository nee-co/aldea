json.extract! user, *%i(name number)
json.user_image user.image_path

json.college do
  json.name user.college.name
  json.code user.college.code
end
