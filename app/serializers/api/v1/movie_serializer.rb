module Api
  module V1
    class MovieSerializer < ActiveModel::Serializer
      attributes :id, :title, :description, :release_date, :director, :rating
    end
  end
end
