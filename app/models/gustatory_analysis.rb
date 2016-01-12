class GustatoryAnalysis < ActiveRecord::Base
  belongs_to :tasting, inverse_of: :gustatory_analysis

  enum acidity: [:still, :fresh, :bright, :nervous, :green, :very_green]
  enum alcohol: [:diluted, :light, :relatively_generous, :generous, :relatively_hot, :hot, :burning]
  enum mellowness: [:biting, :steady, :melted, :round, :fat, :smooth]
  enum tannin_quantity: [:informed, :flowing, :soft, :tannic, :astringent, :harsh]
  enum tannin_quality: [:rude, :rough, :herbaceous, :silky, :fine]

  has_many :gustatory_natures, dependent: :destroy, inverse_of: :gustatory_analysis, autosave: true

  validates :tasting, presence: true

  def build_natures(nature_type, natures)
    natures.split(',').each do |nature|
      self.send(nature_type).build(nature: nature.strip.capitalize)
    end
  end
end
