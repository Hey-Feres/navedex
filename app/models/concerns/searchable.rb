# frozen_string_literal: true

#
# Model Search Module
module Searchable
  extend ActiveSupport::Concern

  included do
    scope :search, -> (search_by: '', search_for: '') do
      column_type = self.columns.select { |column| column.name == search_by }.first.type

      if column_type == :date || column_type == :datetime || column_type == :time
        where("CAST(#{search_by} AS text) LIKE ?", "%#{search_for}%")
      else
        self.where("#{search_by} ILIKE ?", "%#{search_for}%")
      end
    end
  end
end