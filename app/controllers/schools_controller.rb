class SchoolsController < ApplicationController
  before_action :get_school, only: %i[show update edit destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def new
    @form = SchoolForm.new
  end

  def create
    @form = SchoolForm.new(current_user.schools.new, school_params)

    authorize School

    if @form.save
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

  def edit
    @form = SchoolForm.new(@school)
  end

  def update
    authorize @school

    @form = SchoolForm.new(@school, school_params)

    if @form.save
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

  def school_params
    params[:school]
  end

  def school_id
    params[:id]
  end
end
