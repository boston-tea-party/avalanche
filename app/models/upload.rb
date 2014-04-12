require 'digest/sha2'

class Upload < ActiveRecord::Base
  has_attached_file :document

  after_create :save_attachment, :set_sha256, :persist_key

  def keyid
     sig = nil
     crypto.verify(signature){ | sig_ | sig = sig_ }
     sig.fpr
  end

  private

  # This is here because of a bug in Paperclip that we did not want to
  # chase down. We think.
  def save_attachment
    document.save
  end

  def set_sha256
    update_attribute(:sha256, compute_sha256)
  end

  def persist_key
      GPGME::Ctx.new do |ctx|
         ctx.import(GPGME::Data.new(public_key))
      end
  end

  def compute_sha256
    sha256er.hexdigest(read_document)
  end

  def sha256er
    Digest::SHA256.new
  end

  def read_document
    File.read(document.path)
  end

  def crypto
    GPGME::Crypto.new
  end
end
