class JoinsController < ApplicationController
  def index
    matching_joins = Join.all

    @list_of_joins = matching_joins.order({ :created_at => :desc })

    render({ :template => "joins/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_joins = Join.where({ :id => the_id })

    @the_join = matching_joins.at(0)

    render({ :template => "joins/show.html.erb" })
  end

  def create
    the_join = Join.new
    the_join.user_id = params.fetch("query_user_id")
    the_join.workout_id = params.fetch("query_workout_id")

    if the_join.valid?
      the_join.save
      redirect_to("/joins", { :notice => "Join created successfully." })
    else
      redirect_to("/joins", { :alert => the_join.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_join = Join.where({ :id => the_id }).at(0)

    the_join.user_id = params.fetch("query_user_id")
    the_join.workout_id = params.fetch("query_workout_id")

    if the_join.valid?
      the_join.save
      redirect_to("/joins/#{the_join.id}", { :notice => "Join updated successfully."} )
    else
      redirect_to("/joins/#{the_join.id}", { :alert => the_join.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_join = Join.where({ :id => the_id }).at(0)

    the_join.destroy

    redirect_to("/joins", { :notice => "Join deleted successfully."} )
  end
end
