class GalleryController < ApplicationController
  def index
    @books=Store.all
  end

  
  def search
    keyword = '%' + params[:search] + '%'
    @books = Store.find_by_sql ["Select * from stores WHERE name like ? or author like ? or category like ? or description like ?",keyword,keyword,keyword,keyword]
  end
  

  def checkout
    amount_to_charge = session[:amount].to_i
     if request.post?
        ActiveMerchant::Billing::Base.mode = :test
         credit_card = ActiveMerchant::Billing::CreditCard.new(
            :first_name => params[:first_name],
            :last_name => params[:last_name],
            :number => params[:credit_no].to_i,
            :month => params[:check][:month].to_i,
            :year => params[:check][:year].to_i,
            :verification_value => params[:verification_number].to_i) 
            gateway =ActiveMerchant::Billing::TrustCommerceGateway.new(
              :login => 'TestMerchant',
              :password =>'password',
              :test => 'true' )
              response = gateway.authorize(amount_to_charge , credit_card) 
             if response.success?
                gateway.capture(amount_to_charge, response.authorization)
                UserNotifierMailer.purchase_complete(current_user,current_cart).deliver 
                flash[:notice]="Thank You for using Book Buffet. The order details are sent to your mail"
                session[:cart_id]=nil
                session[:amount]=nil
                redirect_to :action=>:purchase
             else
                   flash[:notice]= "Something went wrong.Try again"
                   render :action => "checkout"
             end
     end
  end
end
