defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.TopicModel, as: Topic

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    IO.inspect(changeset)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic_model" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"topic_model" => topic, "id" => topic_id}) do
    topic_rec = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic_rec, topic)
    case Repo.update(changeset) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: topic_rec)
    end
  end
end
