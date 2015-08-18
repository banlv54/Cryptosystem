class DocumentsController < ApplicationController
  require 'open-uri'

  def index
    @document = Document.new
  end

  def create
    import_database and return if params[:link]
    cipher_encryptor = CipherEncryptor.new(nil, document_params[:content], params[:type])
    cipher_encryptor.encode
    cipher = Cipher.create content: cipher_encryptor.pwd,
      max_length: cipher_encryptor.max_length
    @document = Document.new document_params.merge encryption_type: params[:type]
    @document.cipher = cipher
    @document.content = cipher_encryptor.document
    if @document.save
      redirect_to root_path(notice: true)
    else
      redirect_to root_path(notice: false)
    end
  end

  def show
    @document = Document.find params[:id]
    @cipher_encryptor = CipherEncryptor.new(@document.cipher.content.split(","),
      @document.content, @document.encryption_type)
    @cipher_encryptor.decode
  end

  def destroy
    Document.find(params[:id]).destroy
    redirect_to documents_path
  end

  private
  def document_params
    params.require(:document).permit Document::DEFAULT_ATTRIBUTES
  end

  def import_database
    doc = Nokogiri::HTML(open(params[:link]))
      .css("div#ctl00_IDContent_ctl00_divContent").text.squeeze
    count = KeyPair.count
    KeyPair.import_databases doc
    redirect_to root_path(count: KeyPair.count - count)
  end
end
