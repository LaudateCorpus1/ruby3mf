require 'mini_magick'

class Thumbnail3mf

  def self.parse(doc, relationship_file)
    Log3mf.context "Thumbnail3mf" do |l|

      img_type = MimeMagic.by_magic(relationship_file.get_input_stream)
      l.fatal_error :invalid_thumbnail_file unless img_type
      l.error(:invalid_thumbnail_file_type, type: img_type) unless ['image/png', 'image/jpeg'].include? img_type.type

      img_colorspace = MiniMagick::Image.read(relationship_file.get_input_stream).colorspace
      l.fatal_error :invalid_thumbnail_colorspace if img_colorspace.include? "CMYK"
    end
  end
end
