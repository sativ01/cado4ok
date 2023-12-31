import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
  console.log("Searching users")
  const user = await prisma.user.findMany();
  console.log(`Found user: ${user}`)
}

await main()
  .catch(e => {
    console.log(e)
    process.exit(1)
  })
  .finally(async () => {
    console.log("Finito")
    await prisma.$disconnect()
  })

