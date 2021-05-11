class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  MAX_GIFTS_PER_DAY = 60
  MAX_RECIPIENTS_PER_ORDER = 20

  def self.safe_find id
    begin
      find id
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end
end
