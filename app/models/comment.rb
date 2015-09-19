# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text
#  user_id           :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Comment < ActiveRecord::Base
  validates :user_id, :post_id, presence: true

  belongs_to :author,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :post,
    class_name: 'Post',
    foreign_key: :post_id,
    primary_key: :id

  belongs_to :parent_comment,
    class_name: 'Comment',
    foreign_key: :parent_comment_id,
    primary_key: :id

  has_many :child_comments,
    through: :parent_comment,
    source: :parent_comment
end
