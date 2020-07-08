# == Schema Information
#
# Table name: goals
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  details    :text
#  completed  :boolean          default(FALSE)
#  private    :boolean          default(FALSE)
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Goal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
