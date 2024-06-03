class ProfileController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index
    @profile = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    respond_to do |format|
      if @profile.save
        format.html { redirect_to profile_url(@profile), notice: 'Profile was successfully created.' }
      else
        format.html { redirect_to profile_index_url, notice: 'Failure' }
      end
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.delete
    respond_to do |format|
      format.html { redirect_to profile_index_path, notice: 'Profile was successfully deleted.' }
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    respond_to do |format|
      if @profile.update(profile_params)
        format.html do
          redirect_to profile_url(@profile), allow_other_host: true, notice: 'Profile was successfully updated.'
        end
      else
        format.html { redirect_to profile_index_url, notice: 'Failure' }
      end
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :home_address, :phone_number, :occupation, :location,
                                    :avatar, :user_id, :qr_code, :date_of_birth, :language, :home_town, :city, :country,
                                    :about_me, :health_insurance, :nhif_number, :nationality, :religion, :blood_group,
                                    :hospital_to_attend)
  end
end
