# frozen_string_literal: true

#
# Serializer for naver
class NaversSerializer < ActiveModel::Serializer
  #
  # Attributes
  #

  attributes :id, :name, :birthdate, :admission_date, :job_role, :created_at, :updated_at, :projects

  #
  # Methods
  #

  def projects
    object.projects
  end
end
