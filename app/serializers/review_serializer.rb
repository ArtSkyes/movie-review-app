class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :content, :rating, :movie_id
end
