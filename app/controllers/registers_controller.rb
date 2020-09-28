class RegistersController < ApplicationController
  before_action :set_course
  before_action :set_register, only: %i(edit update)

  def new
    @register = Register.new
  end

  def create
    @register = @course.registers.build register_params.merge(user_id: current_user.id)
    if @register.save
      flash[:info] = t ".register_created"
      redirect_to current_user
    else
      flash.now[:danger] = t ".register_fail"
      render :new
    end
  end

  def edit; end

 def update
    if @register.update register_params
      redirect_to current_user
      flash[:success] = "review_updated"
    else
      flash.now[:danger] = "review_not_updated"
      render :edit
    end
  end

  private

  def set_course
    @course = Course.find_by id: params[:course_id]
    return if @course

    flash[:warning] = t ".course_not_found"
    redirect_to courses_path
  end

  def register_params
    params.require(:register).permit :name, :email, :status  
  end

  def set_register
    @register = Register.find_by id: params[:id]
    return if @register

    flash[:warning] = t ".register_not_found"
    redirect_to courses_path
  end
end
