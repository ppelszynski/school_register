class SchoolsController < ApplicationController
  before_action :get_school, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def new
    @school = School.new
  end

  def create
    @school = current_user.schools.new(school_params)
    authorize @school
    if @school.save
      current_user.add_role(:school_admin, @school)
      flash[:success] = 'School created.'
      redirect_to schools_path
    else
      render :new
    end
  end

  def index
    @schools = if current_user.is_admin?
                 School.all
               else
                 current_user.schools
               end
  end

  def show; end

  def edit; end

  def update
    authorize @school
    if @school.update(school_params)
      flash[:success] = 'Edited succesfully.'
      redirect_to @school
    else
      render :edit
    end
  end

  def destroy
    authorize @school
    if @school.destroy
      redirect_to schools_path
    else
      render :show
    end
  end

  private

  def handle_not_found
    flash[:error] = 'You are not authorized to do this!'
    redirect_to root_path
  end

  def get_school
    @school ||= if current_user.is_admin?
                  School.find(school_id)
                else
                  current_user.schools.find(school_id)
                end
  end

  def school_id
    params[:id]
  end

  def school_params
    params.require(:school).permit(:name, :adress, :phone_number, :status)
  end
end
