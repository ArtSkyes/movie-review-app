module Api
  module V1
    class ReviewSerializer < ActiveModel::Serializer
      attributes :id, :content, :rating, :movie_id, :created_at, :updated_at
    end
  end
end
