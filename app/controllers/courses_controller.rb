class CoursesController < ApplicationController
  before_action :set_course, except: %i(index new create)

  def index
    @course = Course.recent_courses.page params[:page]
  end

  def new
    @course = Course.new
  end
  
  def show; end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:info] = t ".course_created"
      redirect_to courses_path
    else
      flash.now[:danger] = t ".course_not_created"
      render :new
    end
  end

  def edit; end

  def update
    if @course.update course_params
      redirect_to @course
      flash[:success] = t ".course_updated"
    else
      flash.now[:danger] = t ".course_cannot_be_updated"
      render :edit
    end
  end
  
  def destroy
    if @course.started? | @course.finished?
      redirect_to courses_path
      flash[:danger] = t ".course_not_deleted" 
    else @course.destroy
      redirect_to courses_path
      flash[:success] = t ".course_deleted"
    end
  end

  private 

  def course_params
    params.require(:course).permit :name, :description, :started_at, :member, :status, :total_month
  end

  def set_course
    @course = Course.find_by id: params[:id]
    return if @course

    flash[:warning] = t ".course_not_found"
    redirect_to courses_path
  end
end
