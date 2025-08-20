class Client < ApplicationRecord
  def name
    [ first_name, last_name ].compact.join(" ").strip
  end
end
