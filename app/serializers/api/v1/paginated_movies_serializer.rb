module Api
  module V1
    class PaginatedMoviesSerializer < ActiveModel::Serializer
      attributes :previous_page, :next_page, :total_pages, :current_page, :total_count, :movies

      def movies
        object.map { |movie| Api::V1::MovieSerializer.new(movie) }
      end

      delegate :previous_page, to: :object

      delegate :next_page, to: :object

      delegate :total_pages, to: :object

      delegate :current_page, to: :object

      delegate :total_count, to: :object
    end
  end
end
