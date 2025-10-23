-- CreateEnum
CREATE TYPE "EvolutionTime" AS ENUM ('MORNING', 'DAY', 'NIGHT');

-- CreateEnum
CREATE TYPE "GamePokemonAvailability" AS ENUM ('CHOICE', 'EVENT', 'EXTERNAL', 'NATIVE', 'UNAVAILABLE');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE', 'UNKNOWN');

-- CreateTable
CREATE TABLE "Console" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Console_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Evolution" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "afterId" INTEGER NOT NULL,
    "beforeId" INTEGER NOT NULL,
    "friendshipLevel" INTEGER,
    "heldItem" TEXT,
    "item" TEXT,
    "letsGoSteps" INTEGER,
    "level" INTEGER,
    "location" TEXT,
    "move" TEXT,
    "region" TEXT,
    "time" "EvolutionTime",
    "trade" BOOLEAN NOT NULL DEFAULT false,
    "unique" TEXT,

    CONSTRAINT "Evolution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Game" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "generation" INTEGER NOT NULL,
    "releaseDate" TIMESTAMP(3) NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "Game_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameCompatiblePokemon" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "availability" "GamePokemonAvailability" NOT NULL,
    "availabilityInfo" TEXT,
    "gameId" INTEGER NOT NULL,
    "pokemonId" INTEGER NOT NULL,
    "shinyInfo" TEXT,
    "shinyLocked" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "GameCompatiblePokemon_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pokemon" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "canBeShiny" BOOLEAN NOT NULL DEFAULT true,
    "gender" "Gender" NOT NULL,
    "imageUrl" TEXT NOT NULL,
    "speciesFormId" INTEGER NOT NULL,

    CONSTRAINT "Pokemon_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RegionDexSpecies" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "index" INTEGER NOT NULL,
    "speciesId" INTEGER NOT NULL,

    CONSTRAINT "RegionDexSpecies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Species" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "dexNum" INTEGER NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Species_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SpeciesForm" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "isSpeciesDefault" BOOLEAN NOT NULL DEFAULT true,
    "name" TEXT NOT NULL,
    "prefix" TEXT,
    "speciesId" INTEGER NOT NULL,

    CONSTRAINT "SpeciesForm_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ConsoleToGame" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_ConsoleToGame_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "_EvolutionToGame" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_EvolutionToGame_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "_GameToRegionDexSpecies" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_GameToRegionDexSpecies_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "_GameChoiceLocks" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_GameChoiceLocks_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "Console_name_key" ON "Console"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Game_title_key" ON "Game"("title");

-- CreateIndex
CREATE UNIQUE INDEX "Species_dexNum_key" ON "Species"("dexNum");

-- CreateIndex
CREATE INDEX "_ConsoleToGame_B_index" ON "_ConsoleToGame"("B");

-- CreateIndex
CREATE INDEX "_EvolutionToGame_B_index" ON "_EvolutionToGame"("B");

-- CreateIndex
CREATE INDEX "_GameToRegionDexSpecies_B_index" ON "_GameToRegionDexSpecies"("B");

-- CreateIndex
CREATE INDEX "_GameChoiceLocks_B_index" ON "_GameChoiceLocks"("B");

-- AddForeignKey
ALTER TABLE "Evolution" ADD CONSTRAINT "Evolution_afterId_fkey" FOREIGN KEY ("afterId") REFERENCES "Pokemon"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Evolution" ADD CONSTRAINT "Evolution_beforeId_fkey" FOREIGN KEY ("beforeId") REFERENCES "Pokemon"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCompatiblePokemon" ADD CONSTRAINT "GameCompatiblePokemon_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCompatiblePokemon" ADD CONSTRAINT "GameCompatiblePokemon_pokemonId_fkey" FOREIGN KEY ("pokemonId") REFERENCES "Pokemon"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pokemon" ADD CONSTRAINT "Pokemon_speciesFormId_fkey" FOREIGN KEY ("speciesFormId") REFERENCES "SpeciesForm"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RegionDexSpecies" ADD CONSTRAINT "RegionDexSpecies_speciesId_fkey" FOREIGN KEY ("speciesId") REFERENCES "Species"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpeciesForm" ADD CONSTRAINT "SpeciesForm_speciesId_fkey" FOREIGN KEY ("speciesId") REFERENCES "Species"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ConsoleToGame" ADD CONSTRAINT "_ConsoleToGame_A_fkey" FOREIGN KEY ("A") REFERENCES "Console"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ConsoleToGame" ADD CONSTRAINT "_ConsoleToGame_B_fkey" FOREIGN KEY ("B") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EvolutionToGame" ADD CONSTRAINT "_EvolutionToGame_A_fkey" FOREIGN KEY ("A") REFERENCES "Evolution"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EvolutionToGame" ADD CONSTRAINT "_EvolutionToGame_B_fkey" FOREIGN KEY ("B") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GameToRegionDexSpecies" ADD CONSTRAINT "_GameToRegionDexSpecies_A_fkey" FOREIGN KEY ("A") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GameToRegionDexSpecies" ADD CONSTRAINT "_GameToRegionDexSpecies_B_fkey" FOREIGN KEY ("B") REFERENCES "RegionDexSpecies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GameChoiceLocks" ADD CONSTRAINT "_GameChoiceLocks_A_fkey" FOREIGN KEY ("A") REFERENCES "GameCompatiblePokemon"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GameChoiceLocks" ADD CONSTRAINT "_GameChoiceLocks_B_fkey" FOREIGN KEY ("B") REFERENCES "Pokemon"("id") ON DELETE CASCADE ON UPDATE CASCADE;
