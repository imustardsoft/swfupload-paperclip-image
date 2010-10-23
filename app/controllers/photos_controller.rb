class PhotosController < ApplicationController
  def new
    @photos = Photo.find(:all)
    render :layout => "photo"
  end

  def create
    @photo = Photo.new(:swfupload_file => params[:Filedata])
    if @photo.save
      render :text => "#{@photo.file.url(:medium)}"
    end  
  end
end
