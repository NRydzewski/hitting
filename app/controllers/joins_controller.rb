class JoinsController < ApplicationController
  def index
    matching_joins = Join.all

    @list_of_joins = matching_joins.order({ :created_at => :desc })

    @my_joins=@list_of_joins.where({:user_id=>session.fetch(:user_id)})

    render({ :template => "workouts/joined.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_joins = Join.where({ :id => the_id })

    @the_join = matching_joins.at(0)

    render({ :template => "joins/show.html.erb" })
  end

  def create
    the_join = Join.new
    the_join.user_id = session.fetch(:user_id)
    the_join.workout_id=params.fetch("query_workout_id")

    if the_join.valid?
      the_join.save
      redirect_to("/", { :notice => "Join created successfully." })
    else
      redirect_to("/", { :alert => "Error occurred while trying to join" })
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
    the_workout_id=params.fetch("query_workout_id")
    the_user_id=params.fetch("query_user_id")
    the_join=Join.where({:workout_id=>the_workout_id, :user_id=>the_user_id}).at(0)

    the_join.destroy

    redirect_to("/", {:notice=>"You successfully left this workout session"})
  end
end
