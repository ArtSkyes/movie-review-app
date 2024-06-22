class Api::V1::MoviesController < Api::V1::BaseController
  before_action :find_movie, only: %i[show update destroy]

  api :GET, "/api/v1/movies", "List movies"
  param :page, :number, desc: "Page number"
  param :per_page, :number, desc: "Number of movies per page"
  common_responses

  def index
    @movies = Movie.page(params[:page] || 1).per(params[:per_page] || 10)
    render json: @movies, meta: pagination_meta(@movies), each_serializer: Api::V1::MovieSerializer
  end

  api :GET, "/api/v1/movies/:id", "Show a movie"
  param :id, :number, required: true, desc: "Movie ID"
  common_responses

  def show
    render json: @movie, serializer: Api::V1::MovieSerializer
  end

  api :POST, "/api/v1/movies", "Create a movie"
  param :title, String, required: true, desc: "Movie title"
  param :description, String, required: true, desc: "Movie description"
  param :release_date, String, required: true, desc: "Movie release date"
  param :director, String, required: true, desc: "Movie director"
  param :rating, Integer, required: true, desc: "Movie rating"
  common_responses_for_create

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      render json: @movie, serializer: Api::V1::MovieSerializer, status: :created
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  api :PUT, "/api/v1/movies/:id", "Update a movie"
  param :id, :number, required: true, desc: "Movie ID"
  param :title, String, desc: "Movie title"
  param :description, String, desc: "Movie description"
  param :release_date, String, desc: "Movie release date"
  param :director, String, desc: "Movie director"
  param :rating, Integer, desc: "Movie rating"
  common_responses

  def update
    if @movie.update(movie_params)
      render json: @movie, serializer: Api::V1::MovieSerializer
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "/api/v1/movies/:id", "Delete a movie"
  param :id, :number, required: true, desc: "Movie ID"
  common_responses

  def destroy
    @movie.destroy
    render json: { message: "Successfully deleted movie" }, status: :ok
  end

  private

  def find_movie
    @movie = Movie.find_by(id: params[:id])
    render json: { error: "Movie not found" }, status: :not_found if @movie.nil?
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :release_date, :director, :rating)
  end

  def pagination_meta(objects)
    {
      current_page: objects.current_page,
      next_page:    objects.next_page,
      prev_page:    objects.prev_page,
      total_pages:  objects.total_pages,
      total_count:  objects.total_count
    }
  end
end
