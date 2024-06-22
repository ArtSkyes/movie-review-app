module Api
  module V1
    class PaginatedReviewsSerializer < ActiveModel::Serializer
      attributes :previous_page, :next_page, :total_pages, :current_page, :total_count, :reviews

      def reviews
        object.map { |review| Api::V1::ReviewSerializer.new(review) }
      end

      delegate :previous_page, to: :object

      delegate :next_page, to: :object

      delegate :total_pages, to: :object

      delegate :current_page, to: :object

      delegate :total_count, to: :object
    end
  end
end
