class Api::V1::ArtcileSerializer < ActiveModel::Serializer
  attributes :id, :title, :body 
  has_many :comments 
end
