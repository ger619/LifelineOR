class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one_attached :avatar
  has_one_attached :qr_code

  include Rails.application.routes.url_helpers

  after_create :generate_qr

  def generate_qr
    qr_url = url_for(controller: 'profile',
                     action: 'show',
                     id:,
                     only_path: false,
                     host: 'https://127.0.0.1/',
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
