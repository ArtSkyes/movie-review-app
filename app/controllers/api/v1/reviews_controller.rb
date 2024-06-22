class Api::V1::ReviewsController < Api::V1::BaseController
  before_action :find_movie, only: %i[index create]
  before_action :find_review, only: %i[show update destroy]

  api :GET, "/api/v1/movies/:movie_id/reviews", "List reviews for a movie"
  param :movie_id, :number, required: true, desc: "Movie ID"
  param :page, :number, desc: "Page number"
  param :per_page, :number, desc: "Number of reviews per page"
  common_responses

  def index
    @reviews = @movie.reviews.page(params[:page] || 1).per(params[:per_page] || 10)
    render json: @reviews, each_serializer: Api::V1::ReviewSerializer
  end

  api :GET, "/api/v1/reviews/:id", "Show a review"
  param :id, :number, required: true, desc: "Review ID"
  common_responses

  def show
    render json: @review, serializer: Api::V1::ReviewSerializer
  end

  api :POST, "/api/v1/movies/:movie_id/reviews", "Create a review"
  param :movie_id, :number, required: true, desc: "Movie ID"
  param :content, String, required: true, desc: "Review content"
  param :rating, Integer, required: true, desc: "Review rating"
  common_responses_for_create

  def create
    @review = @movie.reviews.build(review_params)
    if @review.save
      render json: @review, serializer: Api::V1::ReviewSerializer, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  api :PUT, "/api/v1/reviews/:id", "Update a review"
  param :id, :number, required: true, desc: "Review ID"
  param :content, String, desc: "Review content"
  param :rating, Integer, desc: "Review rating"
  common_responses

  def update
    if @review.update(review_params)
      render json: @review, serializer: Api::V1::ReviewSerializer
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "/api/v1/reviews/:id", "Delete a review"
  param :id, :number, required: true, desc: "Review ID"
  common_responses

  def destroy
    @review.destroy
    head :no_content
  end

  private

  def find_movie
    @movie = Movie.find_by(id: params[:movie_id])
    render json: { error: "Movie not found" }, status: :not_found if @movie.nil?
  end

  def find_review
    @review = Review.find_by(id: params[:id])
    render json: { error: "Review not found" }, status: :not_found if @review.nil?
  end

  def review_params
    params.require(:review).permit(:content, :rating, :movie_id)
  end
end
