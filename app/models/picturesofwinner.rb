class Picturesofwinner < ActiveRecord::Base
  belongs_to :quest_item

  has_attached_file :photourl,
                    :path => ":rails_root/public/winners/:attachment/:id/:basename_:style.:extension",
                    :url => "/winners/:attachment/:id/:basename_:style.:extension",
                    :styles => {
                        :thumb    => ['200x200#',  :jpg, :quality => 66],
                        :preview  => ['480x480#',  :jpg, :quality => 88],
                        :large    => ['600>',      :jpg, :quality => 88],
                        :retina   => ['1200>',     :jpg, :quality => 100]
                    },
                    :convert_options => {
                        :thumb    => '-set colorspace sRGB -strip',
                        :preview  => '-set colorspace sRGB -strip',
                        :large    => '-set colorspace sRGB -strip',
                        :retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
                    }

  validates_attachment :photourl,
                       :presence => true,
                       :size => { :in => 0..10.megabytes },
                       :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }

end
