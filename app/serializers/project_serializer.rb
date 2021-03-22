# frozen_string_literal: true

#
# Serializer
class ProjectSerializer < ActiveModel::Serializer
  #
  # Attributes
  #

  attributes :id, :name, :navers

  #
  # Project navers
  def navers
    object.navers
  end
end
