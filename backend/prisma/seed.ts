import { PrismaClient, Role } from '@prisma/client'

const prisma = new PrismaClient()

const userData = [
  {
    firstName: 'Admin',
    lastName: 'Admin',
    email: 'admin@prisma.io',
    phone: '2435234',
    role: Role.ADMIN,
  },
]

async function main() {
  console.log(`Start seeding ...`);
  let count = 0;
  try {
    // await prisma.$connect();
    count = await prisma.user.count();
    console.log(`There are ${count} users in the database.`);
    for (const u of userData) {
      const user = await prisma.user.create({
        data: u,
      })
      console.log(`Created user with id: ${user.id}`)
    }
    count = await prisma.user.count();
    console.log(`There are ${count} users in the database.`);
    console.log(`Seeding finished.`)
  } catch (e) {
    console.log(e)
    await prisma.$disconnect()
  }
  await prisma.$disconnect()
}

await main()
// .catch(async (e) => {
//   console.log(e)
//   await prisma.$disconnect()
//   process.exit(1)
// })
// .finally(async () => {
//   console.log("finito")
//   await prisma.$disconnect()
// })

