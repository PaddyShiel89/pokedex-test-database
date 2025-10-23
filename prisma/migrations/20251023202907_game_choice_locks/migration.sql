/*
  Warnings:

  - You are about to drop the `_GameChoiceLocks` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."_GameChoiceLocks" DROP CONSTRAINT "_GameChoiceLocks_A_fkey";

-- DropForeignKey
ALTER TABLE "public"."_GameChoiceLocks" DROP CONSTRAINT "_GameChoiceLocks_B_fkey";

-- DropTable
DROP TABLE "public"."_GameChoiceLocks";

-- CreateTable
CREATE TABLE "GameChoiceLocks" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GameChoiceLocks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_GameToGameChoiceLocks" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_GameToGameChoiceLocks_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "_GameChoiceLocksToPokemon" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_GameChoiceLocksToPokemon_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "_GameToGameChoiceLocks_B_index" ON "_GameToGameChoiceLocks"("B");

-- CreateIndex
CREATE INDEX "_GameChoiceLocksToPokemon_B_index" ON "_GameChoiceLocksToPokemon"("B");

-- AddForeignKey
ALTER TABLE "_GameToGameChoiceLocks" ADD CONSTRAINT "_GameToGameChoiceLocks_A_fkey" FOREIGN KEY ("A") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GameToGameChoiceLocks" ADD CONSTRAINT "_GameToGameChoiceLocks_B_fkey" FOREIGN KEY ("B") REFERENCES "GameChoiceLocks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GameChoiceLocksToPokemon" ADD CONSTRAINT "_GameChoiceLocksToPokemon_A_fkey" FOREIGN KEY ("A") REFERENCES "GameChoiceLocks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GameChoiceLocksToPokemon" ADD CONSTRAINT "_GameChoiceLocksToPokemon_B_fkey" FOREIGN KEY ("B") REFERENCES "Pokemon"("id") ON DELETE CASCADE ON UPDATE CASCADE;
