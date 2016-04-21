require 'mailgun'
class HomeController < ApplicationController
  def index
  end
  
  def write
    @title = params[:title]
    @content = params[:content]
    
    #메일 보내는 부분
    mg_client = Mailgun::Client.new("key-c1945760b48b93f3199ddaecaeac0e0e")
    message_params =  {
                      from: 'MHc9mailgun@likelion.com',
                      to:   'ekerll@nate.com',
                      subject: @title,
                      text:    @content
                      }
    result = mg_client.send_message('sandboxbabdd8bd134d4d54aa3dcca3dc133da3.mailgun.org', message_params).to_h!
    message_id = result['id']
    message = result['message']
    
    #DB에 저장하는 부분
    new_post = Post.new
    new_post.content = params[:content]
    new_post.title = params[:title]
    new_post.save
    
    redirect_to "/list"
  end
  
  def list
    @every_post = Post.all.order("id desc")
                                #asc는 올바른 순서. 기본셋팅
  end
  
  def destroy
    @one_post = Post.find(params[:post_id])
    @one_post.destroy
    redirect_to "/list"
  end
  
  def update_view
    @one_post = Post.find(params[:post_id])
  end
  
  def realupdate
    @one_post = Post.find(params[:post_id])
    @one_post.content = params[:content]
    @one_post.title = params[:title]
    @one_post.save
    redirect_to "/list"
  end
  
end












