class Api::V1::ReviewsController < Api::V1::BaseController
  api :GET, "/api/v1/movies/:movie_id/reviews", "List reviews for a movie"
  param :movie_id, :number, desc: "Movie ID"
  param :page, :number, desc: "Page number"

  def index
    @reviews = Review.where(movie_id: params[:movie_id]).page(params[:page]).per(10)
    render json: @reviews, each_serializer: ReviewSerializer
  end

  def show
    @review = Review.find(params[:id])
    render json: @review, serializer: ReviewSerializer
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      render json: @review, serializer: ReviewSerializer, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      render json: @review, serializer: ReviewSerializer
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    head :no_content
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :movie_id)
  end
end
