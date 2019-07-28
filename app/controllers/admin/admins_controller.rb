class Admin::AdminsController < ApplicationController
  before_action :authenticate_admin!
  before_action :admin_only, only: [:create, :update]
  def index
    @admins = Admin.all
  end
  def show
    redirect_to admin_admins_path
    flash[:alert] = "Successful"
  end
  def new
    @admin = Admin.new
  end
  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admin_admin_path(@admin)
    else
      render :new
    end
  end
  def destroy
    admin = Admin.find(params[:id])
    if(admin.role == "user")
      admin.destroy
      flash[:success] = "User Deleted Successfully"
      redirect_to admin_admins_path
    else
      flash[:alert] = "Admin User Can NOT Be Deleted"
      redirect_to admin_admins_path
    end
  end
  def edit
    @admin = Admin.find(params[:id])
  end
  def update
    no_require_password
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params)
      redirect_to admin_admin_path(@admin)
    else
      render :edit
    end
  end
  private
  def no_require_password
    if params[:admin][:password].blank?
      params[:admin].delete("password")
      params[:admin].delete("password_confirmation")
    end
  end
  def admin_params
      params.required(:admin).permit!
  end
  def admin_only
    if current_admin.role != "admin"
      flash[:alert] = "ascess denied"
      redirect_to admin_dashboard_path
    end
  end
end
