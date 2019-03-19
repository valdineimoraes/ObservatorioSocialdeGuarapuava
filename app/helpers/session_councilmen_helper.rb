# frozen_string_literal: true

module SessionCouncilmenHelper
  def councilman_value(s, c, attribute)
    sc = s.session_councilmen.find_by(councilman_id: c.id)
    return '' if sc.nil?

    sc.send(attribute)
  end
end
