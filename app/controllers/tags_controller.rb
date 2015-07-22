class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end
  def show
    @tag = Tag.find params[:id]
  end
  def new
    @tag = Tag.new
    @creatures = Creature.all
  end
  def create
    t = Tag.create tag_params
    redirect_to tags_path
  end
  def update
    t = Tag.find params[:id]
    t.update tag_params
    redirect_to tags_path
  end
  def destroy
    t = Tag.find(params[:id])
    c = t.creatures.count
    if c == 0
      t.delete
    else
      flash[:danger] = "Not able to delete this #TADpole because it is used by #{c} creatures."
    end
    redirect_to tags_path
  end

private
  def tag_params
    params.require(:tag).permit(:name)
  end
  def update_tags tag
      tag_creatures = params[:tag][:creature_ids]
      tag_creatures.each do |id|
        tag.creatures << Tag.find(id) unless id.blank?
      end
  end
end