Dir.glob(Rails.root.join("db/seeds/master/*.rb")).sort.each do |path|
  load path
end

Dir.glob("#{Rails.root}/db/seeds/#{Rails.env}/*.rb").sort.each do |path|
  load path
end
