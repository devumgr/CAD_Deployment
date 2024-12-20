class BooksController < ApplicationController
  before_action :set_user
  before_action :set_book, only: [:create, :edit, :update, :destroy]

  def new
    @book = @user.books.new
  end

  def create
    @book = @user.books.new(book_params)
    if @book.save
      flash[:notice] = "Book added successfully!"
      redirect_to root_url
    else
      render 'static_pages/home', status: :unprocessable_entity
    end
  end



  def edit
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "Book updated successfully!"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "Error updating book. Please check the form."
    end
  end

  def destroy
    @book.destroy
    flash[:notice] = "Book deleted successfully!"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    redirect_to root_path, alert: "User not found." unless @user
  end

  def set_book
    @book = @user.books.find_by(id: params[:id])
    redirect_to user_path(@user), alert: "Book not found." unless @book
  end

  def book_params
    params.require(:book).permit(:title, :author, :genre, :status, :notes)
  end
end

