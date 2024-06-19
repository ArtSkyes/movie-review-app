class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :release_date, :director, :rating
end
