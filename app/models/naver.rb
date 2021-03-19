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
  # Virtual Attributes
  #

  attr_accessor :projects_ids, :remove_projects_ids

  #
  # Associations
  #

  has_and_belongs_to_many :projects, dependet: :destroy

  #
  # Callbacks
  #

  before_validation :set_projects, :remove_projects

  private
    #
    # Set the projects of naver
    def set_projects
      return unless projects_ids.present?

      projects_ids.uniq.each do |project_id|
        project = Project.find(project_id)

        projects << project if projects.map(&:id).exclude?(project_id)
      end
    end

    #
    # Remove the projects of naver
    def remove_projects
      return unless remove_projects_ids.present?

      remove_projects_id.uniq.each do |project_id|
        project = Project.find(project_id)

        projects.delete(project) if projects.map(&:id).include?(project_id)
      end
    end
end
