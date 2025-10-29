class Avo::Resources::Project < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :organization, as: :belongs_to
    field :name, as: :text
    field :description, as: :textarea
  end
end
