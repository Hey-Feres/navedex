# frozen_string_literal: true

#
# Project's model
class Project < ApplicationRecord
  #
  # Modules
  #

  include Searchable
  include Paginatable

  #
  # Virtual Attributes
  #

  attr_accessor :navers_ids, :remove_navers_ids

  #
  # Associations
  #

  has_and_belongs_to_many :navers, dependet: :destroy

  #
  # Callbacks
  #

  before_validation :set_navers, :remove_navers

  private
    #
    # Set the navers of project
    def set_navers
      return unless navers_ids.present?

      navers_ids.uniq.each do |naver_id|
        naver = Naver.find(naver_id)

        navers << naver if navers.map(&:id).exclude?(naver_id)
      end
    end

    #
    # Remove the navers from project
    def remove_navers
      return unless remove_navers_ids.present?

      remove_navers_ids.uniq.each do |naver_id|
        naver = Naver.find(naver_id)

        navers.delete(naver) if navers.map(&:id).include?(naver_id)
      end
    end
end
