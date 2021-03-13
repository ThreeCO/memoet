defmodule Memoet.Notes do

  import Ecto.Query

  alias Memoet.Repo
  alias Memoet.Notes.Note

  @spec list_notes(binary(), map) :: [Note.t()]
  def list_notes(deck_id, _params) do
    Note
    |> where(deck_id: ^deck_id)
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @spec get_note!(binary(), binary()) :: Note.t()
  def get_note!(id, user_id) do
    Note
    |> Repo.get_by!(id: id, user_id: user_id)
  end

  @spec create_note(map()) :: {:ok, Note.t()} | {:error, Ecto.Changeset.t()}
  def create_note(attrs \\ %{}) do
    %Note{}
    |> Note.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_note(Note.t(), map()) :: {:ok, Note.t()} | {:error, Ecto.Changeset.t()}
  def update_note(%Note{} = note, attrs) do
    note
    |> Note.changeset(attrs)
    |> Repo.update()
  end
end