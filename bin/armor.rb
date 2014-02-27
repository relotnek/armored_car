require 'rbnacl'

class ArmoredCar
  def loader()

    private_key = File.open("/Users/kentoler/Desktop/privatekey")
    public_key = File.open("/Users/kentoler/Desktop/publickey")
    # initialize the box
    box = RbNaCl::Box.new(File.read(public_key), File.read(private_key))
    
    nonce = RbNaCl::Random.random_bytes(box.nonce_bytes)
    
    message = gets.chomp
    ciphertext = box.encrypt(nonce, message)
    
    encryptedmessage = File.new("/Users/kentoler/Desktop/encrypted", "w+")
    File.write(encryptedmessage, ciphertext)

  end
  
  def unloader(file)
    #open / decrypt file
    
    #instantiates secret box named car
    # decrypt a message
    # NB: Same nonce used here.
    decrypted_message = other_box.decrypt(nonce, ciphertext)
    #=> "..."

    # But if the ciphertext has been tampered with:
    other_box.open(nonce, corrupted_ciphertext)
    #=> RbNaCl::CryptoError exception is raised.
    # Chosen ciphertext attacks are prevented by authentication and constant-time comparisons
    
  end
  
  def transport
    #send file
  end
  
  def generate
    #Tool for generating public and private keys
    #Tool for generating public and private keys
    private_key = RbNaCl::PrivateKey.generate
    public_key = private_key.public_key
    
    privkeystore = File.new("/Users/kentoler/Desktop/privatekey", "w+")
    pubkeystore = File.new("/Users/kentoler/Desktop/publickey", "w+")
    
    File.write(privkeystore, private_key)
    File.write(pubkeystore, public_key)
  end
  
end


x = ArmoredCar.new()
x.loader
