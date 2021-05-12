class Api::V1::SchoolsController < ApplicationController
  def create
    school.save
    render json: school, status: :created
  end

  def update
    school.update(school_params)
    render json: school, status: :ok
  end

  def destroy
    school.destroy
    render json: school, status: :ok
  end

  private

  def school
    @school ||= school_id ? School.find_by!(id: school_id) : School.new(school_params)
  end

  def school_id
    @school_id ||= params[:id]
  end

  def school_params
    params.require(:school).permit(:name, :address)
  end
end
