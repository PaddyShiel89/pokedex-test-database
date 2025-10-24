-- AlterTable
ALTER TABLE "SpeciesForm" ADD COLUMN     "gendersUnique" BOOLEAN NOT NULL DEFAULT false;

-- DropEnum
DROP TYPE "public"."EvolutionTime";
