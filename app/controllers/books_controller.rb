class BooksController < ApplicationController
before_action :correct_user, only: [:edit, :update]


  def create
    @book = Book.new(book_pamas)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book.id)
    else
    @books = Book.all
    @user_info = User.find(current_user.id)
      render :index
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def index
    @book = Book.new
    @books = Book.all
    @user_info = User.find(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
    @user_info = @book.user
    @book_new = Book.new
    @comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_pamas)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book)
    else
      render :edit
    end
  end



  private
    def book_pamas
      params.require(:book).permit(:title, :body)
    end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end





end
