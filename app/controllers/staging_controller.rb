class StagingController < ApplicationController
    before_action :set_user, only: [:apply_creator_status, :approve_creator_status,
        :revoke_creator_status, :ad]
    before_action :require_creator, only: [:ad]

    def ad
    end

    def apply_creator_status
        @user.toggle!(:awaiting_creator_approval?)
        respond_to do |format|
            format.html { redirect_to "/#{@user.id}" }
            flash[:success] = "Your request has been sent. You should hear back from us shortly!"
            format.json { head :no_content }
        end
    end

    def approve_creator_status
        @user.update(awaiting_creator_approval?: false)
        @user.update(creator?: true)
        respond_to do |format|
            format.html { redirect_to "/#{@user.id}" }
            flash[:success] = "#{@user.username} has been approved!"
            format.json { head :no_content }
        end
    end

    def revoke_creator_status
        @user.update(awaiting_creator_approval?: false)
        @user.update(creator?: false)
        respond_to do |format|
            format.html { redirect_to "/#{@user.id}" }
            flash[:success] = "#{@user.username}'s creator status has been revoked."
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    def require_creator
        if !@user.creator?
            redirect_back(fallback_location: "/#{@user.id}")
        end
    end

end
