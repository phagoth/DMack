class DirectorInvitationsController < InvitationsController
  before_action :set_production

  def index
    @invitations = DirectorInvitation.where(to: @production).order(:last_name)
    @invitation = DirectorInvitation.new()
  end

  def create
    @invitation    = DirectorInvitation.new(invitation_params)
    @invitation.to = @production
    @invitation.by = current_user
   
    @invitation.resume_id = params[:resume_id] 
    respond_to do |format|
      if @invitation.save
        name="#{params[:director_invitation][:first_name]} #{params[:director_invitation][:last_name]}"
	d=Director.new(:first_name => params[:director_invitation][:first_name], :last_name => params[:director_invitation][:last_name], :email => params[:director_invitation][:email], :name => name)
	d.save	

        send_director_invitation @invitation, params[:stage_name]
	format.html {redirect_to production_director_invitations_path(@production), notice: "Invitation has been sent"}
        format.json {render json: @invitation}
      else
        format.html {render :index}
        format.json {render json: @invitation.errors.full_messages, status: :unprocessable_entity}
      end
    end
  end


  private

  def set_production
    @production = Production.find(params[:production_id])
  end

  def invitation_params
    director_invitation_params
  end

  def director_invitation_params
    params.require(:director_invitation).permit(:first_name, :last_name, :email, :text)
  end

  def send_director_invitation(invitation, stage_name)
    production = invitation.to
    # if production.director_invitations.where(email: inv.email, by: inv.by).count > 1
    #   puts "Duplicate director invitation - INGORING"
    #   puts production.director_invitations.where(email: inv.email, by: inv.by).to_json
    # else
      puts "Sending director invitation"
      AmMailer.invite_director(invitation, production, current_user.name, stage_name).deliver
    # end
  end
end
