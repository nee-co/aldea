class Search::Event
  include ActiveModel::Model

  attr_accessor :keyword

  def matches
    results = ::Event.all
    results = results.keyword_like(keyword) if keyword.present?
    results.distinct
  end
end

