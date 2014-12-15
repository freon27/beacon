class AttachmentsController < ApplicationController
  
  before_action :authenticate_user!
  
  def new
    @request = Request.find(params[:request_id])
    @attachment = @request.attachments.build
  end
  
  def create
    @request = Request.find(params[:request_id])
    logger.debug @request.inspect
    logger.debug attachment_params.inspect
    @attachment = @request.attachments.build(attachment_params)
    if @attachment.save
      flash[:notice] = "Attachment added successfully."
    else
      flash[:error] = "Error uploading attachment."
    end 
    redirect_to @request
  end
  
  def destroy
    @attachment = Attachment.find(params[:id])
    @request = @attachment.request
    @attachment.destroy
    redirect_to @request
  end
  
  private
      # Using a private method to encapsulate the permissible parameters is
      # just a good pattern since you'll be able to reuse the same permit
      # list between create and update. Also, you can specialize this method
      # with per-user checking of permissible attributes.
      def attachment_params
        params.require(:attachment).permit(:file, :request_id)
      end
end
