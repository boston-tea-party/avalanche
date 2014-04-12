class UploadDiff
  def initialize(available_shas)
    @available_shas = available_shas
  end

  def missing
    @available_shas - Upload.all.pluck(:sha256).to_a
  end
end
