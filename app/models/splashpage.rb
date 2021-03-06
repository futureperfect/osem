class Splashpage < ActiveRecord::Base
  belongs_to :conference

  has_paper_trail ignore: [:updated_at], meta: { conference_id: :conference_id }

  mount_uploader :picture, PictureUploader, mount_on: :banner_file_name

  validate :single_show_by_default, if: :show_by_default

  private

  def single_show_by_default
    # Only allow a single splashpage to be shown by default
    default_splashpage = Splashpage.find_by(show_by_default: true)

    if !default_splashpage || self == default_splashpage
      return
    end

    errors.add :show_by_default, 'Only one conference may be shown by default'
  end
end
