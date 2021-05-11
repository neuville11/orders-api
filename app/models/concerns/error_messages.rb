require 'active_support/concern'

module ErrorMessages
  extend ActiveSupport::Concern

  module ClassMethods
    def add_status_error(errors, message)
			errors.add(I18n.t('label.status'), message)
		end

		def add_count_error(**args)
			args[:errors].add(I18n.t('label.count', label: args[:label]), args[:message])
		end
  end
end
