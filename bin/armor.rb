require 'openssl'
class ArmoredCar
  def target
    cipher = OpenSSL::Cipher.new('aes-256-cbc')
    cipher.encrypt
    key = cipher.random_key
    iv = cipher.random_iv
    @file = gets.chomp!
    buf = ""
    File.open(@file, "wb") do |outf|
      File.open(@file, "rb") do |inf|
        while inf.read(4096, buf)
          outf << cipher.update(buf)
        end
        outf << cipher.final
      end
    end
    #Decryption
    #openssl enc aes-256-cbc -d -in file.txt.enc -out file.txt
  end
  
  def dispatch
  end
end

x = ArmoredCar.new()
x.target