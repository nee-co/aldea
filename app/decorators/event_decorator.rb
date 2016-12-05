class EventDecorator < Draper::Decorator
  delegate_all

  def image
    File.join(Settings.static_image_url, object.image)
  end
end
