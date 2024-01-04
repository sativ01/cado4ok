import { Prisma, PrismaClient } from '@prisma/client'
import fastify from 'fastify'
import cors from '@fastify/cors'

const prisma = new PrismaClient()
const app = fastify({ logger: true })
await app.register(cors, { origin: '*' })

// app.post<{
//   Body: ICreatePostBody
// }>(`/post`, async (req, res) => {
//   const { title, content, authorEmail } = req.body
//   const result = await prisma.post.create({
//     data: {
//       title,
//       content,
//       author: { connect: { email: authorEmail } },
//     },
//   })
//   return result
// })

// app.put<{
//   Params: IPostByIdParam
// }>('/post/:id/views', async (req, res) => {
//   const { id } = req.params

//   try {
//     const post = await prisma.post.update({
//       where: { id: Number(id) },
//       data: {
//         viewCount: {
//           increment: 1,
//         },
//       },
//     })

//     return post
//   } catch (error) {
//     return { error: `Post with ID ${id} does not exist in the database` }
//   }
// })

// app.put<{
//   Params: IPostByIdParam
// }>('/publish/:id', async (req, res) => {
//   const { id } = req.params

//   try {
//     const postData = await prisma.post.findUnique({
//       where: { id: Number(id) },
//       select: {
//         published: true,
//       },
//     })

//     const updatedPost = await prisma.post.update({
//       where: { id: Number(id) || undefined },
//       data: { published: !postData?.published },
//     })
//     return updatedPost
//   } catch (error) {
//     return { error: `Post with ID ${id} does not exist in the database` }
//   }
// })

// app.delete<{
//   Params: IPostByIdParam
// }>(`/post/:id`, async (req, res) => {
//   const { id } = req.params
//   const post = await prisma.post.delete({
//     where: {
//       id: Number(id),
//     },
//   })
//   return post
// })

// app.get('/users', async (req, res) => {
//   const users = await prisma.user.findMany()
//   return users
// })

// app.get<{
//   Params: IPostByIdParam
// }>('/user/:id/drafts', async (req, res) => {
//   const { id } = req.params

//   const drafts = await prisma.user
//     .findUnique({
//       where: { id: Number(id) },
//     })
//     .posts({
//       where: { published: false },
//     })

//   return drafts
// })

// app.get<{
//   Params: IPostByIdParam
// }>(`/post/:id`, async (req, res) => {
//   const { id } = req.params

//   const post = await prisma.post.findUnique({
//     where: { id: Number(id) },
//   })
//   return post
// })

// app.get<{
//   Querystring: IFeedQueryString
// }>('/feed', async (req, res) => {
//   const { searchString, skip, take, orderBy } = req?.query

//   const or: Prisma.PostWhereInput = searchString
//     ? {
//       OR: [
//         { title: { contains: searchString as string } },
//         { content: { contains: searchString as string } },
//       ],
//     }
//     : {}

//   const posts = await prisma.post.findMany({
//     where: {
//       published: true,
//       ...or,
//     },
//     include: { author: true },
//     take: Number(take) || undefined,
//     skip: Number(skip) || undefined,
//     orderBy: {
//       updatedAt: orderBy as Prisma.SortOrder,
//     },
//   })

//   return posts
// })
// interface IFeedQueryString {
//   searchString: string | null
//   skip: number | null
//   take: number | null
//   orderBy: Prisma.SortOrder | null
// }

// interface IPostByIdParam {
//   id: number
// }

// interface ICreatePostBody {
//   title: string
//   content: string | null
//   authorEmail: string
// }
//

interface IGetParentDashboard {
  userId: string
}

app.get<{
  Params: IGetParentDashboard
}>('/user/:id/dashboard', async (req, _res) => {
  const { userId } = req.params

  const parentUserKids = await prisma.parent
    .findUnique({
      where: { userId },
    }).kids();

  return parentUserKids
})

app.get<{
  Params: IGetParentDashboard
}>('/testParentId', async (_req, _res) => {

  const testParentId = await prisma.parent.findFirst();
  return testParentId?.userId
})


app.listen({ port: 3000 }, (err) => {
  if (err) {
    console.error(err)
    process.exit(1)
  }
  console.log(`
  🚀 Server ready at: http://localhost:3000
  ⭐️ See sample requests: http://pris.ly/e/ts/rest-fastify#3-using-the-rest-api`)
})

