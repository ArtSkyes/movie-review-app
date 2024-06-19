class Api::V1::MoviesController < Api::V1::BaseController
  api :GET, "/movies", "List movies"
  param :page, :number, desc: "Page number"

  class Api::V1::MoviesController < Api::V1::BaseController
    def index
      @movies = Movie.page(params[:page]).per(10)
      render json: @movies, each_serializer: MovieSerializer
    end

    def show
      @movie = Movie.find(params[:id])
      render json: @movie, serializer: MovieSerializer
    end

    def create
      @movie = Movie.new(movie_params)
      if @movie.save
        render json: @movie, serializer: MovieSerializer, status: :created
      else
        render json: @movie.errors, status: :unprocessable_entity
      end
    end

    def update
      @movie = Movie.find(params[:id])
      if @movie.update(movie_params)
        render json: @movie, serializer: MovieSerializer
      else
        render json: @movie.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      head :no_content
    end

    private

    def movie_params
      params.require(:movie).permit(:title, :description, :release_date, :director, :rating)
    end
  end
end
