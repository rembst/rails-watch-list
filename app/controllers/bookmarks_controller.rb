class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list_id = @list.id

    if @bookmark.save
      redirect_to @list, notice: "#{Movie.find(@bookmark.movie_id).title} was successfully added to #{@list.name}."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    movie_name = @bookmark.movie.title
    @list = @bookmark.list

    if @bookmark.destroy
      redirect_to @list, notice: "#{movie_name} was successfully delete from #{@list.name}."
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end
