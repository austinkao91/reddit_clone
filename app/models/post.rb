# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
    validates :user_id, :title, presence: true
    validate :has_sub?
    has_many(
      :post_subs,
      class_name: "PostSub",
      foreign_key: :post_id,
      primary_key: :id,
      inverse_of: :post
    )

    has_many(
      :subs,
      through: :post_subs,
      source: :sub
    )

    belongs_to(
      :author,
      class_name: "User",
      foreign_key: :user_id,
      primary_key: :id
    )

    has_many :comments,
      class_name: 'Comment',
      foreign_key: :post_id,
      primary_key: :id,
      dependent: :destroy

    private
    def has_sub?
      errors[:base] << "No associated subs!" if self.post_subs.empty?
    end
end
