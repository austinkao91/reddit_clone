# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :string           not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :title, :description, :user_id, presence: true

  belongs_to :moderator,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id

  has_many :postsubs,
    class_name: "PostSub",
    foreign_key: :sub_id,
    primary_key: :id,
    dependent: :destroy

  has_many :posts,
    through: :postsubs,
    source: :post
end
