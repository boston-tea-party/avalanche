require 'net/http/post/multipart'

class DocumentUpdater
  def initialize(host, port)
    @host = host
    @port = port
  end

  def update
    desired_shas.each { |sha| send_file_for(sha) }
  end

  private

  attr_reader :host, :port

  def sha_list
    Upload.all.pluck('sha256')
  end

  def desired_shas
    response = Net::HTTP.start(host, port) do |http|
      post = Net::HTTP::Post.new("/checks")
      post.body = { shas: sha_list }.to_json
      post.content_type = 'application/json'
      http.request(post)
    end

    if response.is_a?(Net::HTTPOK)
      JSON.parse(response.body)['shas']
    else
      []
    end
  end

  def send_file_for(sha)
    upload = Upload.find_by_sha256(sha)
    File.open(upload.document.path) do |file|
      upload_io = UploadIO.new(
        file, upload.document.content_type, upload.document.original_filename)
      req = Net::HTTP::Post::Multipart.new('/uploads', 'upload[document]' => upload_io)
      Net::HTTP.start(host, port) do |http|
        http.request(req)
      end
    end
  end
end
