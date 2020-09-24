class ReviewsController < ApplicationController
  before_action :set_course
  before_action :set_review, only: %i(edit update destroy)

  def new
    @review = Review.new
  end
  
  def create
    @review = @course.reviews.build review_params.merge(user_id: current_user.id)
    if @review.save
      flash[:info] = t ".review_created"
      redirect_to course_path @course
    else
      flash.now[:danger] = t ".review_not_created"
      render :new
    end
  end

  def edit; end

  def update
    if @review.update review_params
      redirect_to course_path @course
      flash[:success] = t ".review_updated"
    else
      flash.now[:danger] = t ".review_not_updated"
      render :edit
    end
  end
  
  def destroy
    if @review.destroy
      redirect_to course_path @course
      flash[:success] = t ".review_deleted"
    else
      redirect_to course_path @course
      flash[:success] = t ".review_not_deleted"
    end
  end

  private 

  def review_params
    params.require(:review).permit :content
  end

  def set_course
    @course = Course.find_by id: params[:course_id]
    return if @course

    flash[:warning] = t ".course_not_found"
    redirect_to courses_path
  end

  def set_review
    @review = Review.find_by id: params[:id]
    return if @review

    flash[:warning] = t ".review_not_found"
    redirect_to courses_path
  end
end
