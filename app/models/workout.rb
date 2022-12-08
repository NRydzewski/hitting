# == Schema Information
#
# Table name: workouts
#
#  id          :integer          not null, primary key
#  image       :string
#  joins_count :integer
#  time        :datetime
#  workout     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :integer
#
class Workout < ApplicationRecord
  belongs_to(:owner, { :required => true, :class_name => "User", :foreign_key => "owner_id", :counter_cache => :own_workouts_count })
  has_many(:joins, { :class_name => "Join", :foreign_key => "workout_id", :dependent => :destroy })
end
