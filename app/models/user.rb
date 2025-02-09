# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
