class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one_attached :avatar
  has_one_attached :qr_code

  has_rich_text :content

  def age
    return unless date_of_birth.present?

    now = Time.now.utc.to_date
    now.year - date_of_birth.year - (date_of_birth.to_date.change(year: now.year) > now ? 1 : 0)
  end

  include Rails.application.routes.url_helpers

  after_create :generate_qr

  def generate_qr
    qr_url = url_for(controller: 'profile',
                     action: 'show',
                     id:,
                     only_path: false,
                     host: 'https://www.lifelinerecords.org/',
                     source: 'from_qr')
    qrcode = RQRCode::QRCode.new(qr_url)

    png = qrcode.as_png(
      resize_gte_to: false,
      resize_exactly_to: false,
      fill: 'white',
      color: 'black',
      size: 250,
      border_modules: 4,
      module_px_size: 6,
      file: nil # path to write
    )
    image_name = SecureRandom.hex
    File.binwrite("tmp/#{image_name}.png", png.to_s)

    blob = ActiveStorage::Blob.create_and_upload!(
      io: File.open("tmp/#{image_name}.png"),
      filename: image_name,
      content_type: 'png'
    )

    qr_code.attach(blob)
  end
end
