-- DropForeignKey
ALTER TABLE "Kid" DROP CONSTRAINT "Kid_groupId_fkey";

-- AlterTable
ALTER TABLE "Kid" ALTER COLUMN "groupId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Kid" ADD CONSTRAINT "Kid_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE SET NULL ON UPDATE CASCADE;
