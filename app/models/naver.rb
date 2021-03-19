# frozen_string_literal: true

#
# Naver's model
class Naver < ApplicationRecord
  #
  # Modules
  #

  include Searchable
  include Paginatable

  #
  # Associations
  #

  has_and_belongs_to_many :projects, dependet: :destroy
end
