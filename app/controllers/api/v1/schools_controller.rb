class Api::V1::SchoolsController < ApplicationController
  def create
    if school.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def update
    if school.update(school_params)
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    if school.destroy
      render status: :ok
    else
      render status: :unprocessable_entity
    end
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
