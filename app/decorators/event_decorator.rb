class EventDecorator < Draper::Decorator
  delegate_all

  def image
    File.join(Settings.static_image_url, object.image)
  end

  def type
    "event"
  end

  def meta
    {
      type: "date",
      body: object.start_date
    }
  end
end
