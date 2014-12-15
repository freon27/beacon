class RequestsController < ApplicationController
  
  before_action :authenticate_user!
  
  
  def index
    if params[:show_complete]
      @requests = Request.all
    else
      @requests = Request.where(:complete => false)
    end
  end
  
  def show
    @request = Request.find(params[:id])
    @attachment = @request.attachments.build
  end
  
  def new   
  end
  
  def update
      @request = Request.find(params[:id])
      previously_complete = @request.complete
      if @request.update_attributes(request_params)
        flash[:notice] = "Request updated successfully."
        # send a completion email
        if ! previously_complete && @request.complete
          BeaconMailer.completion_email(current_user.email, @request).deliver
        end
      end
      redirect_to(:back)
  end
  
  def create
    puts request_params.merge(:requestor_id => current_user.id)
    @request = Request.new(request_params.merge(:requestor_id => current_user.id))
        if @request.save
          BeaconMailer.request_created_email(current_user.email, @request).deliver
          redirect_to :requests
        else
          flash.now[:error] = "Could not save request"
          render :new
        end
  end
  
  private
      # Using a private method to encapsulate the permissible parameters is
      # just a good pattern since you'll be able to reuse the same permit
      # list between create and update. Also, you can specialize this method
      # with per-user checking of permissible attributes.
      def request_params
        params.require(:request).permit(:title, :details, :urgency, :relevancy, :assigned_to, :complete)
      end
end
