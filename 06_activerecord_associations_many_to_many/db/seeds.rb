lennon = Dog.create(
  name: "Lennon",
  birthdate: "2020-08-31",
  breed: "Pomeranian", 
  image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1609370267/dakota-and-lennon-square-compressed_hoenfo.jpg"
)
olivia = Dog.create(
  name: "Olivia",	
  birthdate: "2018-03-31",
  breed:	"Terrier",
  image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229064/zx6CPsp_d_utkmww.webp"
)

# create a couple of walks and feedings for Lennon 
lennon.walks.create(time: 7.hours.ago)
lennon.walks.create(time: 10.hours.ago)

lennon.feedings.create(time: 30.minutes.ago)

# create a couple of walks and feedings for Olivia
olivia.walks.create(time: 15.minutes.ago)
olivia.feedings.create(time: 2.hours.ago)