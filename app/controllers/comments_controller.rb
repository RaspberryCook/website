class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, :only =>  [:destroy , :update , :edit ,:add]
  before_filter :check_owner, :only =>  [:destroy , :update , :edit ]


  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    msg = 'Votre commentaire à été correctement ajouté!' if @comment.save else 'Une erreure est survenue dans l\'ajout de votre commentaire'
    redirect_to  recipe_path( @comment.recipe_id ), notice: msg
  end

  # PATCH/PUT /comments/1
  def update
    msg = 'Votre commentaire à été correctement mis à jour!' if @comment.update(comment_params) else 'Une erreure est survenue dans la mise à jour de votre commentaire'
    redirect_to  recipe_path( @comment.recipe_id ), notice: msg
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to recipe_path(@comment.recipe_id ) , notice: 'Commentaire  supprimé.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:title, :content, :user_id , :recipe_id)
    end


    def check_owner
      @comment = Comment.find(params[:id])
      redirect_to root_path , :notice => "Petit-coquin!" unless current_user == @comment.user
    end
end
