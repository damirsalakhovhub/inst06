class Avo::Resources::Task < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :project, as: :belongs_to
    field :title, as: :text
    field :description, as: :textarea
    field :status, as: :text
    field :creator, as: :text
    field :assigned_user, as: :text
  end
end
