class Api::V1::ReviewsController < Api::V1::BaseController
  api :GET, "/api/v1/movies/:movie_id/reviews", "List reviews for a movie"
  param :movie_id, :number, required: true, desc: "Movie ID"
  param :page, :number, desc: "Page number"
  common_responses

  def index
    @reviews = Review.where(movie_id: params[:movie_id]).page(params[:page]).per(10)
    render json: @reviews, each_serializer: ReviewSerializer
  end

  api :GET, "/api/v1/reviews/:id", "Show a review"
  param :id, :number, required: true, desc: "Review ID"
  common_responses

  def show
    @review = Review.find(params[:id])
    render json: @review, serializer: ReviewSerializer
  end

  api :POST, "/api/v1/movies/:movie_id/reviews", "Create a review"
  param :movie_id, :number, required: true, desc: "Movie ID"
  param :content, String, required: true, desc: "Review content"
  param :rating, Integer, required: true, desc: "Review rating"
  common_responses

  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build(review_params)
    if @review.save
      render json: @review, serializer: ReviewSerializer, status: :created
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
    @review = Review.find(params[:id])
    if @review.update(review_params)
      render json: @review, serializer: ReviewSerializer
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "/api/v1/reviews/:id", "Delete a review"
  param :id, :number, required: true, desc: "Review ID"
  common_responses

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
