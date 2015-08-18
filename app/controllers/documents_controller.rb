class DocumentsController < ApplicationController
  def index
    @document = Document.new
  end

  def create
    cipher_encryptor = CipherEncryptor.new(nil, document_params[:content])
    cipher_encryptor.encode
    cipher = Cipher.create content: cipher_encryptor.pwd
    @document = Document.new document_params
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
    @cipher_encryptor = CipherEncryptor.new(@document.cipher.content.split(","), @document.content)
    @cipher_encryptor.decode
  end

  private
  def document_params
    params.require(:document).permit Document::DEFAULT_ATTRIBUTES
  end
end
