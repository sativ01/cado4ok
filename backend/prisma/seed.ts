import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
  console.log(`Start seeding ...`);
  try {
    console.log('Create School')
    await prisma.school.deleteMany()
    await prisma.school.create({
      data: {
        name: "Alpha School",
        address: "Alpha 1, city",
        email: "director@alpha.school",
        teachers: {
          create: [{
            user: {
              create: [{
                firstName: "teacher1",
                email: "teacher1@alpha.school",
                phone: `${Math.floor(Math.random() * 1_000_000)}`
              }]
            }
          }]
        },
      }
    })
  } catch (e) {
    console.log(e)
    await prisma.$disconnect()
  }
  await prisma.$disconnect()
}

await main()
