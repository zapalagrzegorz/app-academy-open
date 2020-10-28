# frozen_string_literal: true

json.array!(@users) do |user|
  json.call(user, :id, :username)
  json.followed(current_user.follows?(user))
end
