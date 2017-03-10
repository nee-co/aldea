class TrayController < ApplicationController
  before_action :set_limit_offset_param!

  def entries
    @elements = current_user.entry_events.yet.order(:start_date).limit(@limit).offset(@offset).decorate
    @total_count = @elements.object.total_count
    render "elements"
  end

  def own
    @elements = current_user.owned_events.yet.order(:start_date).limit(@limit).offset(@offset).decorate
    @total_count = @elements.object.total_count
    render "elements"
  end
end
