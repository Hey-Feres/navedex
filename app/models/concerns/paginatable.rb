# frozen_string_literal: true

#
# Model Pagination Module
module Paginatable
  extend ActiveSupport::Concern

  DEFAULT_LENGTH = 20
  DEFAULT_PAGE = 1

  included do
    scope :paginate, -> (page: DEFAULT_PAGE, length: DEFAULT_LENGTH) do
      page = page.to_i
      length = length.to_i

      page = page > 0 ? page : DEFAULT_PAGE
      length = length > 0 ? length : DEFAULT_LENGTH

      starts_at = (page - 1) * length
      limit(length).offset(starts_at)
    end
  end
end