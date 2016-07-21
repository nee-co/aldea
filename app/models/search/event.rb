class Search::Event
  include ActiveModel::Model

  attr_accessor :keyword, :started_at, :ended_at

  def matches
    results = ::Event.all
    results = results.key_word_like(keyword) if keyword.present?
    results = results.started_between(started_at) if started_at.present?
    results = results.ended_between(ended_at) if ended_at.present?
    results
  end
end

