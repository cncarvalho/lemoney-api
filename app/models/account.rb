# frozen_string_literal: true

class Account < ActiveRecord::Base
  devise :database_authenticatable,
         :registerable,
         :validatable

  include DeviseTokenAuth::Concerns::User
end
