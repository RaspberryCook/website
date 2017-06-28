class CommentsController < ApplicationController
  before_filter :authenticate, :only =>  [:destroy , :update ,:create]
  before_filter :check_owner, :only =>  [:destroy , :update , :edit ]


  # POST /comments
  def create
    @comment = current_user.comments.create(comment_params)

    if @comment.save
      flash[:success] = 'Votre commentaire à été correctement ajouté!'
    else
      flash[:danger] = 'Une erreure est survenue dans l\'ajout de votre commentaire'
    end
    redirect_to  recipe_path(@comment.recipe_id)
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      flash[:success] = 'Votre commentaire à été correctement mis à jour!'
    else
      flash[:danger] = 'Une erreure est survenue dans la mise à jour de votre commentaire'
    end
    redirect_to  recipe_path(@comment.recipe_id)
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    flash[:success] = 'Commentaire  supprimé.'
    redirect_to recipe_path(@comment.recipe_id)
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:title, :content , :recipe_id, :rate)
    end


    def check_owner
      @comment = Comment.find(params[:id])
      redirect_to root_path , :notice => "Petit-coquin!" unless current_user == @comment.user
    end
end
