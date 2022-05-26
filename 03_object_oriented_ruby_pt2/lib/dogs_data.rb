# ✅ The information in the $dogs variable is now going to be stored within the Dog class, so we don't need to store it in two places
# So, let's remove the map at the end of the file so that we still have access to the data within these hashes for the purpose of creating dog instances using the Dog class
$dogs = [
  {
    name: "Olivia",	
    age: "4 years",
    breed:	"Terrier",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229064/zx6CPsp_d_utkmww.webp"
  },
  {
    name: "Molly",	
    age: "3 years",
    breed:	"Terrier / Chihuahua",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229038/EEE90-E50-25-F0-4-DF0-98-B2-0-E0-B6-F9-BAA89_menwgg.jpg"  
  },
  {
    name: "Kaya",	
    age: "4 years",
    breed:	"Blueheeler",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229011/8136c615d670e214f80de4e7fcdf8607--cattle-dogs-mans_vgyqqa.jpg"
  },
  {
    name: "Chop",	
    age: "almost 2 years",
    breed:	"German Shorthaired Pointer",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822267/cdbd77592e3ef91e8cc1cf67d936f94f_fkozjt.jpg"
  },
  {
    name: "Baron",	
    age: "9 years",
    breed:	"GSD/English Lab mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629567379/baron_x0s6ai.jpg"
  },
  {
    name: "Lennon Snow",
    age: "1 year",
    breed: "Pomeranian",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1627585625/lennon-with-tennis-ball_slg2zn.jpg"
  },
  {
    name: "Ash",
    age: "2 years",
    breed: "Husky",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229192/photo-1568572933382-74d440642117_p6mrgm.jpg"
  },
  {
    name: "DJ", 
    age: "2 years",
    breed: "Dachsund Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822169/365758759_qyupo8.jpg"
  },
  {
    name: "Winter",
    age: "9 years",
    breed: "Husky Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822144/561229495_lldnll.jpg"
  },
  {
    name: "CeCe",
    age: "3 years",
    breed: "Lab mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629821709/ee7eee7ee62c9c2b053e65dc9c9e1a55_iwjweh.jpg"
  },
  {
    name: "Kane",
    age: "1 year",
    breed: "Terrier Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629821681/2_lu9ccw.jpg"
  },
  {
    name: "Nutmeg",
    age: "4 months",
    breed: "Lab Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822016/Nutmegupdate97_kyqlqo.jpg"
  },
  {
    name: "Sadie",
    age: "8 months",
    breed: "Lab/Terrier Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822095/55860f51e40159e2c34766352b214c36_g3plyx.jpg"
  },
  {
    name: "Sal",
    age: "2 years",
    breed: "Lab Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822067/83c97c9fe7d2d82ce90c1d8ca9fde44c_zckdjy.jpg"
  },
  {
    name: "Sinton",
    age: "2 years",
    breed: "Terrier Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629821474/4_bbgw1p.jpg"
  },
  {
    name: "Cupcake",
    age: "2 months",
    breed: "???",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229142/it-s-national-dog-day-dogs-41538267-400-400_fvq8wk.jpg"
  },
  {
    name: "Luci",
    age: "2 years",
    breed: "Samoyed",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822371/f6p9jE2_acndnl.jpg"
  },
  {
    name: "Simon",
    age: "6 years",
    breed: "Shiba Inu",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822438/B3-FAF888-5656-4746-BE22-597185404078_bpbvvs.jpg"
  },
  {
    name: "Snoopy",
    age: "22 years",
    breed: "Snooop",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822337/sn-color_qesmhx.jpg"
  }
].map do |dog_hash|
  Dog.new(
    dog_hash[:name],
    dog_hash[:age],
    dog_hash[:breed],
    dog_hash[:image_url]
  )
end