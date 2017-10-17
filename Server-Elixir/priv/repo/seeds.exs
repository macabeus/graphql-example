# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Myapp.Repo.insert!(%Myapp.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.

alias Myapp.User
alias Myapp.Post
alias Myapp.Repo
alias Myapp.Like

%User{}
|> User.registration_changeset(%{name: "Ryan Swapp", username: "ryan", password: "ryan"})
|> Repo.insert!

%User{}
|> User.registration_changeset(%{name: "Bruno Macabeus", username: "macabeus", password: "macabeus"})
|> Repo.insert!

for _ <- 1..10 do
  %Post{}
  |> Post.changeset(%{
    title: Faker.Lorem.sentence,
    body: Faker.Lorem.paragraph,
    user_id: Enum.random(1..2)})
  |> Repo.insert!
end

for post_index <- 1..10 do
  for user_index <- 1..2 do
    if Enum.random(0..1) == 0 do
      %Like{}
      |> Like.changeset(%{post_id: post_index, user_id: user_index})
      |> Repo.insert!
    end
  end
end
