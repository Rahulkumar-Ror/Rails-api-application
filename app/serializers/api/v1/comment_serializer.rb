class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :date_of_comment
  belongs_to :article
end
