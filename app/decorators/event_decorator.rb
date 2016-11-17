class EventDecorator < Draper::Decorator
  delegate_all

  def image_url
    image_path = File.exist?(File.join("uploads", object.image)) ? object.image : Event::DEFAULT_IMAGE_PATH
    File.join(Settings.static_url, image_path)
  end
end
