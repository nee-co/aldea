class Search::Event
  include ActiveModel::Model

  attr_accessor :keyword, :started_at, :ended_at

  def escape_like(string)
    string.gsub(/\"/) { |m| "" }
  end

  def matches
    results = ::Event.all
    results = results.key_word_like(escape_like(keyword)) if keyword.present?
    results = results.started_between(escape_like(started_at)) if started_at.present?
    results = results.ended_between(escape_like(ended_at)) if ended_at.present?
    results
  end
end

