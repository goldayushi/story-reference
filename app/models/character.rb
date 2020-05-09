class Character < ApplicationRecord
	validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
	validates :role, presence: false, length: { maximum: 50 }
	validates :position, length: { maximum: 100 }
	validates :countory, length: { maximum: 50 }
	validates :birthplace, length: { maximum: 50 }

	scope :search, -> (search_params) do
		return if search_params.blank?
		
		name_like(search_params[:name])
      .role_like(search_params[:role])
      .position_like(search_params[:position])
      .countory_like(search_params[:countory])
			.birthplace_like(search_params[:birthplace])
	end

	scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :role_like, -> (role) { where('role LIKE ?', "%#{role}%") if role.present? }
  scope :position_like, -> (position) { where('position LIKE ?', "%#{position}%") if position.present? }
  scope :countory_like, -> (countory) { where('position LIKE ?', "%#{countory}%") if countory.present? }
  scope :birthplace_like, -> (birthplace) { where('position LIKE ?', "%#{birthplace}%") if birthplace.present? }
end
