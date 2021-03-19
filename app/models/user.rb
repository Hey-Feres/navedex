# frozen_string_literal: true

#
# User's model
class User < ActiveRecord::Base
  #
  # Devise attributes
  #

  devise :database_authenticatable, :registerable, :recoverable, :validatable

  #
  # Modules
  #

  include DeviseTokenAuth::Concerns::User
end
