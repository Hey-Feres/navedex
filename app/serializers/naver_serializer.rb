# frozen_string_literal: true

#
# Serializer
class NaverSerializer < ActiveModel::Serializer
  #
  # Attributes
  #

  attributes :id, :projects, :name, :birthdate, :admission_date, :job_role

  #
  # Naver projects
  def projects
    object.projects
  end
end
