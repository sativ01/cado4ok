import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
  console.log(`Start seeding ...`);
  try {
    console.log('Create School')
    await prisma.user.deleteMany()
    await prisma.school.deleteMany()
    const parentUser = await prisma.user.create({
      data: {
        firstName: "Parent",
        lastName: "Parent",
        email: "parent1@parent.com",
        phone: "111-111-111"
      }
    });
    const teacher = await prisma.user.create({
      data: {
        firstName: "Teacher",
        lastName: "Teacher",
        email: "teacher1@alpha.schrool",
        phone: "1010-1010"
      }
    });

    await prisma.school.create({
      data: {
        name: "Alpha School",
        address: "Alpha 1, city",
        email: "director@alpha.school",
        groups: {
          create: [{
            id: "groupAId",
            name: "GroupA"
          }]
        },
        parents: {
          create: [{
            user: {
              connect: parentUser
            },
            kids: {
              create: [{
                name: "Kid1",
                hasDailyLunch: true,
              }]
            }
          }]
        },
        teachers: {
          create: [{
            user: { connect: teacher },
            groups: { connect: { id: "groupAId" } }
          }],
        },
      }
    })
    const groupA = await prisma.group.findFirst();
    await prisma.kid.updateMany({ where: { name: "Kid1" }, data: { groupId: groupA?.id } })
  } catch (e) {
    console.log(e)
    await prisma.$disconnect()
  }
  await prisma.$disconnect()
}

await main()
